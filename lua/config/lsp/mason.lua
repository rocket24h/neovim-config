local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local mason_tool_installer = require("mason-tool-installer")

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

mason_lspconfig.setup({
	ensure_installed = {
		"tailwindcss",
		"cssls",
		"html",
		"dockerls",
		"tsserver",
		"lua_ls",
		"pyright",
		"clangd",
		"vimls",
		"jdtls",
	},

	automatic_installation = true,
})

mason_tool_installer.setup({
	ensure_installed = {
		"prettier", -- prettier formatter
		"stylua", -- lua formatter
		"isort", -- python formatter
		"black", -- python formatter
		"eslint_d", -- js linter
		"mypy",
		"ruff",
	},
})
