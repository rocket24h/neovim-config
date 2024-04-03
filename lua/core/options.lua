local opt = vim.opt
local api = vim.api

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
opt.autochdir = true

opt.fillchars = { eob = " " }
opt.cursorline = false
opt.laststatus = 3
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		-- Overwrite existing highlight groups using Vim API
		api.nvim_set_hl(0, "FloatTitle", { bg = "#191D24", fg = "#A3BE8C" })
	end,
})
