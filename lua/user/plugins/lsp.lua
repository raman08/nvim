local M = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{
			"folke/neodev.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"nvim-lua/plenary.nvim",
			"jay-babu/mason-nvim-dap.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
	},
}

local function show_documentation()
	local filetype = vim.bo.filetype

	if vim.tbl_contains({ "vim", "help" }, filetype) then
		vim.cmd("h " .. vim.fn.expand("<cword>"))
	elseif vim.tbl_contains({ "man" }, filetype) then
		vim.cmd("Man " .. vim.fn.expand("<cword>"))
	elseif vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
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

local lsp_servers = {
	"lua_ls",
	"tsserver",
	"astro",
	"jsonls",
	"yamlls",
	"tailwindcss",
	"bashls",
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

M.common_capabilities = function()
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

function M.config()
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

		virtual_lines = false,
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

	require("lspconfig.ui.windows").default_options.border = "rounded"

	require("mason-lspconfig").setup({
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

				if server == "rust_analyzer" then
					goto continue_rust
				end

				lspconfig[server].setup(opts)
				::continue_rust::
			end,
		},
	})

	require("mason-nvim-dap").setup({
		ensure_installed = dap_ensure_installed,
		automatic_installation = false,
	})
end

return M
