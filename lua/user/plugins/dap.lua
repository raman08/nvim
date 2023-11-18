local M = {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"mxsdev/nvim-dap-vscode-js",
		-- "theHamsta/nvim-dap-virtual-text",
	},
	event = "VeryLazy",
}

function M.config()
	local status_dap_ok, dap = pcall(require, "dap")
	if not status_dap_ok then
		return
	end

	local status_ok, icons = pcall(require, "user.icons")
	if not status_ok then
		return
	end

	vim.fn.sign_define("DapBreakpoint", {
		text = icons.ui.Bug,
		texthl = "DiagnosticSignError",
		linehl = "",
		numhl = "",
	})

	vim.fn.sign_define("DapBreakpointRejected", {
		text = icons.ui.Bug,
		texthl = "DiagnosticSignError",
		linehl = "",
		numhl = "",
	})

	vim.fn.sign_define("DapStopped", {
		text = icons.ui.BoldArrowRight,
		texthl = "DiagnosticSignWarn",
		linehl = "Visual",
		numhl = "DiagnosticSignWarn",
	})

	local status_key_ok, which_key = pcall(require, "which-key")
	if not status_key_ok then
		return
	end

	local opts = {
		mode = "n", -- NORMAL mode
		prefix = "<leader>",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps
	}

	local mappings = {
		d = {

			name = "Debug",
			t = {
				"<cmd>lua require'dap'.toggle_breakpoint()<cr>",
				"Toggle Breakpoint",
			},
			b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
			c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
			C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
			d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
			g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
			i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
			o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
			u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
			p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
			r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
			s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
			q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
			U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
		},
	}

	which_key.register(mappings, opts)

	local status_dapui_ok, dapui = pcall(require, "dapui")
	if not status_dapui_ok then
		return
	end

	dapui.setup({
		expand_lines = true,
		icons = { expanded = "", collapsed = "", circular = "" },
		mappings = {
			-- Use a table to apply multiple mappings
			expand = { "<CR>", "<2-LeftMouse>" },
			open = "o",
			remove = "d",
			edit = "e",
			repl = "r",
			toggle = "t",
		},
		layouts = {
			{
				elements = {
					{ id = "scopes",      size = 0.33 },
					{ id = "breakpoints", size = 0.17 },
					{ id = "stacks",      size = 0.25 },
					{ id = "watches",     size = 0.25 },
				},
				size = 0.33,
				position = "right",
			},
			{
				elements = {
					{ id = "repl",    size = 0.45 },
					{ id = "console", size = 0.55 },
				},
				size = 0.27,
				position = "bottom",
			},
		},
		floating = {
			max_height = 0.9,
			max_width = 0.5,    -- Floats will be treated as percentage of your screen.
			border = vim.g.border_chars, -- Border style. Can be 'single', 'double' or 'rounded'
			mappings = { close = { "q", "<Esc>" } },
		},
	})

	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end

	-- require("user.plugins.dap.cpp")
	-- require("user.plugins.dap.js-ts")
end

return M
