local status_cmp_ok, rust = pcall(require, "rust-tools")
if not status_cmp_ok then
	return
end

rust.setup({
	server = { -- pass options to lspconfig's setup method
		on_attach = require("user.plugins.lsp.handlers").on_attach,
		capabilities = require("user.plugins.lsp.handlers").capabilities,
	},

	executor = require("rust-tools.executors").toggleterm,
})
