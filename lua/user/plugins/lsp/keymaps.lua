local keymaps_list = {
	normal_mode = {
		-- ["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Show hover" },
		["K"] = {
			function()
				local filetype = vim.bo.filetype

				if vim.tbl_contains({ "vim", "help" }, filetype) then
					vim.cmd("h " .. vim.fn.expand("<cword>"))
				elseif vim.tbl_contains({ "man" }, filetype) then
					vim.cmd("Man " .. vim.fn.expand("<cword>"))
				elseif vim.fn.expand("%:t") == "Cargo.toml" then
					local crates_available, crates = pcall(require, "crates")
					if crates_available and crates.popup_available() then
						crates.show_popup()
					else
						vim.notify("Crates plugin is not available or popup is not supported", vim.log.levels.WARN)
					end
				else
					vim.lsp.buf.hover()
				end
			end,
			"Show hover",
		},
		["gd"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto definition" },
		["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto Declaration" },
		["gr"] = { "<cmd>lua vim.lsp.buf.references()<cr>", "Goto references" },
		["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Goto Implementation" },
		["gs"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "show signature help" },
		["gl"] = {
			function()
				local float = vim.diagnostic.config().float

				if float then
					local config = type(float) == "table" and float or {}
					config.scope = "line"

					vim.diagnostic.open_float(config)
				end
			end,
			"Show line diagnostics",
		},
	},
	insert_mode = {},
	visual_mode = {},
}

return keymaps_list
