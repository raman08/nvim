local M = {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"nvim-lua/plenary.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		-- "jay-babu/mason-null-ls.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
}

M.lsp_servers = {
	"lua_ls",
	"tsserver",
	"astro",
	"jsonls",
	"yamlls",
	"tailwindcss",
	"bashls"
}

local tools_ensure_installed = {
	"stylua",
	"prettier",
	"clang-format",
	"rust-analyzer",
}

local dap_ensure_installed = {
	"python",
	"cppdbg",
	"node2",
	"codelldb",
	"chrome",
}

function M.config()
	require("mason").setup({
		ui = {
			border = "rounded",
		},
		log_level = vim.log.levels.INFO,
	})

	require("mason-tool-installer").setup({
		ensure_installed = tools_ensure_installed,
		auto_update = false,
		run_on_start = true,
		start_delay = 3000, -- 3 second delay
		debounce_hours = 5, -- at least 5 hours between attempts to install/update
	})

	require("mason-lspconfig").setup({
		ensure_installed = M.lsp_servers,
		automatic_installation = true,
	})

	require("mason-nvim-dap").setup({
		ensure_installed = dap_ensure_installed,
		automatic_installation = false,
	})

	-- require("mason-null-ls").setup({
	-- 	ensure_installed = { "stylua", "jq" }
	-- })
end

return M
