local dracula = {}

local colors = require('dracula').colors()

local bg = ""
if vim.g.dracula_lualine_bg_color ~= nil then
    bg = vim.g.dracula_lualine_bg_color
else
    bg = colors.black
end

dracula.normal = {
  a = {fg = colors.black, bg = colors.purple, gui = 'bold'},
  b = {fg = colors.purple, bg = bg},
  c = {fg = colors.white, bg = bg},
}

dracula.visual = {
  a = {fg = colors.black, bg = colors.pink, gui = 'bold'},
  b = {fg = colors.pink, bg = bg},
}

dracula.inactive = {
  a = {fg = colors.white, bg = colors.gray, gui = 'bold'},
  b = {fg = colors.black, bg = colors.white},
}

dracula.replace = {
  a = {fg = colors.black, bg = colors.yellow, gui = 'bold'},
  b = {fg = colors.yellow, bg = bg},
  c = {fg = colors.white, bg = bg},
}

dracula.insert = {
  a = {fg = colors.black, bg = colors.green, gui = 'bold'},
  b = {fg = colors.green, bg = bg},
  c = {fg = colors.white, bg = bg},
}

return dracula
