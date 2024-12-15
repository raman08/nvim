local M = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{
			"folke/neodev.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"nvim-lua/plenary.nvim",
			-- "jay-babu/mason-nvim-dap.nvim",
			-- "WhoIsSethDaniel/mason-tool-installer.nvim",
		},
	},
	opts = { document_highlight = { enabled = false } },
}

local function lsp_keymaps(bufnr)
	local mappings = {
		normal_mode = "n",
		insert_mode = "i",
		visual_mode = "v",
	}

	local keymaps_list = require("user.plugins.lsp.keymaps")

	for mode_name, mode_char in pairs(mappings) do
		for key, remap in pairs(keymaps_list[mode_name]) do
			local opts = { buffer = bufnr, desc = remap[2], noremap = true, silent = true }
			vim.keymap.set(mode_char, key, remap[1], opts)
		end
	end

	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format()' ]])
end

local lsp_servers = {
	"lua_ls",
	-- "tsserver",
	"astro",
	"jsonls",
	"yamlls",
	"tailwindcss",
	"bashls",
}

M.common_capabilities = function()
	local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	local has_blink, blink = pcall(require, "blink.cmp")

	local capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		has_cmp and cmp_nvim_lsp.default_capabilities() or {},
		has_blink and blink.get_lsp_capabilities() or {}
	)

	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	}

	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}

	return capabilities
end

M.on_attach = function(client, bufnr)
	-- if client support the inlayHint then enable them....
	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end

	if client.server_capabilities.documentSymbolProvider then
		local have_navic, navic = pcall(require, "nvim-navic")
		if have_navic then
			navic.attach(client, bufnr)
		end
	end

	if client.name == "lua_ls" then
		client.server_capabilities.document_formatting = false
	end

	if client.name == "eslint" then
		client.server_capabilities.document_formatting = false
	end

	if client.name == "html" then
		client.server_capabilities.document_formatting = false
	end

	if client.name == "clangd" then
		client.server_capabilities.document_formatting = false
	end

	if client.name == "tsserver" then
		client.serve_capabilities.document_formatting = false
		vim.lsp.buf.inlayhints(bufnr, true)
	end

	lsp_keymaps(bufnr)
end

function M.config()
	local icons = require("user.icons")

	---@type vim.diagnostic.Opts
	local default_diagnostic_config = {
		signs = {
			active = true,
			values = {
				{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
				{ name = "DiagnosticSignWarn",  text = icons.diagnostics.Warning },
				{ name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
				{ name = "DiagnosticSignInfo",  text = icons.diagnostics.Information },
			},
		},

		virtual_lines = false,
		virtual_text = true,
		update_in_insert = false,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			-- source = "always",
			header = "",
			prefix = "",
		},
		inlay_hints = {
			enabled = true,
			exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
		},
		codelens = {
			enabled = false,
		},
		document_highlight = {
			enabled = true,
		},
	}

	vim.diagnostic.config(default_diagnostic_config)

	for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config() or {}, "signs", "values") or {}) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
	end

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	vim.lsp.handlers["textDocument/signatureHelp"] =
		vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

	require("lspconfig.ui.windows").default_options.border = "rounded"

	local have_mason, mlsp = pcall(require, "mason-lspconfig")

	if have_mason then
		mlsp.setup({
			ensure_installed = lsp_servers,
			automatic_installation = true,

			handlers = {
				function(server)
					local lspconfig = require("lspconfig")
					local opts = {
						on_attach = M.on_attach,
						capabilities = M.common_capabilities(),
					}

					local require_ok, settings = pcall(require, "user.lspsettings." .. server)
					if require_ok then
						opts = vim.tbl_deep_extend("force", settings, opts)
					end

					if server == "lua_ls" then
						require("neodev").setup({})
					end

					if server ~= "rust_analyzer" then
						lspconfig[server].setup(opts)
					end
				end,
			},
		})
	end
	-- require("mason-nvim-dap").setup({
	-- 	ensure_installed = dap_ensure_installed,
	-- 	automatic_installation = false,
	-- })
end

return M
