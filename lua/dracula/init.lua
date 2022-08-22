local o = vim.o
local g = vim.g
local cmd = vim.cmd

---@class DefaultConfig
local DEFAULT_OPTIONS = {
   italic_comment = g.dracula_italic_comment,
   transparent_bg = g.dracula_transparent_bg,
   show_end_of_buffer = g.dracula_show_end_of_buffer,
   lualine_bg_color = g.dracula_lualine_bg_color,
   colors = {
      bg = "#282A36",
      fg = "#F8F8F2",
      selection = "#44475A",
      comment = "#6272A4",
      red = "#FF5555",
      orange = "#FFB86C",
      yellow = "#F1FA8C",
      green = "#50fa7b",
      purple = "#BD93F9",
      cyan = "#8BE9FD",
      pink = "#FF79C6",
      bright_red = "#FF6E6E",
      bright_green = "#69FF94",
      bright_yellow = "#FFFFA5",
      bright_blue = "#D6ACFF",
      bright_magenta = "#FF92DF",
      bright_cyan = "#A4FFFF",
      bright_white = "#FFFFFF",
      menu = "#21222C",
      visual = "#3E4452",
      gutter_fg = "#4B5263",
      nontext = "#3B4048",
      white = "#ABB2BF",
      black = "#191A21",
   },
}

local TRANSPARENTS = {
   "Normal",
   "SignColumn",
   "NvimTreeNormal",
   "NvimTreeVertSplit",
}

local function apply_term_colors(colors)
   g.terminal_color_0 = colors.black
   g.terminal_color_1 = colors.red
   g.terminal_color_2 = colors.green
   g.terminal_color_3 = colors.yellow
   g.terminal_color_4 = colors.purple
   g.terminal_color_5 = colors.pink
   g.terminal_color_6 = colors.cyan
   g.terminal_color_7 = colors.white
   g.terminal_color_8 = colors.selection
   g.terminal_color_9 = colors.bright_red
   g.terminal_color_10 = colors.bright_green
   g.terminal_color_11 = colors.bright_yellow
   g.terminal_color_12 = colors.bright_blue
   g.terminal_color_13 = colors.bright_magenta
   g.terminal_color_14 = colors.bright_cyan
   g.terminal_color_15 = colors.bright_white
   g.terminal_color_background = colors.bg
   g.terminal_color_foreground = colors.fg
end

