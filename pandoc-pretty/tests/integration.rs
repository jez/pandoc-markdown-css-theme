use assert_cmd::Command;
use predicates::str::contains;
use std::fs;
use std::io::Write;
use std::os::unix::fs::PermissionsExt;
use std::path::PathBuf;
use std::process;
use tempfile::tempdir;

fn katex_fixture_url() -> String {
    format!(
        "file://{}",
        PathBuf::from(env!("CARGO_MANIFEST_DIR"))
            .join("tests")
            .join("fixtures")
            .join("katex")
            .display()
    )
}

fn make_fake_pandoc(dir: &PathBuf) -> PathBuf {
    let fake = dir.join("pandoc");
    let mut file = fs::File::create(&fake).expect("create fake pandoc");
    writeln!(
        file,
        r#"#!/bin/sh
if [ "$1" = "--version" ]; then
  echo "fake pandoc 0.0.0"
  exit 0
fi
all="$*"
out=
while [ $# -gt 0 ]; do
  if [ "$1" = "--output" ]; then shift; out="$1"; fi
  shift
done
[ -z "$out" ] && {{ echo "no --output given" >&2; exit 1; }}
printf "<!--ARGS:%s-->\n<html>fake</html>\n" "$all" > "$out"
exit 0
"#
    )
    .expect("write fake pandoc");
    let mut perms = fs::metadata(&fake).unwrap().permissions();
    perms.set_mode(0o755);
    fs::set_permissions(&fake, perms).unwrap();
    fake
}

#[test]
fn writes_default_output_when_not_provided() {
    let tmp = tempdir().unwrap();
    let dir = tmp.path().to_path_buf();
    let fake = make_fake_pandoc(&dir);

    let input = dir.join("note.md");
    fs::write(&input, "# Title\n\nBody").unwrap();

    let mut cmd = Command::new(assert_cmd::cargo::cargo_bin!("pandoc-pretty"));
    cmd.arg(&input)
        .env("PANDOC_PRETTY_KATEX", katex_fixture_url())
        .env(
            "PATH",
            format!(
                "{}:{}",
                dir.display(),
                std::env::var("PATH").unwrap_or_default()
            ),
        );

    cmd.assert().success();

    let expected_output = dir.join("note.html");
    let html = fs::read_to_string(&expected_output).expect("output exists");
    assert!(html.contains("fake</html>"));

    // ensure fake was used (no real pandoc needed)
    assert!(fs::metadata(&fake).unwrap().is_file());
}

fn ensure_real_pandoc_available() {
    let status = process::Command::new("pandoc")
        .arg("--version")
        .stdout(std::process::Stdio::null())
        .stderr(std::process::Stdio::null())
        .status()
        .expect("failed to spawn pandoc check");
    assert!(
        status.success(),
        "pandoc not found on PATH; install pandoc to run integration embedding test"
    );
}

#[test]
fn real_pandoc_embeds_assets_and_template() {
    ensure_real_pandoc_available();

    let tmp = tempdir().unwrap();
    let dir = tmp.path();
    let input = PathBuf::from(env!("CARGO_MANIFEST_DIR"))
        .join("tests")
        .join("fixtures")
        .join("full.md");
    let output = dir.join("full.html");

    let mut cmd = Command::new(assert_cmd::cargo::cargo_bin!("pandoc-pretty"));
    cmd.arg(&input)
        .arg(&output)
        .env("PANDOC_PRETTY_KATEX", katex_fixture_url());
    cmd.assert().success();

    let html = fs::read_to_string(&output).unwrap();

    assert!(
        html.contains("pandoc-markdown-css-theme"),
        "template marker missing"
    );
    assert!(
        html.contains("--color-sidenote"),
        "embedded CSS not found (color variable missing)"
    );
    assert!(
        html.contains("class=\"sidenote\"") || html.contains("class=\"marginnote\""),
        "sidenote markup missing; lua filter likely not applied"
    );
    assert!(
        !html.contains("docs/css/theme.css") && !html.contains("skylighting-solarized-theme.css"),
        "output still references external CSS files"
    );
    assert!(
        !html.contains("href=\"/tmp"),
        "output still references temp file paths"
    );
}

#[test]
fn errors_when_pandoc_missing() {
    let tmp = tempdir().unwrap();
    let dir = tmp.path();
    let input = dir.join("foo.md");
    fs::write(&input, "text").unwrap();
    let output = dir.join("bar.html");

    let mut cmd = Command::new(assert_cmd::cargo::cargo_bin!("pandoc-pretty"));
    cmd.arg(&input).arg(&output).env("PATH", "");

    cmd.assert()
        .failure()
        .code(127)
        .stderr(contains("pandoc not found"));
}

#[test]
fn adds_fallback_title_and_embeds_resources() {
    let tmp = tempdir().unwrap();
    let dir = tmp.path().to_path_buf();
    let fake = make_fake_pandoc(&dir);

    let input = dir.join("readme.md");
    fs::write(&input, "No title here").unwrap();

    let mut cmd = Command::new(assert_cmd::cargo::cargo_bin!("pandoc-pretty"));
    cmd.arg(&input)
        .env("PANDOC_PRETTY_KATEX", katex_fixture_url())
        .env(
            "PATH",
            format!(
                "{}:{}",
                dir.display(),
                std::env::var("PATH").unwrap_or_default()
            ),
        );

    cmd.assert().success();

    let output = dir.join("readme.html");
    let html = fs::read_to_string(&output).unwrap();
    assert!(html.contains("--embed-resources"));
    assert!(html.contains("--standalone"));
    assert!(html.contains("--metadata title=readme"));
    // Should still include fake marker
    assert!(html.contains("fake</html>"));

    assert!(fs::metadata(&fake).unwrap().is_file());
}

#[test]
fn aborts_when_user_declines_overwrite() {
    let tmp = tempdir().unwrap();
    let dir = tmp.path().to_path_buf();
    let fake = make_fake_pandoc(&dir);

    let input = dir.join("note.md");
    fs::write(&input, "# Title\n\nBody").unwrap();

    let output = dir.join("note.html");
    fs::write(&output, "keep".as_bytes()).unwrap();

    let mut cmd = Command::new(assert_cmd::cargo::cargo_bin!("pandoc-pretty"));
    cmd.arg(&input)
        .arg(&output)
        .env("PANDOC_PRETTY_KATEX", katex_fixture_url())
        .env(
            "PATH",
            format!(
                "{}:{}",
                dir.display(),
                std::env::var("PATH").unwrap_or_default()
            ),
        )
        .write_stdin("n\n");

    cmd.assert()
        .failure()
        .code(1)
        .stderr(contains("aborting; not overwriting"));

    let html = fs::read_to_string(&output).unwrap();
    assert_eq!(html, "keep");
    assert!(fs::metadata(&fake).unwrap().is_file());
}

#[test]
fn overwrites_when_user_confirms() {
    let tmp = tempdir().unwrap();
    let dir = tmp.path().to_path_buf();
    let fake = make_fake_pandoc(&dir);

    let input = dir.join("note.md");
    fs::write(&input, "# Title\n\nBody").unwrap();

    let output = dir.join("note.html");
    fs::write(&output, "keep".as_bytes()).unwrap();

    let mut cmd = Command::new(assert_cmd::cargo::cargo_bin!("pandoc-pretty"));
    cmd.arg(&input)
        .arg(&output)
        .env("PANDOC_PRETTY_KATEX", katex_fixture_url())
        .env(
            "PATH",
            format!(
                "{}:{}",
                dir.display(),
                std::env::var("PATH").unwrap_or_default()
            ),
        )
        .write_stdin("yes\n");

    cmd.assert().success();

    let html = fs::read_to_string(&output).unwrap();
    assert!(html.contains("fake</html>"));
    assert!(fs::metadata(&fake).unwrap().is_file());
}

#[test]
fn preserves_existing_title_metadata() {
    let tmp = tempdir().unwrap();
    let dir = tmp.path().to_path_buf();
    let _fake = make_fake_pandoc(&dir);

    let input = dir.join("paper.md");
    fs::write(&input, "---\ntitle: Custom Paper\n---\n\nBody text.\n").unwrap();

    let mut cmd = Command::new(assert_cmd::cargo::cargo_bin!("pandoc-pretty"));
    cmd.arg(&input)
        .env("PANDOC_PRETTY_KATEX", katex_fixture_url())
        .env(
            "PATH",
            format!(
                "{}:{}",
                dir.display(),
                std::env::var("PATH").unwrap_or_default()
            ),
        );

    cmd.assert().success();

    let output = dir.join("paper.html");
    let html = fs::read_to_string(&output).unwrap();
    assert!(
        !html.contains("--metadata title="),
        "should not add fallback title when metadata exists"
    );
    assert!(html.contains("--embed-resources"));
    assert!(html.contains("--standalone"));
    assert!(html.contains("fake</html>"));
}
