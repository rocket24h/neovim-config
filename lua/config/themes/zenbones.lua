-- Colorscheme options
vim.cmd("hi NvimTreeRootFolder guifg=#B279A7")
vim.cmd("hi NvimTreeGitNewIcon guifg=#8BAE68")
vim.cmd("hi NvimTreeGitDirtyIcon guifg=#B77E64")
vim.cmd("hi NvimTreeGitStagedIcon guifg=#66A5AD")
vim.cmd("hi NvimTreeIndentMarker cterm=italic gui=italic guifg=#868C91")
vim.g.zenbones = {
	solid_float_border = true,
	-- transparent_background = true,
	--	darkness = "warm",
}
vim.cmd("set termguicolors")
vim.cmd("set background=dark")
vim.cmd("colorscheme zenbones")
