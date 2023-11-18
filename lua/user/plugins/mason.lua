local M = {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"nvim-lua/plenary.nvim",
	},
}

M.servers = {
	"lua_ls",
	"cssls",
	"html",
	"tsserver",
	"astro",
	"pyright",
	"bashls",
	"jsonls",
	"yamlls",
	"marksman",
	"tailwindcss",
}

function M.config()
	require("mason").setup({
		ui = {
			border = "rounded",
		},
		log_level = vim.log.levels.INFO,
	})

	require("mason-lspconfig").setup({
		ensure_installed = M.servers,
		automatic_installation = true,
	})
end

return M
