local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("user.lsp.lsp-installer")
require("user.lsp.handlers").setup()

lspconfig.phpactor.setup{}

lspconfig.tailwindcss.setup {
	filetypes = {"blade", "django-html", "html"}
}

require "user.lsp.lsp-signature"
