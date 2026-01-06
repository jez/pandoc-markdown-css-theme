--
--                            pandoc-sidenote.lua
--
-- Author:    Jacob Zimmerman (@jez)
-- Version:   0.26.0
-- Modified:  2026-01-04
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
      if inlines[1] and inlines[1].tag == "Space" then
        inlines:remove(1)
      end
      return "marginnote"
    end

    -- '{^-}' indicates that it should be a margin note, but using the
    -- hoisted block markup, instead of remaining inline.
    if inlines[1].text == "{^-}" then
      inlines:remove(1)
      if inlines[1] and inlines[1].tag == "Space" then
        inlines:remove(1)
      end
      return "marginnote-block"
    end

    -- '{^}' indicates that it should be a side note, but using the
    -- hoisted block markup, instead of remaining inline.
    if inlines[1].text == "{^}" then
      inlines:remove(1)
      if inlines[1] and inlines[1].tag == "Space" then
        inlines:remove(1)
      end
      return "sidenote-block"
    end

    -- '{.}' indicates whether to leave the footnote untouched (a footnote)
    if inlines[1].text == "{.}" then
      inlines:remove(1)
      if inlines[1] and inlines[1].tag == "Space" then
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

notesStack = {}

snIdx = -1

noteVisitor = {
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

    local notes = notesStack[#notesStack]
    notes[#notes + 1] = {
      snIdx = snIdx,
      kind = noteKind,
      content = note.content,
    }
    return makeLabel(snIdx, noteKind)
  end,
}

function translateNotes(notes)
  local translatedNotes = {}

  for i = 1, #notes do
    note = notes[i]
    local contentClass = note.kind
    -- Use original classes for backwards compatibility.
    -- If people really want to care about the distinction,
    -- they can write `div.marginnote` or `span.marginnote`
    if contentClass == "marginnote-block" then
      contentClass = "marginnote"
    elseif contentClass == "sidenote-block" then
      contentClass = "sidenote"
    end

    translatedNotes[#translatedNotes + 1] = pandoc.Div(
      pandoc.Blocks({
        pandoc.RawBlock("html", makeInputHTML(note.snIdx)),
        pandoc.Div(note.content, { class = contentClass }),
      }),
      { class = "sidenote-wrapper" }
    )
  end

  return translatedNotes
end

function collectNotes(node)
  notesStack[#notesStack + 1] = {}
  node.content = node.content:walk(noteVisitor)
  local notes = table.remove(notesStack, #notesStack)
  return translateNotes(notes)
end

function visitListOfBlocks(blockss)
  for i = 1, #blockss do
    local blocks = blockss[i]
    visitBlocks(blocks)
  end
  return {}
end

blockVisitor = {
  BlockQuote = function(node)
    visitBlocks(node.content)
    return {}, nil
  end,
  BulletList = function(node)
    return visitListOfBlocks(node.content), nil
  end,
  CodeBlock = function(node)
    return {}, nil
  end,
  DefinitionList = function(node)
    notesStack[#notesStack + 1] = {}
    for i = 1, #node.content do
      local item = node.content[i]
      local term = item[1]
      local definition = item[2]
      node:walk(noteVisitor)
      visitListOfBlocks(definition)
    end

    -- Unfortunately, the best we can do is either hoist any notes in the terms
    -- to before the entire list, or to push the note into the start of the
    -- definition. This implementation chooses the former. Realistically, notes
    -- in the definitions should probably use inline side notes instead of
    -- block-based side notes.
    local notes = table.remove(notesStack, #notesStack)
    return translateNotes(notes), nil
  end,
  Div = function(node)
    visitBlocks(node.content)
    return {}, nil
  end,
  Figure = function(node)
    visitBlocks(node.content)
    return {}, nil
  end,
  Header = function(node)
    return collectNotes(node), nil
  end,
  HorizontalRule = function(node)
    return {}, nil
  end,
  LineBlock = function(node)
    return collectNotes(node), nil
  end,
  OrderedList = function(node)
    return visitListOfBlocks(node.content), nil
  end,
  Para = function(node)
    return collectNotes(node), nil
  end,
  Plain = function(node)
    return collectNotes(node), nil
  end,
  RawBlock = function(node)
    return {}, nil
  end,
  Table = function(node)
    notesStack[#notesStack + 1] = {}

    newTable = node:walk(noteVisitor)

    local notes = table.remove(notesStack, #notesStack)
    return translateNotes(notes), newTable
  end,
}

function visitBlocks(blocks)
  local result = {}
  for i = 1, #blocks do
    local block = blocks[i]
    local newBlocks, replacedElem = blockVisitor[block.tag](block)
    for j = 1, #newBlocks do
      result[#result + 1] = newBlocks[j]
    end
    if replacedElem then
      result[#result + 1] = replacedElem
    else
      result[#result + 1] = block
    end
  end
  for i = 1, #result do
    blocks[i] = result[i]
  end
end

function Pandoc(doc)
  visitBlocks(doc.blocks)
  return doc
end
