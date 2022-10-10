return {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			format = { enable = false },
			hints = {
				enable = true,
				arrayIndex = "Enable", -- "Enable", "Auto", "Disable"
				await = true,
				paramName = "All", -- "All", "Literal", "Disable"
				paramType = true,
				semicolon = "All", -- "All", "SameLine", "Disable"
				setType = true,
			},
			runtime = { version = "LuaJIT", special = { reload = "require" } },
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
			telemetry = { enable = false },
		},
	},
}
