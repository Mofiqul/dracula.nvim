local o = vim.o
local g = vim.g
local cmd = vim.cmd
local nvim_set_hl = vim.api.nvim_set_hl
local tbl_deep_extend = vim.tbl_deep_extend

---@class DefaultConfig
---@field italic_comment boolean
---@field transparent_bg boolean
---@field show_end_of_buffer boolean
---@field lualine_bg_color string?
---@field colors Palette
---@field overrides table<string, Highlight|string>
local DEFAULT_CONFIG = {
   italic_comment = false,
   transparent_bg = false,
   show_end_of_buffer = false,
   lualine_bg_color = nil,
   colors = require("dracula.palette"),
   overrides = {},
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
---@param configs DefaultConfig
local function apply(configs)
   local colors = configs.colors
   apply_term_colors(colors)
   local groups = require("dracula.groups").setup(configs)

   -- apply transparents
   if configs.transparent_bg then
      for _, group in ipairs(TRANSPARENTS) do
         groups[group].bg = nil
      end
   end

   for group, setting in pairs(configs.overrides) do
      groups[group] = setting
   end

   -- run defined highlights
   for group, value in pairs(groups) do
      if type(value) == "table" then
         ---@cast value Highlight
         nvim_set_hl(0, group, value)
      elseif type(value) == "string" then
         nvim_set_hl(0, group, { link = value })
      end
   end
end

local local_configs = DEFAULT_CONFIG

---setup dracula colorscheme
---@param configs DefaultConfig?
local function setup(configs)
   if type(configs) == "table" then
      local_configs = tbl_deep_extend("force", DEFAULT_CONFIG, configs) --[[@as DefaultConfig]]
   end
end

---load dracula colorscheme
local function load()
   if vim.version().minor < 7 then
      vim.notify_once("dracula.nvim: you must use neovim 0.7 or higher")
      return
   end

   -- reset colors
   if g.colors_name then
      cmd("hi clear")
   end

   if vim.fn.exists("syntax_on") then
      cmd("syntax reset")
   end

   o.background = "dark"
   o.termguicolors = true
   g.colors_name = "dracula"

   apply(local_configs)
end

return {
   load = load,
   setup = setup,
   configs = function() return local_configs end,
   colors = function() return local_configs.colors end,
}
