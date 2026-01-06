---
title: 'Kitchen Sink `code`'
subtitle: '"Everything but the kitchen sink."'
author: '@jez'
author-url: 'https://github.com/jez'
date: '2021-06-25'
return-url: '..'
return-text: '← Return home'
---

This project provides CSS files and a template for using Pandoc to generate
standalone HTML files. It supports most features Pandoc Markdown has to offer,
and some extras. The default look can be tweaked via CSS variables, and it does
not need JavaScript, even for side notes.

# Prose

This is some body text between headings. This project provides CSS files and a
template for using Pandoc to generate standalone HTML files. It supports most
features Pandoc Markdown has to offer, and some extras. The default look can be
tweaked via CSS variables, and it does not need JavaScript, even for side notes.

This is some **body text between headings**. This project provides CSS files and
a template for using Pandoc to generate *standalone HTML files*. It supports
most features **Pandoc Markdown** has to offer, and some extras. The default
look can be _tweaked via CSS variables_, and it does not ~need JavaScript, even
for side notes.

This project [provides CSS files]{.smallcaps} and a template for using Pandoc to
generate standalone HTML files. It supports most features [**Pandoc
Markdown**]{.smallcaps} has to offer, and some [_extras_]{.smallcaps}. The
default look can be [tweaked via CSS]{.underline} variables, and it does not
need JavaScript, ~~even for side notes~~.

