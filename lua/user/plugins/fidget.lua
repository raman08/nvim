local M = {
	"j-hui/fidget.nvim",
	event = "VeryLazy",
}

function M.config()
	local status_ok, fidget = pcall(require, "fidget")
	if not status_ok then
		return
	end

	local icons = require("user.icons")

	fidget.setup({
		progress = {
			poll_rate = 0, -- How frequently to poll for progress messages
			suppress_on_insert = false, -- Suppress new messages while in insert mode
			ignore_done_already = false, -- Ignore new tasks that are already complete
			ignore_empty_message = true,

			notification_group = function(msg)
				-- return msg.lsp_name
				return msg.lsp_client.name
			end,

			ignore = {}, -- List of LSP servers to ignore

			display = {
				render_limit = 16, -- How many LSP messages to show at once
				done_ttl = 3, -- How long a message should persist after completion
				done_icon = icons.ui.Check, -- Icon shown when all LSP progress tasks are complete
				done_style = "Constant", -- Highlight group for completed LSP tasks
				progress_ttl = math.huge, -- How long a message should persist when in progress
				progress_icon = { pattern = "dots", period = 1 }, -- Icon shown when LSP progress tasks are in progress
				progress_style = "WarningMsg", -- Highlight group for in-progress LSP tasks
				group_style = "Title", -- Highlight group for group name (LSP server name)
				icon_style = "Question", -- Highlight group for group icons
				priority = 30, -- Ordering priority for LSP notification group
				skip_history = true,
				-- How to format a progress message
				format_message = fidget.progress.display.default_format_message,
				-- How to format a progress annotation
				format_annote = function(msg)
					return msg.title
				end,
				-- How to format a progress notification group's name
				format_group_name = function(group)
					return tostring(group)
				end,
				overrides = { -- Override options from the default notification config
					rust_analyzer = { name = "rust-analyzer" },
				},
			},

			-- Options related to Neovim's built-in LSP client
			lsp = {
				progress_ringbuf_size = 0, -- Configure the nvim's LSP progress ring buffer size
			},
		},

		integration = {
			["nvim-tree"] = {
				enable = true, -- Integrate with nvim-tree/nvim-tree.lua (if installed)
			},
		},
	})
end

return M
