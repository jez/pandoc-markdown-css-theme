# pandoc-markdown-css-theme

<https://jez.io/pandoc-markdown-css-theme/>

## Developing

```
make
make watch
```

More instructions in the [Usage][Usage] section of the website above.

## Native helper binary

You can optionally build a static helper that wraps your local `pandoc` with this
repo’s template, CSS, and sidenote filter baked in.  This allows you to trivially
convert markdown files to html anywhere on your system with a single command, such as:

```bash
pandoc-pretty README.md
```

Which will spit out a README.html file you can open in your browser or deploy to the web.

You can optionally specify output location and name:

```bash
pandoc-pretty README.md ~/README-weird-name.html
```

### Building the native wrapper

This binary is a small rust-based wrapper that requires `pandoc` to be installed and
available in your `PATH` variable.  Install and init `rustup`, then:

```bash
rustup target add x86_64-unknown-linux-musl   # once
make pandoc-pretty                            # produces dist/pandoc-pretty
```

You may wish to copy the binary somewhere on you system in `PATH`.  For example:

```bash
# If you have ~/bin/
cp ./dist/pandoc-pretty ~/bin/

# Alternatively
sudo cp ./dist/pandoc-pretty /usr/local/bin/
```

Usage: `pandoc-pretty input.md [output.html]` (requires `pandoc` in `PATH`). The
output defaults to the input filename with `.html` extension. The
output HTML is self-contained: template, CSS, and sidenote Lua filter are
embedded so the file works standalone.

[Usage]: https://jez.io/pandoc-markdown-css-theme/#usage

## License

HTML, CSS, and and JavaScript code is licensed under the Blue Oak Model License.
See LICENSE.md

Text and images are licensed under CC-BY-SA 4.0. See:
<https://creativecommons.org/licenses/by-sa/4.0/>

This project **does not** provide a license for any fonts distributed in this
project. You **must** acquire your own license for proprietary fonts distributed
with this project.
