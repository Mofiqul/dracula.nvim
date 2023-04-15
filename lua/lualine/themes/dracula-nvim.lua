local dracula = require("dracula")
local configs = dracula.configs()
local colors = dracula.colors()

local bg_dark = configs.lualine_bg_color or colors.black
local bg = dracula.colors().menu or colors.black

local normal = {
   a = { fg = colors.black, bg = colors.purple, gui = 'bold' },
   b = { fg = colors.purple, bg = bg_dark },
   c = { fg = colors.white, bg = bg },
}

local command = {
   a = { fg = colors.black, bg = colors.cyan, gui = 'bold' },
   b = { fg = colors.cyan, bg = bg_dark },
}

local visual = {
   a = { fg = colors.black, bg = colors.pink, gui = 'bold' },
   b = { fg = colors.pink, bg = bg_dark },
}

local inactive = {
   a = { fg = colors.white, bg = colors.visual, gui = 'bold' },
   b = { fg = colors.black, bg = colors.white },
}

local replace = {
   a = { fg = colors.black, bg = colors.yellow, gui = 'bold' },
   b = { fg = colors.yellow, bg = bg_dark },
   c = { fg = colors.white, bg = bg },
}

local insert = {
   a = { fg = colors.black, bg = colors.green, gui = 'bold' },
   b = { fg = colors.green, bg = bg_dark },
   c = { fg = colors.white, bg = bg },
}

return {
   normal = normal,
   command = command,
   visual = visual,
   inactive = inactive,
   replace = replace,
   insert = insert,
}
