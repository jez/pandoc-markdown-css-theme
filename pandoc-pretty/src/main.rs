use std::env;
use std::fs::{self, File};
use std::io::{self, Write};
use std::path::{Path, PathBuf};
use std::process::{self, Command};

const TEMPLATE_HTML: &str = include_str!("../../template.html5");
const THEME_CSS: &str = include_str!("../../docs/css/theme.css");
const SKYLIGHTING_CSS: &str = include_str!("../../docs/css/skylighting-solarized-theme.css");
const SIDENOTE_LUA: &str = include_str!("../../pandoc-sidenote.lua");
const DEFAULT_KATEX: &str = "https://cdn.jsdelivr.net/npm/katex@0.15.1/dist/";

fn write_file(path: &Path, contents: &str) -> io::Result<()> {
    if let Some(parent) = path.parent() {
        fs::create_dir_all(parent)?;
    }
    let mut file = File::create(path)?;
    file.write_all(contents.as_bytes())
}

fn usage(bin: &str) {
    eprintln!("usage: {bin} <input.md> [output.html]");
}

fn temp_root() -> io::Result<PathBuf> {
    let mut dir = env::temp_dir();
    dir.push(format!("pandoc-pretty-{}", process::id()));
    fs::create_dir_all(&dir)?;
    Ok(dir)
}

fn katex_url() -> String {
    let mut url = env::var("PANDOC_PRETTY_KATEX").unwrap_or_else(|_| DEFAULT_KATEX.to_string());
    if !url.ends_with('/') {
        url.push('/');
    }
    url
}

fn has_title_metadata(path: &Path) -> bool {
    let Ok(content) = fs::read_to_string(path) else {
        return false;
    };

    // YAML metadata block
    if content.starts_with("---\n") {
        if let Some(end) = content[4..].find("\n---") {
            let header = &content[4..4 + end];
            if header
                .lines()
                .any(|l| l.trim_start().to_ascii_lowercase().starts_with("title:"))
            {
                return true;
            }
        }
    }

    // Pandoc %-style metadata
    if let Some(first_line) = content.lines().next() {
        if first_line.starts_with('%') && first_line.len() > 1 {
            return true;
        }
    }

    false
}

fn ensure_pandoc(bin: &str) {
    match Command::new("pandoc")
        .arg("--version")
        .stdout(process::Stdio::null())
        .stderr(process::Stdio::null())
        .status()
    {
        Ok(status) if status.success() => {}
        Ok(_) | Err(_) => {
            eprintln!(
                "{bin}: pandoc not found. Please install pandoc and ensure it is on your PATH."
            );
            process::exit(127);
        }
    }
}

fn confirm_overwrite(path: &Path, bin: &str) {
    if path.exists() {
        eprintln!(
            "{bin}: warning: output file already exists: {}",
            path.display()
        );
        eprint!("Overwrite? [y/N]: ");
        let _ = io::stderr().flush();

        let mut response = String::new();
        match io::stdin().read_line(&mut response) {
            Ok(_) => {
                let normalized = response.trim().to_ascii_lowercase();
                if normalized != "y" && normalized != "yes" {
                    eprintln!("{bin}: aborting; not overwriting existing file");
                    process::exit(1);
                }
            }
            Err(err) => {
                eprintln!("{bin}: failed to read confirmation: {err}");
                process::exit(1);
            }
        }
    }
}

fn main() {
    let mut args = env::args();
    let bin = args.next().unwrap_or_else(|| "pandoc-pretty".into());
    let input = args.next();
    let mut output = args.next();

    if input.is_none() {
        usage(&bin);
        process::exit(64);
    }

    let input = input.unwrap();
    let input_path = PathBuf::from(&input);

    ensure_pandoc(&bin);

    if output.is_none() {
        let mut derived = input_path.clone();
        if derived.extension().is_some() {
            derived.set_extension("html");
        } else {
            derived.set_extension("html");
        }
        output = Some(
            derived
                .to_str()
                .unwrap_or_else(|| {
                    eprintln!("pandoc-pretty: could not derive output path from input");
                    process::exit(64);
                })
                .to_string(),
        );
    }

    let output = output.unwrap();
    let output_path = PathBuf::from(&output);

    confirm_overwrite(&output_path, &bin);

    let temp = match temp_root() {
        Ok(dir) => dir,
        Err(err) => {
            eprintln!("pandoc-pretty: failed to create temp dir: {err}");
            process::exit(1);
        }
    };

    let template_path = temp.join("template.html5");
    let lua_path = temp.join("pandoc-sidenote.lua");
    let css_dir = temp.join("css");
    let theme_path = css_dir.join("theme.css");
    let skylighting_path = css_dir.join("skylighting-solarized-theme.css");

    let writes = [
        (template_path.as_path(), TEMPLATE_HTML),
        (lua_path.as_path(), SIDENOTE_LUA),
        (theme_path.as_path(), THEME_CSS),
        (skylighting_path.as_path(), SKYLIGHTING_CSS),
    ];

    for (path, contents) in writes {
        if let Err(err) = write_file(path, contents) {
            eprintln!("pandoc-pretty: failed to write {path:?}: {err}");
            cleanup(&temp);
            process::exit(1);
        }
    }

    let mut cmd = Command::new("pandoc");
    cmd.arg(format!("--katex={}", katex_url()))
        .arg("--from")
        .arg("markdown+tex_math_single_backslash")
        .arg("--embed-resources")
        .arg("--lua-filter")
        .arg(&lua_path)
        .arg("--to")
        .arg("html5+smart")
        .arg("--standalone");

    if !has_title_metadata(&input_path) {
        let fallback_title = input_path
            .file_stem()
            .and_then(|s| s.to_str())
            .unwrap_or("Document");
        cmd.arg("--metadata").arg(format!("title={fallback_title}"));
    }

    cmd.arg("--template")
        .arg(&template_path)
        .arg("--css")
        .arg(&theme_path)
        .arg("--css")
        .arg(&skylighting_path)
        .arg("--toc")
        .arg("--wrap=none")
        .arg("--output")
        .arg(&output_path)
        .arg(&input);

    let status = cmd.status();

    cleanup(&temp);

    match status {
        Ok(code) if code.success() => {}
        Ok(code) => {
            let code = code.code().unwrap_or(-1);
            eprintln!("pandoc-pretty: pandoc failed with exit code {code}");
            process::exit(code);
        }
        Err(err) => {
            eprintln!("pandoc-pretty: failed to spawn pandoc: {err}");
            process::exit(127);
        }
    }
}

fn cleanup(temp: &Path) {
    if let Err(err) = fs::remove_dir_all(temp) {
        // Not fatal; leave directory behind for inspection.
        eprintln!("pandoc-pretty: warning: unable to remove temp dir {temp:?}: {err}");
    }
}
