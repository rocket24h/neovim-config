-- Recoloring for nordic colorscheme, comment if ugly
vim.cmd("hi NvimTreeGitNewIcon guifg=#A3BE8C")
vim.cmd("hi NvimTreeGitDirtyIcon guifg=#CB775D")
vim.cmd("hi NvimTreeGitStagedIcon guifg=#8FBCBB")
vim.cmd("hi NvimTreeRootFolder guifg=#81A1C1")
require("nvim-tree").setup({})
