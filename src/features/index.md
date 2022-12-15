---
title: "Features"
subtitle: "Documentation for how to make the most of this theme."
date: "2021-06-26"
author: "@jez"
author-url: "https://github.com/jez"
return-url: '..'
return-text: '← Return home'
---

This theme supports many Pandoc Markdown features. Some features work as
expected out of the box, and some require a particular markup structure. This
page documents those feature and the required document structure.

You might also be interested in the [Kitchen Sink](../kitchen-sink/) page, which
is more comprehensive in terms of exercising edge cases, but has almost zero
explanation of what is going on. There is also a [Kitchen Sink Tufte](../tufte/)
page which showcases one example of how to re-skin the theme using the existing
customization features.

# Document metadata

Pandoc allows setting [variables] in the preamble of a Markdown document with a
YAML metadata block, like this:

```{.yaml .numberLines}
---
title: "Features"
date: 2021-06-26
# ...
---

... markdown content ...
```

This theme's HTML template allows setting some, but not all, of the variables
that Pandoc supports, including:

- `title`
  - Required
- `author`, `date`
- `pagetitle`, `author-meta`, `date-meta`
  - Optional, set automatically from `title`, `author`, and `date`
- `subtitle`
- `keywords`
- `lang`
- `dir`
  - Optional (text direction, like `ltr` or `rtl`)
- `description-meta`
- `title-prefix`
  - Optional, only affects `<title>` tag
- `header-includes`
  - Optional. A list of strings to inject at the end of the `<head>` tag
- `include-before`, `include-after`
  - Optional. A list of strings to inject at the start or end (respectively) of
    the `<body>`

It also supports some extra variables:

- `author-url`
  - Optional. Will render `author` wrapped in a link with this target if
    present.
- `return-url`
  - Optional. Will render a "return" link at the top of the table of contents if
    present.
- `return-text`
  - Optional. Text to use for the "return" link. Defaults to `← Return`.

You can see all of these settings in action at the top of this page. For more
information, refer to the [Pandoc manual section for variables][variables].

[variables]: https://pandoc.org/MANUAL.html#variables

# Assorted prose elements

