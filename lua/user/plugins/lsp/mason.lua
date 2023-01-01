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

local ensure_servers = {
	"sumneko_lua",
	"bashls",
	"cssmodules_ls",
	"eslint",
	"html",
	"pyright",
	"yamlls",
	"jsonls",
	"clangd",
	"cssls",
	"tsserver",
}

local servers = {}

for _, v in ipairs(ensure_servers) do
	table.insert(servers, v)
end

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
	ensure_installed = ensure_servers,
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
