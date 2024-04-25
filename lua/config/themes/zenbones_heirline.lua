local _, utils = pcall(require, "heirline.utils")
local get_hl = utils.get_highlight
local M = {}
-- Also from the official zenbones repo
-- https://github.com/AlexvZyl/nordic.nvim/blob/main/lua/nordic/colors/nordic.lua

local colors = {
	bg = "#1C1917",
	fg = "#B4BDC3",
	bright_bg = "#403833",
	bright_fg = "#C0C8D8",
	red = "#DE6E7C",
	dark_red = "#B74E58",
	green = "#819B69", --#8BAE68
	blue = "#6099C0", --#61ABDA #6099C0
	gray = "#888F94", --#888F94 #4C566A
	orange = "#B77E64", --#D68C67
	purple = "#B279A7", --#CF86C1
	cyan = "#66A5AD", --#65B8C1
	yellow = "#DEC89B",
	diag_warn = get_hl("DiagnosticWarn").fg,
	diag_error = get_hl("DiagnosticError").fg,
	diag_hint = get_hl("DiagnosticHint").fg,
	diag_info = get_hl("DiagnosticInfo").fg,
	git_del = get_hl("GitSignsDelete").fg,
	git_add = get_hl("GitSignsAdd").fg,
	git_change = get_hl("GitSignsChange").fg,
}

M.colors = colors

return M
