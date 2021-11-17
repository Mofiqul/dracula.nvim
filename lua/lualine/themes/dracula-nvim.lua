local dracula = {}

local colors = require('dracula').colors()

dracula.normal = {
  b = {fg = colors.purple, bg = colors.black},
  a = {fg = colors.black, bg = colors.purple, gui = 'bold'},
  c = {fg = colors.white, bg = colors.black}
}

dracula.visual = {
  a = {fg = colors.black, bg = colors.pink, gui = 'bold'},
  b = {fg = colors.pink, bg = colors.black},
}

dracula.inactive = {
  b = {fg = colors.black, bg = colors.white},
  a = {fg = colors.white, bg = colors.gray, gui = 'bold'}
}

dracula.replace = {
  b = {fg = colors.yellow, bg = colors.black},
  a = {fg = colors.black, bg = colors.yellow, gui = 'bold'},
  c = {fg = colors.white, bg = colors.black}
}

dracula.insert = {
  a = {fg = colors.black, bg = colors.green, gui = 'bold'},
  b = {fg = colors.green, bg = colors.black},
  c = {fg = colors.white, bg = colors.black}
}

return dracula