---apply dracula colorscheme
---@param opts DefaultConfig
local function apply(opts)
   local isItalic = opts.italic_comment
   local isShowBufEnd = opts.show_end_of_buffer
   local colors = opts.colors
   apply_term_colors(colors)

   -- highlight(Group, Foreground, Backgroud, Attribute, Special)
   local highlights = {
      Normal = { fg = colors.fg, bg = colors.bg, },
      NormalFloat = { fg = colors.fg, bg = colors.bg, },
      Comment = { fg = colors.comment, attr = isItalic and "italic" or nil, },
      Constant = { fg = colors.yellow, },
      String = { fg = colors.yellow, },
      Character = { fg = colors.green, },
      Number = { fg = colors.orange, },
      Boolean = { fg = colors.cyan, },
      Float = { fg = colors.orange, },
      FloatBorder = { fg = colors.white, },
      Operator = { fg = colors.purple, },
      Keyword = { fg = colors.cyan, },
      Keywords = { fg = colors.cyan, },
      Identifier = { fg = colors.cyan, },
      Function = { fg = colors.yellow, },
      Statement = { fg = colors.purple, },
      Conditional = { fg = colors.pink, },
      Repeat = { fg = colors.pink, },
      Label = { fg = colors.cyan, },
      Exception = { fg = colors.purple, },
      PreProc = { fg = colors.yellow, },
      Include = { fg = colors.purple, },
      Define = { fg = colors.purple, },
      Title = { fg = colors.cyan, },
      Macro = { fg = colors.purple, },
      PreCondit = { fg = colors.cyan, },
      Type = { fg = colors.cyan, },
      StorageClass = { fg = colors.pink, },
      Structure = { fg = colors.yellow, },
      TypeDef = { fg = colors.yellow, },
      Special = { fg = colors.green, attr = "italic", },
      SpecialComment = { fg = colors.comment, attr = "italic", },
      Error = { fg = colors.bright_red, },
      Todo = { fg = colors.purple, attr = "bold,italic", },
      Underlined = { fg = colors.cyan, attr = "underline", },

      Cursor = { attr = "reverse", },
      CursorLineNr = { fg = colors.fg, attr = "bold", },

      SignColumn = { bg = colors.bg, },

      Conceal = { fg = colors.comment, },
      CursorColumn = { bg = colors.black, },
      CursorLine = { bg = colors.selection, },
      ColorColumn = { bg = colors.selection, },

      StatusLine = { fg = colors.white, bg = colors.black, },
      StatusLineNC = { fg = colors.comment, },
      StatusLineTerm = { fg = colors.white, bg = colors.black, },
      StatusLineTermNC = { fg = colors.comment, },

      Directory = { fg = colors.cyan, },
      DiffAdd = { fg = colors.bg, bg = colors.green, },
      DiffChange = { fg = colors.orange, },
      DiffDelete = { fg = colors.red, },
      DiffText = { fg = colors.comment, },

      ErrorMsg = { fg = colors.bright_red, },
      VertSplit = { fg = colors.black, },
      Folded = { fg = colors.comment, },
      FoldColumn = {},
      Search = { fg = colors.black, bg = colors.orange, },
      IncSearch = { fg = colors.orange, bg = colors.comment, },
      LineNr = { fg = colors.comment, },
      MatchParen = { fg = colors.fg, attr = "underline", },
      NonText = { fg = colors.nontext, },
      Pmenu = { fg = colors.white, bg = colors.menu, },
      PmenuSel = { fg = colors.white, bg = colors.selection, },
      PmenuSbar = { bg = colors.bg, },
      PmenuThumb = { bg = colors.selection, },

      Question = { fg = colors.purple, },
      QuickFixLine = { fg = colors.black, bg = colors.yellow, },
      SpecialKey = { fg = colors.nontext, },

      SpellBad = { fg = colors.bright_red, attr = "underline", },
      SpellCap = { fg = colors.yellow, },
      SpellLocal = { fg = colors.yellow, },
      SpellRare = { fg = colors.yellow, },

      TabLine = { fg = colors.comment, },
      TabLineSel = { fg = colors.white, },
      TabLineFill = { bg = colors.bg, },
      Terminal = { fg = colors.white, bg = colors.black, },
      Visual = { bg = colors.visual, },
      VisualNOS = { fg = colors.visual, },
      WarningMsg = { fg = colors.yellow, },
      WildMenu = { fg = colors.black, bg = colors.white, },

      EndOfBuffer = { fg = isShowBufEnd and colors.visual or colors.bg, },

      -- TreeSitter
      TSError = { fg = colors.bright_red, },
      TSPunctDelimiter = { fg = colors.fg, },
      TSPunctBracket = { fg = colors.fg, },
      TSPunctSpecial = { fg = colors.fg, },

      TSConstant = { fg = colors.purple, },
      TSConstantBuiltin = { fg = colors.purple, },

      TSConstMacro = { fg = colors.cyan, },
      TSStringRegex = { fg = colors.red, },
      TSString = { fg = colors.yellow, },
      TSStringEscape = { fg = colors.cyan, },
      TSCharacter = { fg = colors.green, },
      TSNumber = { fg = colors.purple, },
      TSBoolean = { fg = colors.purple, },
      TSFloat = { fg = colors.green, },
      TSAnnotation = { fg = colors.yellow, },
      TSAttribute = { fg = colors.cyan, },
      TSNamespace = { fg = colors.orange, },

      TSFuncBuiltin = { fg = colors.cyan, },
      TSFunction = { fg = colors.green, },
      TSFuncMacro = { fg = colors.green, },
      TSParameter = { fg = colors.orange, },
      TSParameterReference = { fg = colors.orange, },
      TSMethod = { fg = colors.green, },
      TSField = { fg = colors.orange, },
      TSProperty = { fg = colors.fg, },
      TSConstructor = { fg = colors.cyan, },

      TSConditional = { fg = colors.pink, },
      TSRepeat = { fg = colors.pink, },
      TSLabel = { fg = colors.cyan, },

      TSKeyword = { fg = colors.pink, },
      TSKeywordFunction = { fg = colors.cyan, },
      TSKeywordOperator = { fg = colors.pink, },
      TSOperator = { fg = colors.pink, },
      TSException = { fg = colors.purple, },
      TSType = { fg = colors.bright_cyan, },
      TSTypeBuiltin = { fg = colors.cyan, attr = "italic", },
      TSStructure = { fg = colors.purple, },
      TSInclude = { fg = colors.pink, },

      TSVariable = { fg = colors.fg, },
      TSVariableBuiltin = { fg = colors.purple, },

      TSText = { fg = colors.orange, },
      TSStrong = { fg = colors.orange, attr = "bold", }, -- bold
      TSEmphasis = { fg = colors.yellow, attr = "italic", }, -- italic
      TSUnderline = { fg = colors.orange, },
      TSTitle = { fg = colors.pink, }, -- title
      TSLiteral = { fg = colors.yellow, }, -- inline code
      TSURI = { fg = colors.yellow, attr = "italic", }, -- urls

      TSTag = { fg = colors.cyan, },
      TSTagDelimiter = { fg = colors.white, },

      -- HTML
      htmlArg = { fg = colors.yellow, },
      htmlBold = { fg = colors.yellow, attr = "bold", },
      htmlEndTag = { fg = colors.white, },
      htmlH1 = { fg = colors.pink, },
      htmlH2 = { fg = colors.pink, },
      htmlH3 = { fg = colors.pink, },
      htmlH4 = { fg = colors.pink, },
      htmlH5 = { fg = colors.pink, },
      htmlH6 = { fg = colors.pink, },
      htmlItalic = { fg = colors.purple, attr = "italic", },
      htmlLink = { fg = colors.purple, attr = "underline", },
      htmlSpecialChar = { fg = colors.yellow, },
      htmlSpecialTagName = { fg = colors.cyan, },
      htmlTag = { fg = colors.pink, },
      htmlTagN = { fg = colors.pink, },
      htmlTagName = { fg = colors.cyan, },
      htmlTitle = { fg = colors.white, },

      -- Markdown
      markdownBlockquote = { fg = colors.yellow, attr = "italic", },
      markdownBold = { fg = colors.orange, attr = "bold", },
      markdownCode = { fg = colors.green, },
      markdownCodeBlock = { fg = colors.orange, },
      markdownCodeDelimiter = { fg = colors.red, },
      markdownH1 = { fg = colors.pink, attr = "bold", },
      markdownH2 = { fg = colors.pink, attr = "bold", },
      markdownH3 = { fg = colors.pink, attr = "bold", },
      markdownH4 = { fg = colors.pink, attr = "bold", },
      markdownH5 = { fg = colors.pink, attr = "bold", },
      markdownH6 = { fg = colors.pink, attr = "bold", },
      markdownHeadingDelimiter = { fg = colors.red, },
      markdownHeadingRule = { fg = colors.comment, },
      markdownId = { fg = colors.purple, },
      markdownIdDeclaration = { fg = colors.cyan, },
      markdownIdDelimiter = { fg = colors.purple, },
      markdownItalic = { fg = colors.yellow, attr = "italic", },
      markdownLinkDelimiter = { fg = colors.purple, },
      markdownLinkText = { fg = colors.pink, },
      markdownListMarker = { fg = colors.cyan, },
      markdownOrderedListMarker = { fg = colors.red, },
      markdownRule = { fg = colors.comment, },

      --  Diff
      diffAdded = { fg = colors.green, },
      diffRemoved = { fg = colors.red, },
      diffFileId = { fg = colors.yellow, attr = "bold,reverse", },
      diffFile = { fg = colors.nontext, },
      diffNewFile = { fg = colors.green, },
      diffOldFile = { fg = colors.red, },

      debugPc = { bg = colors.cyan, },
      debugBreakpoint = { fg = colors.red, attr = "reverse", },

      -- Git Signs
      GitSignsAdd = { fg = colors.bright_green, },
      GitSignsChange = { fg = colors.cyan, },
      GitSignsDelete = { fg = colors.bright_red, },
      GitSignsAddLn = { fg = colors.black, bg = colors.bright_green, },
      GitSignsChangeLn = { fg = colors.black, bg = colors.cyan, },
      GitSignsDeleteLn = { fg = colors.black, bg = colors.bright_red, },

      -- Telescope
      TelescopePromptBorder = { fg = colors.comment, },
      TelescopeResultsBorder = { fg = colors.comment, },
      TelescopePreviewBorder = { fg = colors.comment, },
      TelescopeSelection = { fg = colors.white, bg = colors.selection, },
      TelescopeMultiSelection = { fg = colors.purple, bg = colors.selection, },
      TelescopeNormal = { fg = colors.fg, bg = colors.bg, },
      TelescopeMatching = { fg = colors.green, },
      TelescopePromptPrefix = { fg = colors.purple, },

      -- NvimTree
      NvimTreeNormal = { fg = colors.fg, bg = colors.menu, },
      NvimTreeVertSplit = { fg = colors.bg, bg = colors.bg, },
      NvimTreeRootFolder = { fg = colors.fg, attr = "bold", },
      NvimTreeGitDirty = { fg = colors.yellow, },
      NvimTreeGitNew = { fg = colors.bright_green, },
      NvimTreeImageFile = { fg = colors.pink, },
      NvimTreeFolderIcon = { fg = colors.purple, },
      NvimTreeIndentMarker = { fg = colors.nontext, },
      NvimTreeEmptyFolderName = { fg = colors.comment, },
      NvimTreeFolderName = { fg = colors.fg, },
      NvimTreeSpecialFile = { fg = colors.pink, attr = "underline", },
      NvimTreeOpenedFolderName = { fg = colors.fg, },
      NvimTreeCursorLine = { bg = colors.selection, },
      NvimTreeIn = { bg = colors.selection, },

      NvimTreeEndOfBuffer = { fg = isShowBufEnd and colors.visual or colors.bg, },

      -- Bufferline
      BufferLineIndicatorSelected = { fg = colors.purple, },
      BufferLineFill = { bg = colors.black, },

      -- LSP
      DiagnosticError = { fg = colors.red, },
      DiagnosticWarn = { fg = colors.yellow, },
      DiagnosticInfo = { fg = colors.cyan, },
      DiagnosticHint = { fg = colors.cyan, },
      DiagnosticUnderlineError = { attr = "undercurl", sp = colors.red, },
      DiagnosticUnderlineWarn = { attr = "undercurl", sp = colors.yellow, },
      DiagnosticUnderlineInfo = { attr = "undercurl", sp = colors.cyan, },
      DiagnosticUnderlineHint = { attr = "undercurl", sp = colors.cyan, },
      DiagnosticSignError = { fg = colors.red, },
      DiagnosticSignWarn = { fg = colors.yellow, },
      DiagnosticSignInfo = { fg = colors.cyan, },
      DiagnosticSignHint = { fg = colors.cyan, },
      DiagnosticFloatingError = { fg = colors.red, },
      DiagnosticFloatingWarn = { fg = colors.yellow, },
      DiagnosticFloatingInfo = { fg = colors.cyan, },
      DiagnosticFloatingHint = { fg = colors.cyan, },
      DiagnosticVirtualTextError = { fg = colors.red, },
      DiagnosticVirtualTextWarn = { fg = colors.yellow, },
      DiagnosticVirtualTextInfo = { fg = colors.cyan, },
      DiagnosticVirtualTextHint = { fg = colors.cyan, },

      LspDiagnosticsDefaultError = { fg = colors.red, },
      LspDiagnosticsDefaultWarning = { fg = colors.yellow, },
      LspDiagnosticsDefaultInformation = { fg = colors.cyan, },
      LspDiagnosticsDefaultHint = { fg = colors.cyan, },
      LspDiagnosticsUnderlineError = { fg = colors.red, attr = "undercurl", },
      LspDiagnosticsUnderlineWarning = { fg = colors.yellow, attr = "undercurl", },
      LspDiagnosticsUnderlineInformation = { fg = colors.cyan, attr = "undercurl", },
      LspDiagnosticsUnderlineHint = { fg = colors.cyan, attr = "undercurl", },
      LspReferenceText = { fg = colors.orange, },
      LspReferenceRead = { fg = colors.orange, },
      LspReferenceWrite = { fg = colors.orange, },

      --LSP Saga
      LspFloatWinNormal = { fg = colors.fg, },
      LspFloatWinBorder = { fg = colors.comment, },
      LspSagaHoverBorder = { fg = colors.comment, },
      LspSagaSignatureHelpBorder = { fg = colors.comment, },
      LspSagaCodeActionBorder = { fg = colors.comment, },
      LspSagaDefPreviewBorder = { fg = colors.comment, },
      LspLinesDiagBorder = { fg = colors.comment, },
      LspSagaRenameBorder = { fg = colors.comment, },
      LspSagaBorderTitle = { fg = colors.menu, },
      LSPSagaDiagnosticTruncateLine = { fg = colors.comment, },
      LspSagaDiagnosticBorder = { fg = colors.comment, },
      LspSagaShTruncateLine = { fg = colors.comment, },
      LspSagaDocTruncateLine = { fg = colors.comment, },
      LspSagaLspFinderBorder = { fg = colors.comment, },

      -- IndentBlankLine
      IndentBlanklineContextChar = { fg = colors.bright_red, attr = "nocombine", },

      -- Nvim compe
      CmpItemAbbrDeprecated = { fg = colors.white, bg = colors.menu, },
      CmpItemAbbrMatch = { fg = colors.cyan, bg = colors.menu, },

      --barbar
      BufferCurrentTarget = { fg = colors.red, },
      BufferVisibleTarget = { fg = colors.red, },
      BufferInactiveTarget = { fg = colors.red, },

      -- Compe
      CompeDocumentation = "Pmenu",
      CompeDocumentationBorder = "Pmenu",

      -- Cmp
      CmpItemKind = "Pmenu",
      CmpItemAbbr = "Pmenu",
      CmpItemKindMethod = "TSMethod",
      CmpItemKindText = "TSText",
      CmpItemKindFunction = "TSFunction",
      CmpItemKindConstructor = "TSType",
      CmpItemKindVariable = "TSVariable",
      CmpItemKindClass = "TSType",
      CmpItemKindInterface = "TSType",
      CmpItemKindModule = "TSNamespace",
      CmpItemKindProperty = "TSProperty",
      CmpItemKindOperator = "TSOperator",
      CmpItemKindReference = "TSParameterReference",
      CmpItemKindUnit = "TSField",
      CmpItemKindValue = "TSField",
      CmpItemKindField = "TSField",
      CmpItemKindEnum = "TSField",
      CmpItemKindKeyword = "TSKeyword",
      CmpItemKindSnippet = "TSText",
      CmpItemKindColor = "cssColor",
      CmpItemKindFile = "TSURI",
      CmpItemKindFolder = "TSURI",
      CmpItemKindEvent = "TSConstant",
      CmpItemKindEnumMember = "TSField",
      CmpItemKindConstant = "TSConstant",
      CmpItemKindStruct = "TSStructure",
      CmpItemKindTypeParameter = "TSParameter",
   }

   -- apply transparents
   if opts.transparent_bg then
      for _, group in ipairs(TRANSPARENTS) do
         highlights[group].bg = nil
      end
   end

   local links = {} ---@type string[]
   -- run defined highlights
   for group, value in pairs(highlights) do
      if type(value) == "table" then
         local sp = value.sp and " guisp=" .. value.sp or ""
         cmd(string.format("highlight %s guifg=%s guibg=%s gui=%s%s",
            group, value.fg or "NONE", value.bg or "NONE",
            value.attr or "NONE", sp))
      elseif type(value) == "string" then
         -- make sure links will run later
         links[#links + 1] = string.format("highlight! link %s %s", group, value)
      end
   end

   -- run highlights link commands
   for _, command in ipairs(links) do
      cmd(command)
   end
end

local local_opts = DEFAULT_OPTIONS

---setup colorscheme
---@param opts DefaultConfig | nil
local function setup(opts)
   cmd("hi clear")

   if vim.fn.exists("syntax_on") then
      cmd("syntax reset")
   end

   o.background = "dark"
   o.termguicolors = true
   g.colors_name = "dracula"

   if type(opts) == "table" then
      local_opts = vim.tbl_deep_extend("force", DEFAULT_OPTIONS, opts)
   end
   apply(local_opts)
end

return {
   setup = setup,
   options = function() return local_opts end,
   colors = function() return local_opts.colors end,
}
