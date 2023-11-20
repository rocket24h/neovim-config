local opt = vim.opt

opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

opt.termguicolors = true
opt.background = "dark"
opt.number = true
opt.relativenumber = true
opt.backspace = "indent,eol,start"

opt.splitright = true
opt.splitbelow = true

opt.swapfile = false
