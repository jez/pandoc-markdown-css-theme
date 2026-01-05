--
--                            pandoc-sidenote.lua
--
-- Author:    Jacob Zimmerman (@jez)
-- Version:   0.24.0
-- Modified:  2025-11-02
-- URL:       https://github.com/jez/pandoc-sidenote
--

--------------------------------------------------------------------------------
-- The MIT License (MIT)
--
-- Copyright (c) 2025 Jacob Zimmerman
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to
-- deal in the Software without restriction, including without limitation the
-- rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
-- sell copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.
--------------------------------------------------------------------------------

local function startsWithStrSpace(inlines, canOmitSpace)
  if not inlines[1] or inlines[1].tag ~= "Str" then
    return false
  end
  if not inlines[2] then
    return canOmitSpace
  end
  if inlines[2].tag ~= "Space" then
    return false
  end

  return true
end

local function stripNoteAttribute(inlines, canOmitSpace)
  if startsWithStrSpace(inlines, canOmitSpace) then
    -- The '{-}' symbol differentiates between margin note and side note
    if inlines[1].text == "{-}" then
      inlines:remove(1)
      if inlines[1] and inlines[1].tag == 'Space' then
        inlines:remove(1)
      end
      return "marginnote"
    end

    -- '{^-}' indicates that it should be a margin note, but using the
    -- hoisted block markup, instead of remaining inline.
    if inlines[1].text == "{^-}" then
      inlines:remove(1)
      if inlines[1] and inlines[1].tag == 'Space' then
        inlines:remove(1)
      end
      return "marginnote-block"
    end

    -- '{^}' indicates that it should be a side note, but using the
    -- hoisted block markup, instead of remaining inline.
    if inlines[1].text == "{^}" then
      inlines:remove(1)
      if inlines[1] and inlines[1].tag == 'Space' then
        inlines:remove(1)
      end
      return "sidenote-block"
    end

    -- '{.}' indicates whether to leave the footnote untouched (a footnote)
    if inlines[1].text == "{.}" then
      inlines:remove(1)
      if inlines[1] and inlines[1].tag == 'Space' then
        inlines:remove(1)
      end
      return "footnote"
    end
  end

  return "sidenote"
end

local function mungeBlocks(blocks)
  if #blocks == 0 then
    return "sidenote"
  end

  local block = blocks[1]

  if block.tag == "Plain" or block.tag == "Para" then
    return stripNoteAttribute(block.content, #blocks > 1)
  elseif block.tag == "LineBlock" then
    local firstInlines = block.content[1]
    if firstInlines then
      return stripNoteAttribute(firstInlines, #block.content > 1 or #blocks > 1)
    end

    return "sidenote"
  else
    return "sidenote"
  end
end

local function append(xs, ys)
  for i = 1, #ys do
    xs[#xs + 1] = ys[i]
  end
end

-- TODO(jez) Can you rewrite this with a walk?
local function accumulateInlines(inlines, block)
  if block.tag == "Plain" then
    append(inlines, block.content)
  elseif block.tag == "Para" then
    -- Simulate paragraphs with double LineBreak
    append(inlines, block.content)
    inlines[#inlines + 1] = pandoc.LineBreak()
    inlines[#inlines + 1] = pandoc.LineBreak()
  elseif block.tag == "LineBlock" then
    -- See extension: line_blocks
    for i = 1, #block.content do
      append(inlines, block.content[i])
    end
  elseif block.tag == "RawBlock" then
    -- Pretend RawBlock is RawInline (might not work!)
    -- Consider: raw <div> now inside RawInline... what happens?
    inlines[#inlines + 1] = pandoc.RawInline(block.format, block.text)
  end

  -- lists, blockquotes, headers, hrs, and tables are all omitted.
  -- Think they shouldn't be? I'm open to sensible PR's.
end

-- Extract inlines from blocks. Note has Blocks, but Span needs Inlines
local function coerceToInline(blocks)
  blocks = blocks:walk({
    Note = function(note)
      return pandoc.Str("")
    end,
  })

  local inlines = {}

  for i = 1, #blocks do
    accumulateInlines(inlines, blocks[i])
  end

  return inlines
end

local function makeLabel(snIdx, noteKind)
  local labelCls = "margin-toggle"
  if noteKind == "sidenote" or noteKind == "sidenote-block" then
    labelCls = labelCls .. " sidenote-number"
  end

  local labelSym
  if noteKind == "marginnote" or noteKind == "marginnote-block" then
    labelSym = "&#8853;"
  else
    labelSym = ""
  end

  local labelFormatStr = '<label for="sn-%d" class="%s">%s</label>'
  local labelHTML = labelFormatStr:format(snIdx, labelCls, labelSym)
  return pandoc.RawInline("html", labelHTML)
end

local function makeInputHTML(snIdx)
  local inputFormatStr = '<input type="checkbox" id="sn-%d" class="margin-toggle"/>'
  return inputFormatStr:format(snIdx)
end

local snIdx = -1

-- TODO(jez) Can you make this use whatever OOP features Lua has?
local function makeBlockWalker()
  local notes = {}
  return {
    notes = notes,
    -- Just to be explicit, because there are two different walks in play.
    traverse = "typewise",
    filter = {
      Note = function(note)
        local noteKind = mungeBlocks(note.content)
        if noteKind == "footnote" then
          return note
        end

        -- Generate a unique number for the `for=` attribute
        snIdx = snIdx + 1

        if noteKind ~= "marginnote-block" and noteKind ~= "sidenote-block" then
          local inlines = coerceToInline(note.content)
          return pandoc.Span({
            makeLabel(snIdx, noteKind),
            pandoc.RawInline("html", makeInputHTML(snIdx)),
            pandoc.Span(inlines, { class = noteKind }),
          }, { class = "sidenote-wrapper" })
        end

        notes[#notes + 1] = {
          snIdx = snIdx,
          kind = noteKind,
          content = note.content,
        }
        return makeLabel(snIdx, noteKind)
      end,
    },
  }
end

traverse = "topdown"

-- TODO(jez) Handle footnotes inside Note itself.
--
-- Actually, it looks like pandoc markdown doesn't parse recursive footnotes.
-- The AST doesn't seem to preclude building them, so maybe other readers or
-- other filters could produce such ASTs. Going to punt for now though.

function Blocks(blocks)
  local result = {}

  for i = 1, #blocks do
    local block = blocks[i]
    local blockWalker = makeBlockWalker()

    -- Handles non-block sidenotes/marginnotes, and collects the block ones
    local newBlock = block:walk(blockWalker.filter)

    -- Hoist block sidenotes/marginnotes ahead of their containing block
    for j = 1, #blockWalker.notes do
      local note = blockWalker.notes[j]

      local contentClass = note.kind
      -- Use original classes for backwards compatibility.
      -- If people really want to care about the distinction,
      -- they can write `div.marginnote` or `span.marginnote`
      if contentClass == "marginnote-block" then
        contentClass = "marginnote"
      elseif contentClass == "sidenote-block" then
        contentClass = "sidenote"
      end

      result[#result + 1] = pandoc.Div(
        pandoc.Blocks({
          pandoc.RawBlock("html", makeInputHTML(note.snIdx)),
          pandoc.Div(note.content, { class = contentClass }),
        }),
        { class = "sidenote-wrapper" }
      )
    end

    -- Reinsert the (transformed) block
    result[#result + 1] = newBlock
  end

  local shouldRecurse = false
  return pandoc.Blocks(result), shouldRecurse
end
