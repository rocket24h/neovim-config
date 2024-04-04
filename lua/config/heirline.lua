local _, heirline = pcall(require, "heirline")
local _, conditions = pcall(require, "heirline.conditions")
local _, utils = pcall(require, "heirline.utils")
local _, theme = pcall(require, "config.themes." .. (vim.g.colors_name or "") .. "_heirline")
local _, devicons = pcall(require, "nvim-web-devicons")

if not theme then
	return
end
local colors = theme.colors

-- ========================
-- GETTING THE PARTS READY
-- ========================

local VimModes = {
	init = function(self)
		self.mode = vim.fn.mode(1)
	end,

	static = {
		-- Defining mode names
		mode_names = {
			n = "NORMAL",
			no = "op?",
			nov = "op?",
			noV = "op?",
			["no\22"] = "op?",
			niI = "NORMAL",
			niR = "NORMAL",
			niV = "NORMAL",
			nt = "NORMAL",
			v = "VISUAL",
			vs = "VISUAL",
			V = "VISUAL LINE",
			Vs = "VISUAL LINE",
			["\22"] = "VISUAL BLOCK",
			["\22s"] = "^VISUAL BLOCK",
			s = "SELECT",
			S = "SELECT",
			["\19"] = "SELECT BLOCK",
			i = "INSERT",
			ic = "INSERT",
			ix = "INSERT",
			R = "REPLACE",
			Rc = "REPLACE",
			Rx = "REPLACE",
			Rv = "V_REPLACE",
			Rvc = "V_REPLACE",
			Rvx = "V_REPLACE",
			c = "COMMAND",
			cv = "COMMAND",
			r = "ENTER",
			rm = "MORE",
			["r?"] = "CONFIRM",
			["!"] = "SHELL",
			t = "TERMINAL",
			["null"] = "NONE",
		},
	},

	-- Assign provider and highlights
	provider = function(self)
		return " %2(" .. self.mode_names[vim.fn.mode(1)] .. "%)"
	end,

	hl = function(self)
		local color = self:get_mode_color()
		return { bg = color, fg = colors.bg, bold = true }
	end,
	-- I don't get this part
	update = {
		"ModeChanged",
		pattern = "*:*",
		callback = vim.schedule_wrap(function()
			vim.cmd("redrawstatus")
		end),
	},
}

local FileNameBlock = {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
	end,
}

local FileIcon = {
	init = function(self)
		local filename = self.filename
		local extension = vim.fn.fnamemodify(filename, ":e")
		self.icon, self.icon_color = devicons.get_icon_color(filename, extension, { default = true })
	end,
	provider = function(self)
		return self.icon and (self.icon .. " ")
	end,
	hl = function(self)
		return { fg = self.icon_color }
	end,
}

