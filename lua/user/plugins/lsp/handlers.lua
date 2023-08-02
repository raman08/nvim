local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

local lsp_lines_ok, lsp_lines = pcall(require, "lsp_lines")
if not lsp_lines_ok then
	print("lsp_lines not found")
	return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)
M.capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

M.setup = function()
	local icons = require("user.icons")

	local signs = {
		{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
		{ name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
		{ name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
		{ name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_lines = true,
		virtual_text = true,
		-- show signs
		signs = { active = signs },
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "if_many",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})

	lsp_lines.setup()
end

local function attach_navic(client, bufnr)
	vim.g.navic_silence = true
	local status_ok, navic = pcall(require, "nvim-navic")
	if not status_ok then
		return
	end
	navic.attach(client, bufnr)
end

local function lsp_highlight_document(client)
	if client.server_capabilities.document_highlight then
		local status_ok, illuminate = pcall(require, "illuminate")
		if not status_ok then
			return
		end

		illuminate.on_attach(client)
	end
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gf", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format()' ]])
	vim.cmd([[ command! LspLinesToggle execute 'lua require("lsp_lines").toggle()' ]])
end

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

	attach_navic(client, bufnr)
	lsp_keymaps(bufnr)
	lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.offsetEncoding = { "utf-16" }

function M.enable_format_on_save()
	vim.cmd([[
		augroup format_on_save
			autocmd!
			autocmd BufWritePre * lua vim.lsp.buf.format()
		augroup end
	]])
	vim.notify("Enabled format on save")
end

function M.disable_format_on_save()
	M.remove_augroup("format_on_save")
	vim.notify("Disabled format on save")
end

function M.toggle_format_on_save()
	if vim.fn.exists("#format_on_save#BufWritePre") == 0 then
		M.enable_format_on_save()
	else
		M.disable_format_on_save()
	end
end

function M.remove_augroup(name)
	if vim.fn.exists("#" .. name) == 1 then
		vim.cmd("au! " .. name)
	end
end

vim.cmd([[ command! LspToggleAutoFormat execute 'lua require("user.plugins.lsp.handlers").toggle_format_on_save()' ]])

return M
