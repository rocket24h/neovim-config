local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Load necessary plugins
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("config.alpha")
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("config.toggleterm")
		end,
	},
	{
		"willothy/nvim-cokeline",
		lazy = true,
		event = { "InsertEnter" },
		config = function()
			require("config.cokeline")
		end,
	},
	{
		"windwp/nvim-autopairs",
		lazy = true,
		event = "InsertEnter",
		config = function()
			require("config.nvim-autopairs")
		end,
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer",
		},
		config = function()
			require("config.lsp.mason")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			-- { "antosha417/nvim-lsp-file-operations", config = true },
		},
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("config.lsp.nvim-lspconfig")
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("config.nvim-tree")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("config.nvim-treesitter")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			require("config.telescope")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
		},
		config = function()
			require("config.nvim-cmp")
		end,
	},
	{
		"stevearc/conform.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("config.conform")
		end,
	},
	{
		"mfussenegger/nvim-lint",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("config.nvim-lint")
		end,
	},
	{
		"mfussenegger/nvim-jdtls",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"AlexvZyl/nordic.nvim",
		-- lazy = false,
		-- priority = 1000,
		-- config = function()
		-- 	require("config.themes.nordic")
		-- end,
	},
	{
		"mcchrish/zenbones.nvim",
		dependencies = { "rktjmp/lush.nvim" },
		config = function()
			require("config.themes.zenbones")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("config.gitsigns")
		end,
	},
	{
		"rebelot/heirline.nvim",
		lazy = true,
		event = { "UIEnter" },
		dependencies = {
			"lewis6991/gitsigns.nvim",
		},
		config = function()
			require("config.heirline")
		end,
	},
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})
