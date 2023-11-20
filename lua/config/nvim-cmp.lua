local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")
local bordered = cmp.config.window.bordered()
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	completion = {
		completeopt = "menu, menuone, preview, noselect",
	},

	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "path" }, -- file path
		{ name = "buffer" }, --text within buffer
		{ name = "luasnip" }, --snippets
	}),

	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-e>"] = cmp.mapping.abort(),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),

	ConfirmOption = {
		select = true,
		cmp.ConfirmBehavior.Replace,
	},

	window = {
		completion = bordered,
		documentation = bordered,
	},

	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 50,
			ellipsis_char = "...",
		}),
	},
})
