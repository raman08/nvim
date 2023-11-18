local M = {
	"nvim-lualine/lualine.nvim",
}

function M.config()
	local sl_hl = vim.api.nvim_get_hl_by_name("StatusLine", true)

	vim.api.nvim_set_hl(0, "Copilot", { fg = "#6CC644", bg = sl_hl.background })

	local icons = require("user.icons")

	local diff = {
		"diff",
		colored = true,
		symbols = { added = icons.git.LineAdded, modified = icons.git.LineModified, removed = icons.git.LineRemoved }, -- Changes the symbols used by the diff.
	}

	local language_servers = function()
		local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })

		local null_ls_installed, null_ls = pcall(require, "null-ls")

		if #buf_clients == 0 then
			return "LSP Inactive"
		end

		local client_names = {}
		local copilot_active = false

		for _, client in pairs(buf_clients) do
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
			language_server_str = client_names_str
		end

		if copilot_active then
			language_server_str = language_server_str .. " " .. icons.git.Octoface
		end

		return language_server_str:gsub(", anonymous source", "")
	end

	require("lualine").setup({
		options = {
			-- component_separators = { left = "", right = "" },
			-- section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },

			ignore_focus = { "NvimTree" },
		},
		sections = {
			-- lualine_a = { {"branch", icon =""} },
			-- lualine_b = { diff },
			-- lualine_c = { "diagnostics" },
			-- lualine_x = { copilot },
			-- lualine_y = { "filetype" },
			-- lualine_z = { "progress" },
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = { diff },
			lualine_x = { "diagnostics", language_servers},
			lualine_y = { "filetype" },
			lualine_z = { "progress" },
		},
		extensions = { "quickfix", "man", "fugitive" },
	})
end

return M
