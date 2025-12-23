-- Minimal Tufte-style sidenotes for pandoc-markdown-css-theme.
-- Inspired by https://github.com/jez/pandoc-sidenote

local counter = 0

local function drop_margin_marker(blocks)
  if #blocks == 0 then
    return false
  end

  local first = blocks[1]
  if first.t ~= "Para" then
    return false
  end

  local inlines = first.content
  if #inlines == 0 then
    return false
  end

  if inlines[1].t == "Str" and inlines[1].text == "{-}" then
    table.remove(inlines, 1)
    if #inlines > 0 and inlines[1].t == "Space" then
      table.remove(inlines, 1)
    end
    first.content = inlines
    blocks[1] = first
    return true
  end

  return false
end

local function blocks_to_inlines(blocks)
  if pandoc.utils and pandoc.utils.blocks_to_inlines then
    return pandoc.utils.blocks_to_inlines(blocks)
  end
  -- Fallback: stringify the blocks.
  return { pandoc.Str(pandoc.utils.stringify(pandoc.Pandoc(blocks))) }
end

local function render_note(blocks, margin)
  counter = counter + 1
  local id = string.format("%s-%d", margin and "mn" or "sn", counter)
  local inlines = blocks_to_inlines(blocks)

  local open = pandoc.RawInline("html", '<span class="sidenote-wrapper">')
  local label = margin
      and pandoc.RawInline(
          "html",
          string.format('<label for="%s" class="margin-toggle">⊕</label>', id)
        )
      or pandoc.RawInline(
          "html",
          string.format(
              '<label for="%s" class="margin-toggle sidenote-number"></label>',
              id
          )
        )
  local input = pandoc.RawInline(
      "html",
      string.format('<input type="checkbox" id="%s" class="margin-toggle"/>', id)
    )
  local span = pandoc.Span(inlines, { class = margin and "marginnote" or "sidenote" })
  local close = pandoc.RawInline("html", "</span>")

  return { open, label, input, span, close }
end

function Note(note)
  local blocks = note.content
  local is_margin = drop_margin_marker(blocks)
  return render_note(blocks, is_margin)
end
