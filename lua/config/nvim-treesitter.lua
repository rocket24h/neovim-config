local treesitter = require("nvim-treesitter.configs")

treesitter.setup({
	highlight = {
		enable = true,
	},
	indent = { enable = true },
	ensure_installed = {
		"vim",
		"lua",

		"html",
		"css",
		"javascript",
		"typescript",
		"json",

		"c",
		"cpp",
		"python",
		"dockerfile",
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-space>",
			node_incremental = "<C-space>",
			scope_incremental = false,
			node_decremental = "<bs>",
		},
	},
})
