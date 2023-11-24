local conf = {}

conf.options = {
	offsets = {
		{
			filetype = "NvimTree",
			text = "NvimTree",
			text_align = "center",
			separator = true,
		},
	},
	color_icons = true,
	show_buffer_icons = false,
	show_buffer_close_icons = true,
	show_close_icon = true,
	show_tab_indicators = true,
	show_duplicate_prefix = true,
	persist_buffer_sort = true,
}

require("bufferline").setup(conf)