This is some [body text](#) between headings. This project `provides CSS files`
and a template for using [`pandoc`](#) to generate standalone HTML files. It
supports most features Pandoc Markdown has to offer, and some extras. The
**[default](#)** look can be tweaked via **_CSS variables_**, and it does not
need JavaScript, even for side notes.

"Hanging punctuation" is really nice.\
Unfortunately it's only supported in Safari on iOS and macOS.\
"Does it work after line breaks," or just at the block start?

- - - - -

Horizontal rules, too!

- - - - -

# Math

There's inline math: \(a^2 + b^2 = c^2\), and block math:

$$60 \, \frac{\textrm{seconds}}{\textrm{minute}} \cdot 60 \, \frac{\textrm{minutes}}{\textrm{hour}} = 3,600 \, \frac{\textrm{seconds}}{\textrm{hour}}$$

$$\frac{
  \Delta \, \Gamma, e : \forall (u :: \kappa). \tau \qquad \Delta \vdash c :: \kappa
}{
  \Delta \, \Gamma \vdash e[c] : [c/u]\tau
}$$

<figure class="wide">

\[\frac{
  \Delta \, \Gamma, e : \forall (u :: \kappa). \tau \qquad \Delta \vdash c :: \kappa
}{
  \Delta \, \Gamma \vdash e[c] : [c/u]\tau
}\]

<figcaption>Typing rule for ∀ types</figcaption>
</figure>

<figure class="wide extra-wide">

\[\frac{
  \Delta, u :: \kappa \vdash c :: \kappa’
}{
  \Delta \vdash \lambda(u :: \kappa). \, c :: \kappa \to \kappa’
}\;(\texttt{lambda-kind}) \quad \frac{
  \Delta, u :: \kappa \vdash c :: *
}{
  \Delta \vdash \forall(u :: \kappa). \, c :: *
}\;(\texttt{forall-kind})\]

<figcaption>Kind rules for two type constructors in System F<sub>ω</sub>. This
text is long enough that it wraps on some screens.</figcaption>
</figure>

<figure class="wide extra-wide left-align-caption">

\[\frac{
  \Delta, u :: \kappa \vdash c :: \kappa’
}{
  \Delta \vdash \lambda(u :: \kappa). \, c :: \kappa \to \kappa’
}\;(\texttt{lambda-kind}) \quad \frac{
  \Delta, u :: \kappa \vdash c :: *
}{
  \Delta \vdash \forall(u :: \kappa). \, c :: *
}\;(\texttt{forall-kind})\]

<figcaption>This caption will be forcibly left-aligned.</figcaption>
</figure>

<figure class="wide full-width">

\[\frac{
  \Delta, u :: \kappa_1 \vdash c_2 :: \kappa_2 \qquad \Delta \vdash c_1
  :: \kappa_1
}{
  \Delta \vdash (\lambda(u :: \kappa_1). \, c_2)(c_1) \equiv  [c_1/u]c_2 :: \kappa_2
} \quad \frac{
  \Delta, u :: \kappa_1 \vdash c_2 :: \kappa_2 \qquad \Delta \vdash c_1
  :: \kappa_1
}{
  \Delta \vdash (\lambda(u :: \kappa_1). \, c_2)(c_1) \equiv  [c_1/u]c_2 :: \kappa_2
} \quad \frac{
  \Delta, u :: \kappa_1 \vdash c_2 :: \kappa_2 \qquad \Delta \vdash c_1
  :: \kappa_1
}{
  \Delta \vdash (\lambda(u :: \kappa_1). \, c_2)(c_1) \equiv  [c_1/u]c_2 :: \kappa_2
} \\ \quad \\ \frac{
  \Delta \, \Gamma, e : \forall (u :: \kappa). \tau \qquad \Delta \vdash c :: \kappa
}{
  \Delta \, \Gamma \vdash e[c] : [c/u]\tau
} \quad \frac{
  \quad
}{
  (\Lambda u. \, e)[\tau] \mapsto [\tau / u]e
}\]

<figcaption>Assorted rules from statics and dynamics of System<sub>ω</sub></figcaption>
</figure>

# Headings

This is some body text between headings. This project provides CSS files and a
template for using Pandoc to generate standalone HTML files. It supports most
features Pandoc Markdown has to offer, and some extras. The default look can be
tweaked via CSS variables, and it does not need JavaScript, even for side notes.

## Smaller heading

This is some body text between headings. This project provides CSS files and a
template for using Pandoc to generate standalone HTML files. It supports most
features Pandoc Markdown has to offer, and some extras. The default look can be
tweaked via CSS variables, and it does not need JavaScript, even for side notes.

### Even smaller heading `code`

This is some body text between headings. This project provides CSS files and a
template for using Pandoc to generate standalone HTML files. It supports most
features Pandoc Markdown has to offer, and some extras. The default look can be
tweaked via CSS variables, and it does not need JavaScript, even for side notes.

### Really long heading that takes up nearly the full main width of the page.

This heading can make the side nav bar overflow the container.

#### There is no level 4 heading

# Level 1 heading `code`

## Level 2 heading `code`

This is some body text between headings. This project provides CSS files and a
template for using Pandoc to generate standalone HTML files. It supports most
features Pandoc Markdown has to offer, and some extras. The default look can be
tweaked via CSS variables, and it does not need JavaScript, even for side notes.

## Another level 2 heading

This is some body text between headings. This project provides CSS files and a
template for using Pandoc to generate standalone HTML files. It supports most
features Pandoc Markdown has to offer, and some extras. The default look can be
tweaked via CSS variables, and it does not need JavaScript, even for side notes.

# Lists

This is some body text between lists. It takes up the full width of the line,
but only just barely.

- Level 1
  - Level 2
    - Level 3
      - Level 4
        - Level 5
          - Level 6

This is some body text between lists. It takes up the full width of the line,
but only just barely.

1.  Level 1
    1.  Level 2
        1.  Level 3
            1.  Level 4
                1.  Level 5
                    1.  Level 6

This is some body text between lists. It takes up the full width of the line,
but only just barely.

- Prose
- Headings
- Lists
- Code blocks

This is some body text between lists. It takes up the full width of the line,
but only just barely.

1.  This list
1.  has ten
1.  items which
1.  causes it
1.  to push
1.  the numbers
1.  further left
1.  which extends
1.  the numbers
1.  into the
1.  page margin.

This is some body text between lists. This project provides CSS files and a
template for using Pandoc to generate standalone HTML files. It supports most
features Pandoc Markdown has to offer, and some extras.

- Line starts with a short bullet point
  - Next line starts with a longer bullet point that wraps around at larger
    screen sizes because there's so much text.
- Line starts with a short bullet point
  - Next line starts with a longer bullet point that wraps around at larger
    screen sizes because there's so much text.

This is some body text between lists. This project provides CSS files and a
template for using Pandoc to generate standalone HTML files. It supports most
features Pandoc Markdown has to offer, and some extras.

1.  Line starts with a short bullet point
    1.  First line<br>
        Next line
1.  Notice how the line numbers are **tabular numbers**, not proportional.
    -   First line, **switch to bullet**\
        Next line

This is some body text between lists. This project provides CSS files and a
template for using Pandoc to generate standalone HTML files. It supports most
features Pandoc Markdown has to offer, and some extras.

- [ ] Line starts with a short bullet point
  - [ ] First line\
        Next line
- [x] Line starts with a short bullet point
  - [x] First line, **checklists are different by browser, even on same OS**\
        Next line

This is some body text between lists. This project provides CSS files and a
template for using Pandoc to generate standalone HTML files.

- List item before **should line up** with check box after

<!-- force break -->

- [ ] First is unchecked\
      Next line
- [x] Last is checked\

<!-- force break -->

1.  List item after **should line up** with check box before

This is some body text between lists. This project provides CSS files and a
template for using Pandoc to generate standalone HTML files.

- **Common list structure**

  Is to have a bold title of the list, with some body text on the same bullet
  point (multiple paragraphs). The text in the "body" wraps onto multiple lines.

- **Pandoc implementation**

  For this technique, the top-level list items have to be separated by new
  lines. That's what gets Pandoc to put paragraph tags in the list item bodies.

This is some body text between lists. This project provides CSS files and a
template for using Pandoc to generate standalone HTML files.

- First item, first list
- Second item, first list

<!-- comment to force list break -->

- First item, second list
- Second item, second list

[→ Looks like a list](#)\
[→ Not actually a list](#)

## List after heading

- First list item
- Middle list item
- Last list item

## Paragraph list after heading

- First list item

- Middle list item

- Last list item

# Code blocks

Ah yes, who could forget about the code blocks.

```{.ruby .numberLines .hl-7 .hl-8 .hl-9 .hl-10}
# typed: true
require 'sorbet-runtime'

class A
  extend T::Sig

  sig {void}
  def self.main
    puts "Hello, world!"
  end
end
```

Here is a short paragraph between code blocks.

```{.ruby .numberLines}
# This is a really long line that causes the text to wrap onto multiple lines in a code block that uses syntax highlighting AND line numbers.
```

```ruby
puts 'It should also work without line numbers.'

# This is a really long line that causes the text to wrap onto multiple lines in a code block that uses syntax highlighting BUT NOT line numbers.
```

Check out the subtle line numbers. This is `some inline code` with text after it.

```{.numberLines .hl-1}
This code does not have a language associated with it. This is the point at which the code would wrap a long line.

Some more lines to make Paper give us line numbers.
Some more lines to make Paper give us line numbers.
Some more lines to make Paper give us line numbers.
Some more lines to make Paper give us line numbers.
```

```
This code does not have a language associated with it. This is the point at which the code would wrap a long line.
┌┐
└┘
```

```{.tight-code}
This is tight code in action.
This is tight code in action.
┌┐
└┘
This is tight code in action.
This is tight code in action.
```

<figure>
```ruby
source 'https://rubygems.org'

gem 'sorbet'
gem 'sorbet-runtime'
```
<figcaption>`Gemfile`</figcaption>
</figure>

This is a paragraph before the `.wide > .sourceCode` block that follows.

<figure class="wide left-align-caption">
```{.numberLines .hl-3}
This code block has an absolutely large amount of text in it for who knows what reason. Who is the kind of heathen who would willfully write code with lines this long?

Scroll → all the way to the left to double check that this line highlight works.

← A current limitation is that `.wide` + `.numberLines` causes the line numbers to
be hidden.
```
<figcaption>This is the code block's caption. Like many of the other captions on
the page, it has a lot of text in it so that it's forced to wrap eventually.</figcaption>
</figure>

This is the text after the fig caption. **How is the gap** between the
figcaption and this text?

:::{.wide}
```
F
Plain code block, no div.sourceCode, but it's wide so the text might wrap around a bit further than code is normally expected to.
L
```
:::

```diff
❯ diff -u old.txt new.txt
--- old.txt     2022-02-27 22:15:29.475037186 -0800
+++ new.txt     2022-02-27 22:15:48.423040037 -0800
@@ -1,3 +1,3 @@
-This is some text that we're going to diff.
-This is another line of text.
+This is some text that we're going to run diff on.
 This is the last line of text in the file.
+Just kidding, this is the actual last line of the file.
```

```{.hl-2}
This code block has no syntax highlighting and therefore,
line highlights cannot be used,
because the line-by-line spans will not get inserted by pandoc.
```

```{.plaintext .hl-2}
Because pandoc does not recognize languages like plain or plaintext,
you can't even use that trick to get the spans to get inserted.
Thus if you want no syntax highlighting and line highlights,
the only option is to turn on line numbers with `.numberLines`
```

```{.ruby .hl-2}
def example
  puts("this line is highlighted, even without .numberLines")
end
```

# Block quotes

> Block quote, right under heading.
>
> Block quote, right under heading.

A paragraph after the block quote separates it from the second block quote on
the page.

> This block quote uses **bold text** and *italic text* in line one.\
> It also uses [small caps]{.smallcaps} and [**bold small caps**]{.smallcaps} in
> line two.\
> It also uses [underlined text]{.underline} and [linked text](#) and `inline
> code text` in line three.
>
> "Here's an example" of hanging-punctuation,\
> Followed by normal text again
>
> — Someone famous

The fun thing about markdown versus Dropbox Paper is that you can have lists in
block quotes:

> - This is a list in a block quote.
> - This is a list in a block quote.
>
> <!-- -->
>
> - This is a list in a block quote.
> - This is a list in a block quote.

# Colored notes

There are inline highlights, with various colors:

- This is some [Red]{.mark .red} text.
- [Yellow]{.mark .yellow}
- [Green]{.mark .green}
- [Blue]{.mark .blue}
- [Purple]{.mark .purple}

If you want you can also use HTML that's a little more semantic:\
<mark class="yellow">the HTML mark tag</mark>.

There are also single-element, colored tables, which get treated as colored
notes.

:::{.note .red}

|     |
| --- |
| 🛑 Look before you leap! |

:::

:::{.note .yellow}

|     |
| --- |
| ⚠️ This is a warning! |

:::

Hopefully this could just fall out if tables work well?

:::{.note .green}

|     |
| --- |
| ✅ Success! The deed is now done.<br><br>Feel free to retry whatever it is you were trying to do. |


:::

:::{.note .blue}

|     |
| --- |
| ℹ️ Consecutive notes are like consecutive tables. |

:::

:::{.note .purple}

|     |
| --- |
| 🔮 Can you see into the future? |

:::

Might make sense to do these in terms of like divs but for now they're tables.

# Side notes

Markdown footnotes become side notes.[^1] Versus
sup.<strong><sup>1</sup></strong> It would be neat to associate a range of text
with a footnote, rather than a single point.  The **second side note baseline**
will not line up. If we wrap this third line all the way around, we can see how
it behaves for longer lines as well. First: 1<sup>st</sup>

[^1]: Is the beginning aligned?\
Is the beginning aligned?

Markdown footnotes become side notes.[^margin] After the note. It would be neat
to associate a range of text with a footnote, rather than a single point. This
is longer text to give the paragraph some heft to it, so that the side note
doesn't feel overpowering.

[^margin]:
  {-} This is a margin note without a number. It spans just a few lines. Maybe
  it gets to three?

Markdown footnotes become side notes.[^2] After the note. It would be neat to
associate a range of text with a footnote, rather than a single point.  The
**second side note baseline** will not line up. If we wrap this third line all
the way around, we can see how it behaves for longer lines as well.

[^2]: There's `code` in this side note!

Markdown footnotes become side notes.[^long] After the note. This paragraph is
not short, but the margin note next to us is much longer, which pushes the
subsequent notes further away from their anchor. But also, footnotes.[^foot]

[^long]:
  {-} In this margin note, we've got quite a bit of text. It spans multiple so
  many lines that even in the Pandoc markdown source it spans multiple lines.\
  \
  It can have line breaks too. This should be a test of what happens when the
  margin note is more lines than the paragraph it's commenting on.

[^foot]:
  {.} Use a prefix of `{.}` to leave it as a footnote. Unfortunately, side notes
  and margin notes don't share the same namespace. If you want to mix side notes
  and footnotes in the same document, you might want to use margin notes, so
  that there is only one kind of numbered note.

> Without doing anything else,[^3] side notes that attach to text inside a block
> quote would magically become italic, because they'd inherit the styles of the
> surrounding block quote. Luckily, we have a test for this case, and that does
> not to happen because we fixed it.

[^3]:
  This side note attaches to a `blockquote`. Why would that be any
  different? Not sure. We reset the `font-style` and that's it.

Some text after the paragraph, to make sure that the inline and block sections
don't overlap with each other. Some text after the paragraph, to make sure that
the inline and block sections don't overlap with each other. Some text after the
paragraph, to make sure that the inline and block sections don't overlap with
each other. Some text after the paragraph, to make sure that the inline and
block sections don't overlap with each other.

## Block margin notes

Markdown footnotes become side notes. After the note. It would be neat to
associate a range of text with a footnote, rather than a single point. This is
longer text to give the paragraph some heft to it, so that the side note doesn't
feel overpowering.[^marginnote-block] Let's make this paragraph even longer, so
that it's clear that the next two notes are fully independent of this note's
size.

[^marginnote-block]:
  {^-} Should align with start of associated paragraph, despite being anchored
  to the end of the paragraph.

Markdown footnotes become side notes. After the note. It would be neat to
associate a range of text with a footnote, rather than a single point. This is
longer text to give the paragraph some heft to it, so that the side note doesn't
feel[^block1] overpowering.[^block2]

[^block1]:
    {^-} This block margin note is a bit longer, so that it wraps when shown in
    the margins. This block margin note is a bit longer, so that it wraps when
    shown in the margins.

    It contains multiple paragraphs, where we want the paragraph break to be
    smaller than the gap between unrelated margin notes.

[^block2]:
  {^-} The second block margin note in the same paragraph should get pushed
  down. The second block margin note in the same paragraph should get pushed
  down. The second block margin note in the same paragraph should get pushed
  down.

Markdown footnotes become side notes.[^block3]

[^block3]:
  {^-} The first margin note in the following paragraph should also get pushed
  down.

Spacer paragraph, so that the code block example resets back to normal. Spacer
paragraph, so that the code block example resets back to normal. Spacer
paragraph, so that the code block example resets back to normal. Spacer
paragraph, so that the code block example resets back to normal. Spacer
paragraph, so that the code block example resets back to normal.

Spacer paragraph, so that the code block example resets back to normal. Spacer
paragraph, so that the code block example resets back to normal. Spacer
paragraph, so that the code block example resets back to normal. Spacer
paragraph, so that the code block example resets back to normal. Spacer
paragraph, so that the code block example resets back to normal.

Spacer paragraph, so that the code block example resets back to normal. Spacer
paragraph, so that the code block example resets back to normal. Spacer
paragraph, so that the code block example resets back to normal. Spacer
paragraph, so that the code block example resets back to normal. Spacer
paragraph, so that the code block example resets back to normal.

The side note numbers should continue as normal.[^block-sidenote]

[^block-sidenote]: {^} A block-based side note

The side note numbers should continue as normal.[^block-sidenote2] Even with
multiple.[^block-sidenote3]

[^block-sidenote2]:
    {^}

    - There's a list in here
    - With some elements

[^block-sidenote3]:
    {^}


    ```ruby
    def hello; end
    ```

The side note numbers should continue as normal.

The side note numbers should work even if they get to double
digits.[^sn-extra-1] [^sn-extra-2] [^sn-extra-3] [^sn-extra-4] [^sn-extra-5]

[^sn-extra-1]: Back to inline side note, should continue numbering.
[^sn-extra-2]: Bump
[^sn-extra-3]: Bump
[^sn-extra-4]: Bump
[^sn-extra-5]: Bump

Lots of spacer paragraphs.

Lots of spacer paragraphs.

Lots of spacer paragraphs.

Lots of spacer paragraphs.

A paragraph accompanied by a block margin note with a syntax-highlighted code
block. Be careful when using this. You probably want to make sure that the code
block is marked `.wide` so that the content overflows the edges.
This is longer text to give the paragraph some heft to it, so that the side note
doesn't feel overpowering.[^code-note]

[^code-note]:
    {^-} You can use code blocks. They must be four-space indented for pandoc to
    recognize them.


    ```ruby
    def main
      # This is not marked .wide, so long lines will wrap instead of overflowing.
      puts "Hello, world!"
    end
    ```

    ```{.ruby .numberLines .hl-2}
    def main
      # This is not marked .wide, so long lines will wrap instead of overflowing.
      puts "Hello, world!"
    end
    ```

    :::{.wide}
    ```ruby
    def main
      # This one is .wide, meaning that long lines overflow horizontally.
      puts "Hello, world!"
    end
    ```
    :::

    :::{.wide}
    ```{.ruby .numberLines .hl-2}
    def main
      # This one is .wide, meaning that long lines overflow horizontally.
      # (The .wide .numberLines bug still applies.)
      puts "Hello, world!"
    end
    ```
    :::

<!--
  Also, I have to put a double blank line before the code block to avoid
  confusing my markdown syntax highlighter.
-->

A paragraph accompanied by a block margin note with a syntax-highlighted code
block. Be careful when using this. You probably want to make sure that the code
block is marked `.wide` so that the content overflows the edges. This is longer
text to give the paragraph some heft to it, so that the side note doesn't feel
overpowering.

A paragraph accompanied by a block margin note with a syntax-highlighted code
block. Be careful when using this. You probably want to make sure that the code
block is marked `.wide` so that the content overflows the edges. This is longer
text to give the paragraph some heft to it, so that the side note doesn't feel
overpowering.

A paragraph accompanied by a block margin note with a syntax-highlighted code
block. Be careful when using this. You probably want to make sure that the code
block is marked `.wide` so that the content overflows the edges. This is longer
text to give the paragraph some heft to it, so that the side note doesn't feel
overpowering.

A paragraph accompanied by a block margin note with a syntax-highlighted code
block. Be careful when using this. You probably want to make sure that the code
block is marked `.wide` so that the content overflows the edges. This is longer
text to give the paragraph some heft to it, so that the side note doesn't feel
overpowering.

A paragraph accompanied by a block margin note with a syntax-highlighted code
block. Be careful when using this. You probably want to make sure that the code
block is marked `.wide` so that the content overflows the edges. This is longer
text to give the paragraph some heft to it, so that the side note doesn't feel
overpowering.

- This is a list with multiple paragraphs in it. This is a list with multiple
  paragraphs in it. This is a list with multiple paragraphs in it. This is a
  list with multiple paragraphs in it. This is a list with multiple paragraphs
  in it. This is a list with multiple paragraphs in it.

  This is a list with multiple paragraphs in it. This is a list with multiple
  paragraphs in it. This is a list with multiple paragraphs in it. This is a
  list with multiple paragraphs in it. This is a list with multiple paragraphs
  in it. This is a list with multiple paragraphs in it.[^list2]

- This is a list with multiple paragraphs in it. This is a list with multiple
  paragraphs in it. This is a list with multiple paragraphs in it. This is a
  list with multiple paragraphs in it. This is a list with multiple paragraphs
  in it. This is a list with multiple paragraphs in it.[^list3]

[^list2]:
  {^} Align to second paragraph.

[^list3]:
  {^} Align to third paragraph.


| **Column 1**                 | **Column 2**       |
| --------------------         | ------------------ |
| This is `some` text.         | This is some text.[^table12] |
| This is some text.[^table21] | This is some text. |

[^table12]: {^} Row 1, column 2. Aligned to start of table.
[^table21]: {^} Row 2, column 1

An image in an inline margin note.[^inline-image] Markdown footnotes become side
notes. After the note. It would be neat to associate a range of text with a
footnote, rather than a single point. This is longer text to give the paragraph
some heft to it, so that the side note doesn't feel overpowering.

[^inline-image]:
  {-} ![Only alt text here, not caption](../img/sugarloaf-hill-forest-green.jpg)

Markdown footnotes become side notes. After the note. It would be neat to
associate a range of text with a footnote, rather than a single point. This is
longer text to give the paragraph some heft to it, so that the side note doesn't
feel overpowering.

Markdown footnotes become side notes. After the note. It would be neat to
associate a range of text with a footnote, rather than a single point. This is
longer text to give the paragraph some heft to it, so that the side note doesn't
feel overpowering. **This paragraph ends with a block image.**[^block-image]

[^block-image]:
  {^-} ![Only alt text here, not caption](../img/sugarloaf-hill-forest-green.jpg)

The image that comes before it pushes this image down. It still has no caption,
but that's a limitation of Pandoc markdown. There's an extra big gap, but that's
because we generate `<br><br>` at the end of every inline margin note.
`pandoc-sidenote` could be changed to stop doing that if we want?

The image that comes before it pushes this image down. It still has no caption,
but that's a limitation of Pandoc markdown. There's an extra big gap, but that's
because we generate `<br><br>` at the end of every inline margin note.
`pandoc-sidenote` could be changed to stop doing that if we want?

The image that comes before it pushes this image down. It still has no caption,
but that's a limitation of Pandoc markdown. There's an extra big gap, but that's
because we generate `<br><br>` at the end of every inline margin note.
`pandoc-sidenote` could be changed to stop doing that if we want?

This time, there's enough room for the block image to hoist to the top of the
associated paragraph. This time, there's enough room for the block image to
hoist to the top of the associated paragraph. This time, there's enough room for
the block image to hoist to the top of the associated
paragraph.[^block-image-start]

[^block-image-start]:
    {^-} ![Only alt text here, not caption](../img/sugarloaf-hill-forest-green.jpg)

    _Faking a caption with italics._

This time, there's enough room for the block image to hoist to the top of the
associated paragraph. This time, there's enough room for the block image to
hoist to the top of the associated paragraph. This time, there's enough room for
the block image to hoist to the top of the associated
paragraph.

This time, there's enough room for the block image to hoist to the top of the
associated paragraph. This time, there's enough room for the block image to
hoist to the top of the associated paragraph. This time, there's enough room for
the block image to hoist to the top of the associated
paragraph.

This time, there's enough room for the block image to hoist to the top of the
associated paragraph. This time, there's enough room for the block image to
hoist to the top of the associated paragraph. This time, there's enough room for
the block image to hoist to the top of the associated
paragraph.

An explicit figure in a side note. Unfortunately, Pandoc markdown doesn't turn
images in footnotes into figures automatically, so if you want this behavior
you have to write the `figure` HTML directly.[^figure-note]

[^figure-note]:
  {^-} <figure><img src="../img/sugarloaf-hill-forest-green.jpg" alt="Alt text is not caption"><figcaption aria-hidden="true">Proper caption now</figcaption></figure>

This time, there's enough room for the block image to hoist to the top of the
associated paragraph. This time, there's enough room for the block image to
hoist to the top of the associated paragraph. This time, there's enough room for
the block image to hoist to the top of the associated
paragraph.


# Images

We can also handle images:

![Sugarloaf Hill, San Mateo, CA, April 2021](../img/sugarloaf-hill-forest-green.jpg)

This is some text after the image. The interesting thing is that the presence of
a caption pushes the following paragraph down. For example, here's an image
without a caption:

![](../img/el-capitan-from-four-mile-trail.jpg)

![](../img/el-capitan-from-four-mile-trail.jpg)

Notice how the text after the image resumes further away, instead of being
close to the image.

We can also do extra wide and full width images:

:::{.wide .extra-wide}
![](../img/sugarloaf-hill-trail-april-june.jpg)
:::

This project provides CSS files and a template for using Pandoc to generate
standalone HTML files. It supports most features Pandoc Markdown has to offer,
and some extras. The default look can be tweaked via CSS variables, and it does
not need JavaScript, even for side notes.

:::{.wide .extra-wide}
![Sugarloaf Hill, San Mateo, CA. Left: April 2021, right: June 2021](../img/sugarloaf-hill-trail-april-june.jpg)
:::

This project provides CSS files and a template for using Pandoc to generate
standalone HTML files. It supports most features Pandoc Markdown has to offer,
and some extras. The default look can be tweaked via CSS variables, and it does
not need JavaScript, even for side notes.

:::{.wide .full-width .left-align-caption}

![Upper Crystal Springs Reservoir, near Belmont, CA](../img/upper-crystal-springs-reservoir-facing-northwest.jpg)

:::

And some text after the extra wide image. There's **currently a bug** making it
so that this text isn't as tight as text for non-extra-wide images because
there's an extra div around it. But maybe that's actually a feature not a bug.

# Tables

| **Column 1**         | **Column 2**       |
| -------------------- | ------------------ |
| This is `some` text. | This is some text. |
| This is some text.   | This is some text. |

| **Column 1**       | **Column 2**       |
| ------------------ | ------------------ |
| This is some text. | This is some text. |
| This is some text. | This is some text. |

The wild thing is that this is as tight as the body text gets to the table.

---------------------------------------
Column 1            Column 2
------------------- -------------------
This is some text.  This is some text.

This is some text.  This is some text.
------------------- -------------------

| **Column 1**       | **Column 2**       |
| ------------------ | ------------------ |
| This is some text. | This is some text. |
| This is some text. | This is some text. |

  : This table has a caption.

We can also make tables become wider than the main text if there's a lot of
stuff in the table. They suffer the same "**margin is too big**" bug that extra
wide images do.

:::{.wide .left-align-caption}

| **Column 1**                          | **Column 2**                          | **Column 3**                          | **Column 4**                          | **Column 5**                          |
| ------------------                    | ------------------                    | ------------------                    | ------------------                    | ------------------                    |
| This is some text. This is some text. | This is some text. This is some text. | This is some text. This is some text. | This is some text. This is some text. | This is some text. This is some text. |
| This is some text. This is some text. | This is some text. This is some text. | This is some text. This is some text. | This is some text. This is some text. | This is some text. This is some text. |

Table: The difference between `wide` and `extra-wide` is that extra-wide is the
only one that will expand into the left **and** right columns.\
\
Meanwhile, `wide` will expand past the right column when the center column is
smaller than `--main-width`.

:::

:::{.wide .extra-wide}

| **Column 1**       | **Column 2**       | **Column 3**       | **Column 4**       | **Column 5**       | **Column 6**       | **Column 7**       | **Column 8**       | **Column 9**       | **Column 10**      |
| ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ |
| This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. |
| This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. |

  : This extra wide table also has a caption. It has quite a bit of text in the
    caption, so it wraps onto multiple lines when rendered at smaller screen
    sizes.

:::

:::{.wide .extra-wide}

| **Column 1**       | **Column 2**       | **Column 3**       | **Column 4**       | **Column 5**       | **Column 6**       | **Column 7**       | **Column 8**       | **Column 9**       | **Column 10**      | **Column 11**       | **Column 12**       | **Column 13**       | **Column 14**       | **Column 15**       | **Colum 16**       | **Colum 17**       | **Colum 18**       | **Colum 19**       | **Colum 20**      |
| ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ |
| This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. |           This is some text. | This is some text. | This is some text. | This is some text. | This is some text. |
| This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. |           This is some text. | This is some text. | This is some text. | This is some text. | This is some text. |

  : This extra wide table also has a caption. It has quite a bit of text in the
    caption, so it wraps onto multiple lines when rendered at smaller screen
    sizes.

:::

:::{.wide .full-width}

| **Column 1**       | **Column 2**       | **Column 3**       | **Column 4**       | **Column 5**       | **Column 6**       | **Column 7**       | **Column 8**       | **Column 9**       | **Column 10**      | **Column 11**       | **Column 12**       | **Column 13**       | **Column 14**       | **Column 15**       | **Colum 16**       | **Colum 17**       | **Colum 18**       | **Colum 19**       | **Colum 20**      |
| ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ | ------------------ |
| This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. |           This is some text. | This is some text. | This is some text. | This is some text. | This is some text. |
| This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. | This is some text. |           This is some text. | This is some text. | This is some text. | This is some text. | This is some text. |

  : A full width table takes up pretty much all space available.

:::

Maybe it would be nice to have some way to dynamically say how much extra space
a table should take up, but for nowe we have only three break points: wide,
extra-wide, and full-width.

We can use Pandoc's fancy tables to make some columns wider:

:::{.wide}

---------------------------------------------------------------------------------
Column 1                                                     Column 2
------------------------------------------------------------ --------------------
This is a really wide column using pandoc's fancy tables.    This is narrow.

This is a really wide column using pandoc's fancy tables.    This is narrow.
---------------------------------------------------------------------------------

:::

|           |             |
| ---       | ---         |
| No header | Still works |

+----------------------------------------------------------+----------------------------------------------------------+
| Column 1                                                 | Column 2                                                 |
+==========================================================+==========================================================+
| This is some text                                        | These kinds of tables are called grid                    |
|                                                          | tables. The nice thing is that you can make them         |
| It spans multiple lines in one grid.                     | span multiple lines, at the cost of being                |
|                                                          | annnoying to reformat.                                   |
| ```ruby                                                  |                                                          |
| puts("Hello, world!)                                     | - A list inside a table cell                             |
| ```                                                      | - Another list item in the list                          |
|                                                          |                                                          |
| This table cell is considerably longer than the first,   |                                                          |
| which is a test of whether we are properly vertically    |                                                          |
| aligning the content in the second column. By default,   |                                                          |
| it seems like Chrome (maybe all browsers?) vertically    |                                                          |
| align table content to the middle.                       |                                                          |
+----------------------------------------------------------+----------------------------------------------------------+
| This is some text                                        | These kinds of tables are called grid                    |
|                                                          | tables. The nice thing is that you can make them         |
| It spans multiple lines in one grid.                     | span multiple lines, at the cost of being                |
|                                                          | annnoying to reformat.                                   |
| ```ruby                                                  |                                                          |
| puts("Hello, world!)                                     | - A list inside a table cell                             |
| ```                                                      | - Another list item in the list                          |
+----------------------------------------------------------+----------------------------------------------------------+

:::{.wide .extra-wide}

+----------------------------------------------------------+----------------------------------------------------------+
| Column 1                                                 | Column 2                                                 |
+==========================================================+==========================================================+
| This is some text                                        | These kinds of tables are called grid                    |
|                                                          | tables. The nice thing is that you can make them         |
| It spans multiple lines in one grid.                     | span multiple lines, at the cost of being                |
|                                                          | annnoying to reformat.                                   |
| ```ruby                                                  |                                                          |
| puts("Hello, world!)                                     | - A list inside a table cell                             |
| ```                                                      | - Another list item in the list                          |
|                                                          |                                                          |
| This table cell is considerably longer than the first,   |                                                          |
| which is a test of whether we are properly vertically    |                                                          |
| aligning the content in the second column. By default,   |                                                          |
| it seems like Chrome (maybe all browsers?) vertically    |                                                          |
| align table content to the middle.                       |                                                          |
+----------------------------------------------------------+----------------------------------------------------------+
| This is some text                                        | These kinds of tables are called grid                    |
|                                                          | tables. The nice thing is that you can make them         |
| It spans multiple lines in one grid.                     | span multiple lines, at the cost of being                |
|                                                          | annnoying to reformat.                                   |
| ```ruby                                                  |                                                          |
| puts("Hello, world!)                                     | - A list inside a table cell                             |
| ```                                                      | - Another list item in the list                          |
+----------------------------------------------------------+----------------------------------------------------------+

Table: A wide table with a caption.

:::
