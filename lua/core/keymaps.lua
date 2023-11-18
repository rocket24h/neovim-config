vim.g.mapleader = " "

local keymap = vim.keymap

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")
