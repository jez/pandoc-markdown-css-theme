---
title: "Pandoc Markdown CSS Theme"
subtitle: "Starter files for generating HTML from Pandoc Markdown"
author: "@jez"
author_url: 'https://github.com/jez'
date: "2021-06-20"
---

::: {.note .yellow}
------------------------------------------------------------------------
⚠️ **This project is in progress!**

Please pardon the TODOs and broken links. It'll be ready soon.
------------------------------------------------------------------------
:::

This project provides CSS files and a template for using Pandoc[^pandoc] to
generate standalone HTML files. It supports most features Pandoc Markdown has to
offer, and some extras. A short list of headline features:

[^pandoc]:
  [Pandoc] is a "universal document converter." It is particularly good at
  generating HTML and \(\LaTeX\) from Markdown.

- [Code blocks](features/#code-blocks), including:
  - Syntax themes
  - Line numbers
  - Line highlights
  - Captions
  - Extra wide and full-width options
- [Side notes and margin notes](features/#side-notes-and-margin-notes)
- [Images](features/#images) and [Tables](features/#tables), including:
  - Extra wide and full-width options
  - Captions
- [Table of contents](features/#table-of-contents)
- [Colored note callouts](features/#colored-note-callouts)
- [Assorted prose elements](features/#assorted-prose-elements)
- [\(\LaTeX\) math](features/#latex-math), rendered via [\(\KaTeX\)][KaTeX] in
  the browser

For the complete feature set, see the documentation. You might also want to
browse the gallery of sample pages, or view the "kitchen sink" page that is
useful when developing:

[→ Documentation](features/)\
[→ Gallery](gallery/)\
[→ Kitchen Sink](kitchen-sink/)

The theme is fully responsive,[^expected] including phones, tablets, laptops,
and wide desktop screens. Side notes and the table of contents display inline
on small screen sizes, and in the margins on wide enough screens. Extra wide
images, tables, and code blocks shrink when space isn't available. CSS `@media
print` styles declare first-class print styles.

[^expected]: As should be expected!

The theme's source code designed to be extremely tweakable.[^tweakable] Nearly
all styles are derived from a relatively small set of CSS variables, so things
like fonts, colors, and certain margins can be readily tweaked with little fuss.
Of course, the code is open source: you're welcome to copy the theme files and
overhaul them if desired. As a proof of concept, see [this page](paper/), which
tweaks the default theme slightly.

[^tweakable]:
  When changing things like the font family or font size, the thing that matters
  is to pay special attention to alignment. Different fonts have different
  x-heights and widths. Most layouting can be agnostic of these things, but
  there are explicit variables for places where it matters.

The theme is almost entirely HTML and CSS. It doesn't use custom fonts by
default, and only uses JavaScript for two things:

- Rendering math (via [\(\KaTeX\)][KaTeX]), only if used.
- Slightly tweaking the appearance of checklist items. (Pandoc emits them as
  disabled, but they look better when enabled in my opinion.) This is entirely
  presentational.

Placement of side notes, the table of contents, and code block line highlights
are all controlled with CSS. See the [credits](#credits) below for more
background on the techniques used.

# Usage

Before getting started, install these two depencencies:

- [ ] [Pandoc]
- [ ] [`pandoc-sidenote`]
- [ ] `realpath` from [GNU coreutils]

See the links above for installation instructions for your platform. If you're
using macOS, installation is as easy as:

```{.numberLines}
brew install pandoc coreutils
brew tap jez/formulae
brew install pandoc-sidenote
```

This project merely provides a Pandoc HTML5 template, CSS files, and Makefile.
You can clone this project and get using them right away:

```{.numberLines}
git clone https://github.com/jez/pandoc-markdown-css-theme
cd pandoc-markdown-css-theme
make watch
```

You can then visit <http://127.0.0.1:8000/> and view the rendered files.

The imporant files that you might want to copy out to start your own project:

- [`public/css/theme.css`], the core CSS implementing theme
- [`template.html5`], the Pandoc template that renders Markdown to HTML
- [`Makefile`], showcasing the Pandoc flags required to get things to build
- [`src/index.md`], the source code for this page

[`public/css/theme.css`]: https://github.com/jez/pandoc-markdown-css-theme/blob/master/public/css/theme.css
[`template.html5`]: https://github.com/jez/pandoc-markdown-css-theme/blob/master/template.html5
[`Makefile`]: https://github.com/jez/pandoc-markdown-css-theme/blob/master/Makefile
[`src/index.md`]: https://github.com/jez/pandoc-markdown-css-theme/blob/master/src/index.md

If you'd like a more seamless experience, I've also packaged up these files as a
[Jekyll theme](#todo).

<!-- TODO(jez) Link to the Jekyll theme here -->

# Credits

First, thanks to [Pandoc], by John MacFarlane, for being an all-around awesome
tool, especially for Markdown.

The core technique for laying out side notes[^gwern] I learned from [Tufte CSS],
by Dave Liepmann. The technique is [described in detail
here][tufte-css-sidenotes]. I then wrote [`pandoc-sidenote`], a [Pandoc filter]
that traverses Pandoc's internal AST and converts Markdown footnoes into the
HTML markup required to render Tufte CSS-style side notes.

[^gwern]:
  {-} Gwern has a great survey post that discusses
  <a href="https://edwardtufte.github.io/tufte-css/#sidenotes">Sidenotes In Web
  Design</a>, covering the techniques in Tufte CSS as well as the limitations,
  and many alternatives.

[tufte-css-sidenotes]: https://edwardtufte.github.io/tufte-css/#sidenotes

While the idea for side notes comes entirely from Tufte CSS, the implementation
at this point is almost completely different. Tufte CSS uses relative widths
everywhere, but I wanted a body with a constant width at all but the smallest
screen sizes. Tufte CSS renders the main body off center. This adds complexity
in the implemtation.

The inspiration for code block line highlights comes from a change I contributed
to [`pandoc-emphasize-code`], by Oskar Wickström (another Pandoc filter). I
decided against using it for this project because it forces a choice of either
line highlights or syntax highlighting per code block (unless you tack on a
JavaScript-based syntax highlighter, like Highlight.js). I thought of a [clever
technique](features/#line-highlight-limit) using CSS clases to avoid this.

[`pandoc-emphasize-code`]: https://github.com/owickstrom/pandoc-emphasize-code

Considerable design inspiration comes from [Dropbox Paper], a gorgeous and
powerful tool. (In fact, the theme is customizable enough to [recreate the
look of Paper](paper/). This is provided for educational purposes only, under
Fair Use.)

# See also

If you'd like to use Tufte CSS with Pandoc in your own project, feel free to use
my [Tufte Pandoc CSS] project.

[Tufte Pandoc CSS]: https://jez.io/tufte-pandoc-css/

<!-- TODO(jez) Link to this Jekyll theme -->
<!-- TODO(jez) Link to Tufte CSS Jekyll theme -->


<p class="signoff">
  <a href="/">↑ Back to the top</a>
</p>

[Pandoc]: https://pandoc.org/
[Pandoc filter]: https://pandoc.org/filters.html
[`pandoc-sidenote`]: https://github.com/jez/pandoc-sidenote
[GNU coreutils]: https://www.gnu.org/software/coreutils/coreutils.html
[KaTeX]: https://katex.org/
[Tufte CSS]: https://edwardtufte.github.io/tufte-css/
[Dropbox Paper]: https://www.dropbox.com/paper

