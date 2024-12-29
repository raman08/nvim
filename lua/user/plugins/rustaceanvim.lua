local M = {
	"mrcjkb/rustaceanvim",
	version = vim.fn.has("nvim-0.10.0") == 0 and "^4" or false,
	dependencies = {
		"neovim/nvim-lspconfig",
	},
	ft = { "rust" },
}

function M.config()
	local default_on_attach = require("user.plugins.lsp").on_attach
	local capabilities = require("user.plugins.lsp").common_capabilities()

	local opts = {
		tools = {
			reload_workspace_from_cargo_toml = true,

			-- options same as lsp hover / vim.lsp.util.open_floating_preview()
			hover_actions = {
				replace_builtin_hover = false,
				border = {
					{ "╭", "FloatBorder" },
					{ "─", "FloatBorder" },
					{ "╮", "FloatBorder" },
					{ "│", "FloatBorder" },
					{ "╯", "FloatBorder" },
					{ "─", "FloatBorder" },
					{ "╰", "FloatBorder" },
					{ "│", "FloatBorder" },
				},
				max_width = nil,
				max_height = nil,
				auto_focus = false,
			},

			on_initialized = function()
				vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
					pattern = { "*.rs" },
					callback = function()
						local _, _ = pcall(vim.lsp.codelens.refresh)
					end,
				})
			end,

			-- all the opts to send to nvim-lspconfig
			-- these override the defaults set by rust-tools.nvim
			-- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
		},

		server = {
			on_attach = function(client, bufnr)
				default_on_attach(client, bufnr)
				vim.keymap.set(
					"n",
					"K",
					"<cmd>RustLsp hover actions<cr>",
					{ desc = "Rust Hover actions", buffer = bufnr }
				)
				vim.keymap.set("v", "K", "<cmd>RustLsp hover range<cr>", { buffer = bufnr })
			end,
			capabilities = capabilities,
			standalone = true,
			["rust-analyzer"] = {
				cargo = {
					allFeatures = true,
					loadOutDirsFromCheck = true,
					buildScripts = {
						enable = true,
					},
				},
				procMacro = {
					enable = true,
					ignored = {
						["async-trait"] = { "async_trait" },
						["napi-derive"] = { "napi" },
						["async-recursion"] = { "async_recursion" },
					},
				},
				imports = {
					granularity = {
						group = "module",
					},
					prefix = "self",
				},
				lens = {
					enable = true,
				},
				checkOnSave = {
					command = "clippy",
				},
				files = {
					excludeDirs = {
						".direnv",
						".git",
						".github",
						".gitlab",
						"bin",
						"node_modules",
						"target",
						"venv",
						".venv",
					},
				},
			},
		},

		-- debugging stuff
		dap = {
			-- adapter = {
			-- 	type = "executable",
			-- 	command = "lldb-vscode",
			-- 	name = "rt_lldb",
			-- },
		},
	}

	vim.g.rustaceanvim = opts
end

return M
