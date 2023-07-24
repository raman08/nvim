local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local icons = require("user.icons")

local function contains(t, value)
	for _, v in pairs(t) do
		if v == value then
			return true
		end
	end
	return false
end

local hide_in_width_60 = function()
	return vim.o.columns > 60
end
local hide_in_width = function()
	return vim.o.columns > 80
end
local hide_in_width_100 = function()
	return vim.o.columns > 100
end

M = {}

local mode = {
	function()
		-- return "▊"
		return "  "
		-- return "  "
	end,
	padding = 0,
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = {
		error = " " .. icons.diagnostics.Error .. " ",
		warn = " " .. icons.diagnostics.Warning .. " ",
	},
	colored = false,
	update_in_insert = false,
	always_visible = true,
	padding = 1,
}

local language_servers = {
	function()
		local clients = vim.lsp.buf_get_clients()
		local null_ls_installed, null_ls = pcall(require, "null-ls")
		local client_names = {}
		local copilot_active = false

		for _, client in pairs(clients) do
			if client.name == "null-ls" then
				if null_ls_installed then
					for _, source in ipairs(null_ls.get_source({ filetype = vim.bo.filetype })) do
						table.insert(client_names, source.name)
					end
				end
			else
				table.insert(client_names, client.name)
			end
			if client.name == "copilot" then
				copilot_active = true
			end
		end

		local client_names_str = table.concat(client_names, ", ")
		local Client_names_len = #client_names

		local language_server_str = ""

		if Client_names_len ~= 0 then
			language_server_str = "" .. client_names_str .. ""
		end

		if copilot_active then
			language_server_str = language_server_str .. " " .. icons.git.Octoface
		end

		return language_server_str:gsub(", anonymous source", "")
	end,

	padding = 1,
	cond = hide_in_width,
}

lualine.setup({
	options = {
		component_separators = "|",
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			"dashboard",
			"NvimTree",
			"Outline",
			"alpha",
			"mason",
			"help",
			"TelescopePrompt",
			"toggleterm",
			"DressingInput"
		},
		globalstatus = true,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { mode },
		lualine_b = { { "b:gitsigns_head", icon = "" }, diagnostics },
		lualine_c = {},
		lualine_x = { language_servers },
		lualine_y = { "filetype" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