local FileName = {
	provider = function(self)
		local filename = vim.fn.fnamemodify(self.filename, ":.")
		if filename == "" then
			return "[No Name]"
		end

		if not conditions.width_percent_below(#filename, 0.25) then
			filename = vim.fn.pathshorten(filename)
		end
		return filename
	end,
	hl = {
		fg = colors.fg,
	},
}

local FileFlags = {
	{
		condition = function()
			return not vim.bo.modifiable or vim.bo.readonly
		end,
		provider = " ",
		hl = { fg = colors.orange },
	},
}

local FileNameModifier = {
	hl = function()
		if vim.bo.modified then
			return { fg = colors.green, bold = true, force = true }
		end
	end,
}

local FileType = {
	provider = function()
		return string.upper(vim.bo.filetype)
	end,
	hl = { fg = utils.get_highlight("Type").fg, bold = true },
}

local Ruler = {
	provider = "%7(%l/%3L%):%2c %P",
	hl = {
		fg = colors.fg,
	},
}

local ScrollBar = {
	static = {
		sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
	},
	provider = function(self)
		local curr_line = vim.api.nvim_win_get_cursor(0)[1]
		local lines = vim.api.nvim_buf_line_count(0)
		local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
		return string.rep(self.sbar[i], 2)
	end,
	hl = { fg = colors.green, bg = colors.bg },
}

local LSPInfo = {
	condition = conditions.lsp_attached,
	update = { "LspAttach", "LspDetach" },
	provider = function()
		local names = {}
		for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
			table.insert(names, server.name)
		end
		return " [" .. table.concat(names, " ") .. "]"
	end,
	hl = {
		fg = colors.green,
		bold = true,
	},
}

local Diagnostics = {
	condition = conditions.has_diagnostics,

	static = {
		error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
		warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
		info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
		hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
	},
	init = function(self)
		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
	end,
	update = { "DiagnosticChanged", "BufEnter" },
	{
		provider = function(self)
			-- 0 is just another output, we can decide to print it or not!
			return self.errors > 0 and (self.error_icon .. self.errors .. " ")
		end,
		hl = { fg = colors.diag_error },
	},
	{
		provider = function(self)
			return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
		end,
		hl = { fg = colors.diag_warn },
	},
	{
		provider = function(self)
			return self.info > 0 and (self.info_icon .. self.info .. " ")
		end,
		hl = { fg = colors.diag_info },
	},
	{
		provider = function(self)
			return self.hints > 0 and (self.hint_icon .. self.hints)
		end,
		hl = { fg = colors.diag_hint },
	},
}

local Git = {
	condition = conditions.is_git_repo,

	init = function(self)
		self.status_dict = vim.b.gitsigns_status_dict
		self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
	end,

	hl = { fg = colors.blue },

	{ -- git branch name
		provider = function(self)
			return " " .. self.status_dict.head
		end,
		hl = { bold = true },
	},
	{
		condition = function(self)
			return self.has_changes
		end,
		provider = "| ",
	},
	{
		provider = function(self)
			local count = self.status_dict.added or 0
			return count > 0 and ("+" .. count)
		end,
		hl = { fg = colors.git_add },
	},
	{
		provider = function(self)
			local count = self.status_dict.removed or 0
			return count > 0 and ("-" .. count)
		end,
		hl = { fg = colors.git_del },
	},
	{
		provider = function(self)
			local count = self.status_dict.changed or 0
			return count > 0 and ("~" .. count)
		end,
		hl = { fg = colors.git_change },
	},
	{
		condition = function(self)
			return self.has_changes
		end,
		provider = " |",
	},
}

local TerminalName = {
	provider = function()
		local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*", "")
		return " " .. tname
	end,
	hl = { fg = colors.blue, bold = true },
}

local SearchCount = {
	condition = function()
		return vim.v.hlsearch ~= 0 and vim.o.cmdheight == 0
	end,
	init = function(self)
		local ok, search = pcall(vim.fn.searchcount)
		if ok and search.total then
			self.search = search
		end
	end,
	provider = function(self)
		local search = self.search
		return string.format("[%d/%d]", search.current, math.min(search.total, search.maxcount))
	end,
}

local ShowCmd = {
	condition = function()
		return vim.o.cmdheight == 0
	end,
	provider = ":%3.5(%S%)",
}

-- ====================
-- ASSEMBLY LINES HERE
-- ====================
local Align = { provider = "%=" }
local Space = { provider = " " }
VimModes = utils.surround({ "", "" }, function(self)
	return self:get_mode_color()
end, { VimModes })
FileNameBlock =
	utils.insert(FileNameBlock, FileIcon, utils.insert(FileNameModifier, FileName), FileFlags, { provider = "%<" })
Diagnostics = utils.surround({ "![", "]" }, nil, Diagnostics)
local DefaultStatusLine = {
	VimModes,
	Space,
	SearchCount,
	Space,
	Git,
	Space,
	Diagnostics,
	Align,
	FileNameBlock,
	Align,
	LSPInfo,
	Space,
	Ruler,
	Space,
	ScrollBar,
}

local InactiveStatusLine = {
	condition = conditions.is_not_active,
	Align,
	FileNameBlock,
	Align,
}

local StatusLines = {
	static = {
		mode_colors = {
			n = colors.yellow,
			i = colors.green,
			v = colors.cyan,
			V = colors.cyan,
			["\22"] = colors.cyan,
			c = colors.orange,
			s = colors.purple,
			S = colors.purple,
			["\19"] = colors.purple,
			R = colors.red,
			r = colors.red,
			["!"] = colors.blue,
			["t"] = colors.blue,
		},
		get_mode_color = function(self)
			local mode = conditions.is_active() and vim.fn.mode() or "n"
			return self.mode_colors[mode]
		end,
	},
	hl = function()
		if conditions.is_active() then
			return "StatusLine"
		else
			return "StatusLinesNC"
		end
	end,
	fallthrough = false,
	InactiveStatusLine,
	DefaultStatusLine,
}

heirline.setup({ statusline = StatusLines })
