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


	which_key.add({
		{ "<leader>d",  group = "Debug",                           nowait = true,        remap = false },
		{
			"<leader>dC",
			"<cmd>lua require'dap'.run_to_cursor()<cr>",
			desc = "Run To Cursor",
			nowait = true,
			remap = false,
		},
		{ "<leader>dU", "<cmd>lua require'dapui'.toggle()<cr>",    desc = "Toggle UI",   nowait = true, remap = false },
		{ "<leader>db", "<cmd>lua require'dap'.step_back()<cr>",   desc = "Step Back",   nowait = true, remap = false },
		{ "<leader>dc", "<cmd>lua require'dap'.continue()<cr>",    desc = "Continue",    nowait = true, remap = false },
		{ "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>",  desc = "Disconnect",  nowait = true, remap = false },
		{ "<leader>dg", "<cmd>lua require'dap'.session()<cr>",     desc = "Get Session", nowait = true, remap = false },
		{ "<leader>di", "<cmd>lua require'dap'.step_into()<cr>",   desc = "Step Into",   nowait = true, remap = false },
		{ "<leader>do", "<cmd>lua require'dap'.step_over()<cr>",   desc = "Step Over",   nowait = true, remap = false },
		{ "<leader>dp", "<cmd>lua require'dap'.pause()<cr>",       desc = "Pause",       nowait = true, remap = false },
		{ "<leader>dq", "<cmd>lua require'dap'.close()<cr>",       desc = "Quit",        nowait = true, remap = false },
		{ "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Toggle Repl", nowait = true, remap = false },
		{ "<leader>ds", "<cmd>lua require'dap'.continue()<cr>",    desc = "Start",       nowait = true, remap = false },
		{
			"<leader>dt",
			"<cmd>lua require'dap'.toggle_breakpoint()<cr>",
			desc = "Toggle Breakpoint",
			nowait = true,
			remap = false,
		},
		{ "<leader>du", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out", nowait = true, remap = false },
	})

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

	require("user.dap.cpp")
	require("user.dap.js-ts")
end

return M
