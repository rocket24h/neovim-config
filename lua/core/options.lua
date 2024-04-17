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
opt.showcmdloc = "statusline"
opt.linespace = 2

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		-- Overwrite existing highlight groups using Vim API
		-- For some reason, changing this hl group using the "hi" command doesn't work
		-- Comment this if you're not using zenbones, or change it idk
		api.nvim_set_hl(0, "NvimTreeRootFolder", { fg = "#819B69" })
	end,
})
