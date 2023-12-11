local M = {
	"mrcjkb/rustaceanvim",
	-- "simrat39/rust-tools.nvim",
	version = "^3", -- Recommended
	dependencies = {
		"neovim/nvim-lspconfig",
	},
	ft = { "rust" },
}

function M.config()
	local default_on_attach = require("user.plugins.lspconfig").on_attach
	local capabilities = require("user.plugins.lspconfig").common_capabilities()

	local opts = {
		tools = {

			-- options right now: termopen / quickfix / toggleterm / vimux
			-- executor = require("rustaceanvim.executors").toggleterm,
			-- executor = require("rust-tools").toggleterm,

			-- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
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

				auto_focus = true,
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
				local rt = require("rust-tools")
				vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
			end,
			capabilities = capabilities,
			standalone = true,
			["rust-analyzer"] = {
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

	-- local rt = require("rust-tools")
	-- rt.setup(opts)
end

return M
