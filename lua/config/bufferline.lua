local conf = {}

conf.options = {
	offsets = {
		{
			filetype = "NvimTree",
			text = "File Explorer",
			text_align = "center",
			separator = false,
		},
	},
	color_icons = true,
	show_buffer_icons = true,
	show_buffer_close_icons = true,
	show_close_icon = true,
	show_tab_indicators = true,
	show_duplicate_prefix = true,
	persist_buffer_sort = true,
	diagnostics = "nvim_lsp",
	diagnostics_indicator = function(count, level, diagnostics_dict, context)
		local icon = level:match("error") and " " or " "
		return " " .. icon .. count
	end,
}

require("bufferline").setup(conf)
