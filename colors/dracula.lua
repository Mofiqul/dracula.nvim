local dracula = require("dracula")

vim.cmd("hi clear")

if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end

vim.o.background = "dark"
vim.o.termguicolors = true
vim.g.colors_name = "dracula"

dracula.apply();