This theme of course supports the standard Markdown prose elements you'd expect,
like paragraphs, **bold text**, _italic text_, and [links](#).

Pandoc Markdown has special syntax for some some non-standard prose elements,
including [smallcaps]{.smallcaps}, [underline]{.underline}, and
~~strikethrough~~. Refer to the Pandoc manual for more information, but the
basic syntax looks like

```
This text is [smallcaps]{.smallcaps}.
This text is [underline]{.underline}.
This text is ~~strikethrough~~.
```

> _This text is [smallcaps]{.smallcaps}._\
> _This text is [underline]{.underline}._\
> _This text is ~~strikethrough~~._

Pandoc Markdown also supports bulleted and numbered lists, as expected:

-   Bullet item
-   Another bullet

1.  First bullet
1.  Second bullet

But it also supports non-standard task lists:

```
- [x] Already done
- [ ] Not done yet
```

> - [x] _Already done_
> - [ ] _Not done yet_

Pandoc renders task list checkboxes as disabled, so they can't be clicked. This
theme inserts a few lines of JavaScript to make them enabled in HTML but
disabled with JavaScript because it is the easiest way to apply custom styles to
checkboxes. If you prefer the `disabled` appearance or don't want JavaScript,
feel free to remove the `<script>` tag at the end of the theme template.

# Side notes and margin notes

Side notes and margin notes work very similarly to how they work in [Tufte CSS],
but made easier to use in Markdown with the [`pandoc-sidenote`] Pandoc filter.

To get started, install `pandoc-sidenote` and pass `--filter pandoc-sidenote`
when invoking Pandoc, like the [Makefile] for this project does:

```
pandoc --filter pandoc-sidenote [...]
```

With this filter active, the syntax for footnotes becomes the syntax for side
notes and margin notes (specifically, it is no longer possible for the document
to use footnotes).

```
For example this is a side note[^example-side-note]. Side notes
are numbered, and the number shows at the anchor point in the
body text at all screen widths.

[^example-side-note]:
  This is the text in the side note. It is smaller and only
  supports inline elements, like **bold** or [links](#),
  but not lists or code blocks.
```

> _For example this is a side note[^example-side-note]. Side notes are numbered,
> and the number shows at the anchor point in the body text at all screen
> widths._

[^example-side-note]:
  This is the text in the side note. It is smaller and only supports inline
  elements, like **bold** or [links](#), but not lists or code blocks.

```
On the other hand, margin notes are not numbered. Instead,
they hang to the left and are only vaguely connected to the
text, like this.[^example-margin-note]

[^example-margin-note]:
  {-} `pandoc-sidenote` detects margin notes when the note
  starts with the text `{-}`. This is inspired by the syntax
  Pandoc uses for unnumbered headings.
```

> _On the other hand, margin notes are not numbered. Instead, they hang to the
> left and are only vaguely connected to the text, like
> this.[^example-margin-note]_

[^example-margin-note]:
  {-} `pandoc-sidenote` detects margin notes when the note starts with the text
  `{-}`. This is inspired by the syntax Pandoc uses for unnumbered headings.


[Tufte CSS]: https://edwardtufte.github.io/tufte-css/
[`pandoc-sidenote`]: https://github.com/jez/pandoc-sidenote
[Makefile]: https://github.com/jez/pandoc-markdown-css-theme/blob/27d0aa58bfc6eafe296e2cef1900a39c9c2507a7/tools/build.sh#L57

Side notes and margin notes are fully responsive. When there is no space to
render the notes in the margin, they will be hidden by default, and the anchor
point will leave a clickable link to expand the side note inline. Try viewing
this page on a phone to see how that looks.

## Choosing a side note anchor spot

Side notes and margin notes look best when they anchor to text within the first
~500px of the text (this is where the first line will break on tablets). This
ensures that the baseline of the sidenote and the baseline of the body text will
align on the first line.

For example, note the difference between the side note and margin note exaple
above. The side note anchors to the first line of the paragraph, while the
margin note anchors to the last line. This makes the side note even with its
corresponding paragraph, but makes the margin note look like it's hanging.

Sometimes the prose dictates where the margin note must attach, making the
problem unavoidable. But when there's a choice of where to attach it, use this
as a guide.

# Code blocks

Pandoc Markdown supports a number of code block features. First, plain delimited
code blocks with no syntax highlighting:

````
```
This is a code block.
```
````

```
This is a code block.
```

As well as delimited code blocks with syntax highlighting:

````
```ruby
def greet; "Hello, world!"; end
```
````

```ruby
def greet; "Hello, world!"; end
```

## Numbered and highlighted lines

Pandoc Markdown also supports attaching line numbers to a code block, plain or
with syntax highlighting using the `.numberLines` CSS class:

````
```{.ruby .numberLines}
def greet; "Hello, world!"; end
```
````

```{.ruby .numberLines}
def greet; "Hello, world!"; end
```

The line numbers are clickable and all have HTML IDs attached to them, making
them linkable.

This theme extends Pandoc's code blocks with line numbers by allowing individual
lines to be highlighted. Emphasize specific lines in a code block by adding
various `.hl-*` classes for the lines you'd like to highlight, like this:

````
```{.numberLines .hl-2 .hl-3}
This is the first line.
This line is highlighted.
This line is also highlighted.
This is another line.
```
````

```{.numberLines .hl-2 .hl-3}
This is the first line.
This line is highlighted.
This line is also highlighted.
This is another line.
```

The `.numberLines` class is required for these line highlights to render
correctly.

### Line highlight limit

A quick note on line highlights: this feature is implemented in CSS, and is
currently limited to a max line highlight of the 40<sup>th</sup> line. More
lines can always be specified by adding [more lines like this] using
the `header-includes` variable:

[more lines like this]: https://github.com/jez/pandoc-markdown-css-theme/blob/27d0aa58bfc6eafe296e2cef1900a39c9c2507a7/public/css/theme.css#L539-L578

```yaml
---
# ...
header-includes:
- '<style>pre.hl-41 > code.sourceCode > span:nth-of-type(41)::after { content: ""; }</style>'
---
```


## Tight code blocks

Another feature unique to this theme is is `.tight-code`. Sometimes for drawing
ASCII art it's important that there be no gaps between lines, so that things
like unicode box drawing characters attach:

````
```{.tight-code}
One line of text
Another line of text
┌──┬──┐
├──┼──┤
└──┴──┘
```
````

```{.tight-code}
One line of text
Another line of text
┌──┬──┐
├──┼──┤
└──┴──┘
```

As you can see, the difference is striking. Text ends up looking crammed
together, instead of following the normal rhythem of the rest of the document,
but sometimes this can be a worthy tradeoff when it matters that code lines
touch.

# Math

Pandoc Markdown supports [a number of ways][math-input] to specify LaTeX math.
This project's `Makefile` defaults to `tex_math_single_backslash`, which allows
multiple forms of math input:

[math-input]: https://pandoc.org/MANUAL.html#math-input

```
This is inline: $a^2 + b^2 = c^2$.\
So is this: \(F = ma\).\
This is display math:

$$x = \frac{ - b \pm \sqrt {b^2 - 4ac} }{2a}$$

And so is this:

\[\frac{
  \Delta \, \Gamma, e : \forall (u :: \kappa). \tau \qquad \Delta \vdash c :: \kappa
}{
  \Delta \, \Gamma \vdash e[c] : [c/u]\tau
}\]
```

This is inline: $a^2 + b^2 = c^2$.\
So is this: \(F = ma\).

This is display math:

$$x = \frac{ - b \pm \sqrt {b^2 - 4ac} }{2a}$$

And so is this:

\[\frac{
  \Delta \, \Gamma, e : \forall (u :: \kappa). \tau \qquad \Delta \vdash c :: \kappa
}{
  \Delta \, \Gamma \vdash e[c] : [c/u]\tau
}\]

The math is rendered with [\(\KaTeX\)][katex]. If a page uses math, Pandoc will
automatically include the necessary CSS and JavaScript files to render the math.

[katex]: https://katex.org/

# Images, tables, and captioned code blocks

Pandoc Markdown has special syntax for images and tables, and their captions.
For example:

```
![Sugarloaf Hill, San Mateo, CA, April 2021](../img/sugarloaf-hill-forest-green.jpg)
```

![Sugarloaf Hill, San Mateo, CA, April 2021](../img/sugarloaf-hill-forest-green.jpg)

Note how the image's `alt` text became the caption. With tables, the syntax is
slightly different:

| **Column 1**       | **Column 2**       |
| ------------------ | ------------------ |
| This is some text. | This is some text. |
| This is some text. | This is some text. |

Table: This is the caption.

On top of the syntax Pandoc Markdown provides, this theme supports attaching
captions to code blocks by wrapping the code block in a `<figure>` tag.

````{.html .numberLines .hl-1 .hl-8 .hl-9}
<figure>
```ruby
source 'https://rubygems.org'

gem 'sorbet'
gem 'sorbet-runtime'
```
<figcaption>An example Gemfile</figcaption>
</figure>
````

<figure>
```ruby
source 'https://rubygems.org'

gem 'sorbet'
gem 'sorbet-runtime'
```
<figcaption>An example Gemfile</figcaption>
</figure>

# Wide, extra-wide, and full-width

As mentioned when discussing side notes, this theme aims to be fully responsive.
Responsive means more than just making it work on mobile—it means making the
most of the available space on both small and large screens.

To help you make the most of the available space, this theme provides three
utility classes to declare how much extra space to use up when available:

- `.wide`
  - On smaller screens, sets `overflow-x: scroll`.
  - Takes up to `--main-width` space,[^main-width] potentially expanding into
    the margin to do so. For example: when the browser takes up half of a
    1920x1080 screen.
- `.wide.extra-wide`
  - From `.wide`: on smaller screens, sets `overflow-x: scroll`.
  - Takes up to `1.5 * --main-width` space,[^extra-wide-factor] potentially
    expanding into the margin to do so.
  - If the right margin is not collapsed, the content will expand equally into
    both margins and be centered.
- `.wide.full-width`
  - From `.wide`: on smaller screens, sets `overflow-x: scroll`.
  - Take up all available space, expanding into all margins.

[^main-width]: {-} The `--main-width` CSS variable defaults to 745px.

[^extra-wide-factor]:
  {-} This multiple is configurable with `--extra-wide-scale-factor`.

(Note that `extra-wide` and `full-width` only work in conjunction with `.wide`.)

These classes work with images, tables, code blocks, and math. Here are some
examples:

:::{.wide .extra-wide}

| **Column 1**       | **Column 2**       | **Column 3**       | **Column 4**       | **Column 5**       | **Column 6**       | **Column 7**       | **Column 8**       |
| ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ |
| This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. |
| This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. |

:::

:::{.wide .full-width .left-align-caption}
![Upper Crystal Springs Reservoir, near Belmont, CA](../img/upper-crystal-springs-reservoir-facing-northwest.jpg)
:::

<figure class="wide extra-wide">
\[
  \frac{\quad}{\Delta \, \Gamma , x \, : \, \tau \vdash x \, : \, \tau} \;
  (16.2a)
  \quad \frac{\Delta \vdash \tau_1 \, \textsf{type} \quad \Delta \, \Gamma , x \, : \, \tau_1 \vdash e \, : \, \tau_2}{\Delta \, \Gamma \vdash \texttt{lam}\{\tau_1\}(x.e) \, : \, \texttt{arr}(\tau_1; \tau_2)} \; (16.2b)
  \quad \frac{\Delta \, \Gamma \vdash e_1 \, : \, \texttt{arr}(\tau_2 ; \tau) \quad \Delta \, \Gamma \vdash e_2 \, : \, \tau_2}{\Delta \, \Gamma \vdash \texttt{ap}(e_1 ; e_2) \, : \, \tau} \; (16.2c) \\
   \, \\
  \quad \frac{\Delta, t \, \textsf{type} \, \Gamma \vdash e \, : \, \tau}{\Delta \, \Gamma \vdash \texttt{Lam}(t.e) \, : \, \texttt{all}(t.\tau)} \; (16.2d)
  \quad \frac{\Delta \, \Gamma \vdash e \, : \, \texttt{all}(t.\tau') \quad \Delta \vdash \tau \, \textsf{type}}{\Delta \, \Gamma \vdash \texttt{App}\{\tau\}(e) \, : \, [\tau / t]\tau'} \; (16.2e)
\]
<figcaption>Typing rules for System F, From PFPL Chapter 16</figcaption>
</figure>

:::{.wide}

```{.yaml .numberLines .hl-4}
---
# ...
header-includes:
- '<style>pre.hl-41 > code.sourceCode > span:nth-of-type(41)::after { content: ""; }</style>'
---
```

:::

(There is currently a bug where using `.wide` with `.numberLines` code blocks causes the line numbers to be hidden. They are still highlightable and linkable.)

There are two supported syntaxes for marking things wide:

-   Using Pandoc's `fenced_divs` feature.

    ```
    :::{.wide}
    <!-- ... content ... -->
    :::
    ```

    This is convenient when not using captions, or when using the
    special-purpose caption syntax for images and tables.

-   Using a raw `<figure>` tag.

    ```
    <figure class="wide">
    <!-- ... content ... -->
    <figcaption> ... </figcaption>
    </figure>
    ```

    Code blocks and display-mode math don't have special syntax for adding captions, so this is the only option then.

On large screens, the captions will generally be center aligned. This can look strange, especially for captions whose text wraps onto multiple lines. To avoid centering captions, add the `.left-align-caption`.

:::{.note .blue}
|     |
| --- |
| ℹ️ You probably want to wrap all math and tables in `.wide` unless they're less than ~300px. It will never display wider than the main body, but the `overflow-x` property on `.wide` ensures that it scrolls just the figure, not the whole page body. |

:::

# Colored note callouts

As you just saw, an extra feature of this theme is colored note callouts. The
syntax takes advantage of Pandoc's `fenced_divs` feature:

```
:::{.note .blue}
|     |
| --- |
| ℹ️ This is a note. |
:::
```

:::{.note .blue}
|     |
| --- |
| ℹ️ This is a note. |
:::

Right now, notes are implemented in terms of HTML tables. This may change in the
future.

There are five colors total. The other colors:

:::{.note .red}
|     |
| --- |
| 🛑 Don't do it! |

:::

:::{.note .yellow}
|     |
| --- |
| ☢️ Warning! |

:::

:::{.note .green}
|     |
| --- |
| ✅ Nice job! |

:::

:::{.note .purple}
|     |
| --- |
| 🔮 Can you see the future? |

:::

In addition to full-width block callouts, there are also inline highlights, in
the same colors: [red]{.mark .red}, [yellow]{.mark .yellow}, [green]{.mark
.green}, [blue]{.mark .blue}, [purple]{.mark .purple}.

These accent colors are configurable with CSS variables.


# Table of contents

As you might have noticed, there's an autogenerated table of contents! On large
screens, it floats to the right margin. On narrower screens, it collapses into
the document header.

This is powered by Pandoc's built in `--toc` flag. See where this project passes
it to the `pandoc` invocation [here][toc].

[toc]: https://github.com/jez/pandoc-markdown-css-theme/blob/27d0aa58bfc6eafe296e2cef1900a39c9c2507a7/tools/build.sh#L62

# Tweaking the CSS variables

As mentioned multiple times above, this theme is very configurable. See
[theme.css] for the full list of CSS variables. They control things like

- Font colors
- Accent colors
- Table borders and header colors
- Font family
- Font sizes, including body copy, code, and headings
- Side note text sizes and alignment
- The main width, including at narrow screen sizes.

As an example, see the [Kitchen Sink Tufte](../tufte/) page, which tweaks these
CSS variables to approximate the look of [Tufte CSS].

It's also easy to change the syntax theme used for code highlights, because it
lives in a separate file. The default theme is Solarized Light, which can be
found in [skylighting-solarized-theme.css].

[theme.css]: https://github.com/jez/pandoc-markdown-css-theme/blob/27d0aa58bfc6eafe296e2cef1900a39c9c2507a7/public/css/theme.css#L2

[skylighting-solarized-theme.css]: https://github.com/jez/pandoc-markdown-css-theme/blob/27d0aa58bfc6eafe296e2cef1900a39c9c2507a7/public/css/skylighting-solarized-theme.css#L1

# Automatic light and dark theme

Pages will automatically choose light mode or dark mode styles based on the
user's preferences, detected via CSS `@media` queries.[^media]

You can also use the `.only-light-mode` and `.only-dark-mode` CSS classes to
make something appear only in light or dark mode. One use case for this is with
images. For example, here's some Pandoc markdown using [`fenced_divs`] that
shows a light or dark mode version of an image:

[`fenced_divs`]: https://pandoc.org/MANUAL.html#extension-fenced_divs

```{.markdown .numberLines .hl-1 .hl-5}
:::{.only-light-mode}
![The light-mode version of the image](../img/light-desktop.png)
:::

:::{.only-dark-mode}
![The dark-mode version of the image](../img/dark-desktop.png)
:::
```

Only one of those divs will be rendered, depending on which theme is active. You
can see the result below, and you can toggle your light or dark mode theme to
see how the image updates:

:::{.only-light-mode}
![The light-mode version of the image](../img/light-desktop.png)
:::

:::{.only-dark-mode}
![The dark-mode version of the image](../img/dark-desktop.png)
:::

[^media]:
  At the moment, this means there is no way to programmatically toggle between
  light and dark mode except by toggling the OS or browser's setting.

# Print styles

As a reminder, this theme has custom print styles for U.S. Letter size paper.
The print styles look similar to a somewhat narrow desktop screen, with enough
room for a right margin with sidenotes, but not quite enough width to support
the full 745px that the main body would normally take up. There is no large left
margin, so the table of contents is shown at the top of the page (expanded).

If print styles matter to you, take care to make sure that things don't wrap.
Some things like tables or math that would normally overflow and scroll on a
screen will be clipped when printed. Always test your content before publishing.

Feel free to test on this page. The tables and math are wide enough to
demonstrate the problems.

Most browsers will offer the user a choice of whether to include background
colors or not. Things like code block backgrounds and table header backgrounds
won't show up unless the browser's "Print backgrounds" option (or equivalent) is
checked.
