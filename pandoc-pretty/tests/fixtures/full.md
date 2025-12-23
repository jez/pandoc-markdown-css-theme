---
title: Full Feature Doc
author: Test Author
date: 2025-12-23
---

# Heading One

This paragraph includes inline math $a^2 + b^2 = c^2$, bold **text**, italic
_text_, inline code `printf("hi")`, a link to [example.com], and a sidenote.[^sn]

## Heading Two

- Bullet list item
- Another item with a nested list
  - child item
  - child item 2
- [ ] task unchecked
- [x] task checked

1. Ordered item one
2. Ordered item two

> Blockquote with a footnote reference.[^foot]

```python
def hello():
    return "world"
```

```rust
fn main() {
    println!("hello");
}
```

### Math Block

$$
E = mc^2
$$

### Table

| Animal | Legs | Note        |
|:-------|-----:|:------------|
| Cat    |   4  | small       |
| Ant    |   6  | very small  |

---

[^sn]: {-} This is a margin note rendered by the sidenote filter.
[^foot]: Footnote content with *emphasis*.

[example.com]: https://example.com
