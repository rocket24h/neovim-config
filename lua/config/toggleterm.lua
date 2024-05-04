require("toggleterm").setup({
	size = 15,
	shell = "pwsh",
	direction = "float",
	open_mapping = [[<c-\>]],
	shade_filetypes = {},
	shading_factor = 2,
	persist_size = true,
	hide_numbers = true,
	close_on_exit = true,
	shade_terminals = true,
	start_in_insert = true,
	insert_mappings = true,
	float_opts = {
		winblend = 0,
		border = "single",
	},
})
