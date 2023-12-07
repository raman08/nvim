local M = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{
			"folke/neodev.nvim",
		},
	},
}

local function show_documentation()
	local filetype = vim.bo.filetype

	if vim.tbl_contains({ "vim", "help" }, filetype) then
		print("notrun")
		vim.cmd("h " .. vim.fn.expand("<cword>"))
	elseif vim.tbl_contains({ "man" }, filetype) then
		print("notrun")
		vim.cmd("Man " .. vim.fn.expand("<cword>"))
	elseif vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
		print("notrun")
		require("crates").show_popup()
	else
		vim.lsp.buf.hover()
	end
end

local keymaps_list = {
	normal_mode = {
		-- ["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Show hover" },
		["K"] = { show_documentation, "Show hover" },
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

local function lsp_keymaps(bufnr)

	local mappings = {
		normal_mode = "n",
		insert_mode = "i",
		visual_mode = "v",
	}

	for mode_name, mode_char in pairs(mappings) do
		for key, remap in pairs(keymaps_list[mode_name]) do
			local opts = { buffer = bufnr, desc = remap[2], noremap = true, silent = true }
			vim.keymap.set(mode_char, key, remap[1], opts)
		end
	end


	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format()' ]])
end

-- local function lsp_keymaps(bufnr)
-- 	print("Keymap initilized")
-- 	local opts = { noremap = true, silent = true, bufnr = bufnr }

-- 	vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
-- 	vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
-- 	vim.keymap.set("n", "K", show_documentation, opts)
-- 	vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
-- 	vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
-- 	vim.keymap.set("n", "gf", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
-- 	vim.keymap.set("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
-- 	vim.keymap.set("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
-- end

M.on_attach = function(client, bufnr)

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

function M.common_capabilities()
	local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if status_ok then
		return cmp_nvim_lsp.default_capabilities()
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()

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

function M.config()
	local lspconfig = require("lspconfig")
	local icons = require("user.icons")

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

		virtual_lines = true,
		virtual_text = true,
		update_in_insert = false,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(default_diagnostic_config)

	for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
	end

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	vim.lsp.handlers["textDocument/signatureHelp"] =
		vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

	require("lspconfig.ui.windows").default_options.border = "rounded"

	local servers = require("user.plugins.mason").lsp_servers

	local opts = {
		on_attach = M.on_attach,
		capabilities = M.common_capabilities(),
	}

	for _, server in pairs(servers) do
		local require_ok, settings = pcall(require, "user.lspsettings." .. server)
		if require_ok then
			opts = vim.tbl_deep_extend("force", settings, opts)
		end

		if server == "lua_ls" then
			require("neodev").setup({})
		end

		if server == "rust_analyzer" then
			goto continue_rust
		end

		lspconfig[server].setup(opts)
		::continue_rust::
	end
end

return M
