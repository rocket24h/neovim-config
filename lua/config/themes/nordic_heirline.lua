local _, utils = pcall(require, "heirline.utils")
local get_hl = utils.get_highlight
local M = {}
-- Copied straight from the official nordic repo
-- https://github.com/AlexvZyl/nordic.nvim/blob/main/lua/nordic/colors/nordic.lua

local colors = {
	bg = "#191D24",
	fg = "#BBC3D4",
	bright_bg = "#242933",
	bright_fg = "#C0C8D8",
	red = "#BF616A",
	dark_red = "#B74E58",
	green = "#A3BE8C",
	blue = "#5E81AC",
	gray = "#4C566A",
	orange = "#D08770",
	purple = "#A97EA1",
	cyan = "#8FBCBB",
	yellow = "#EBCB8B",
	diag_warn = get_hl("DiagnosticWarn").fg,
	diag_error = get_hl("DiagnosticError").fg,
	diag_hint = get_hl("DiagnosticHint").fg,
	diag_info = get_hl("DiagnosticInfo").fg,
	git_del = "#A97EA1",
	git_add = "#A3BE8C",
	git_change = "#D08770",
}

M.colors = colors

return M
