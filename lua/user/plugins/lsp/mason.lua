local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
	return
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local ensure_installed_servers = {
	"lua_ls",
	"clangd",
}

local servers = {
	"rust_analyser",
}

servers = vim.tbl_extend("keep", ensure_installed_servers, servers)

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

mason.setup(settings)

mason_lspconfig.setup({
	ensure_installed = ensure_installed_servers,
	automatic_installation = true,
})

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("user.plugins.lsp.handlers").on_attach,
		capabilities = require("user.plugins.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "user.plugins.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end
