local M = {
	"folke/which-key.nvim",
	event = "VeryLazy",
}

function M.config()
	local which_key = require("which-key")

	local harpoon = require("harpoon")

	which_key.setup({
		presets = "helix",
		plugins = {
			marks = false, -- shows a list of your marks on ' and `
			registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
			spelling = {
				enabled = true,
				suggestions = 20,
			}, -- use which-key for spelling hints
			-- the presets plugin, adds help for a bunch of default keybindings in Neovim
			-- No actual key bindings are created
			presets = {
				operators = false, -- adds help for operators like d, y, ...
				motions = false, -- adds help for motions
				text_objects = false, -- help for text objects triggered after entering an operator
				windows = false, -- default bindings on <c-w>
				nav = true, -- misc bindings to work with windows
				z = true, -- bindings for folds, spelling and others prefixed with z
				g = true, -- bindings for prefixed with g
			},
		},

		keys = {
			scroll_down = "<c-d>", -- binding to scroll down inside the popup
			scroll_up = "<c-u>", -- binding to scroll up inside the popup
		},

		win = {
			border = "rounded",
			no_overlap = false,
			padding = { 1, 5 }, -- extra window padding [top/bottom, right/left]
			title = true,
			title_pos = "center",
			zindex = 1000,
		},
		layout = {
			height = { min = 4, max = 25 }, -- min and max height of the columns
			width = { min = 30, max = 50 }, -- min and max width of the columns
			spacing = 3,           -- spacing between columns
			align = "center",      -- align columns left, center or right
		},

		icons = {
			mappings = false,
		},

		filter = function(mapping)
			-- example to exclude mappings without a description
			return mapping.desc and mapping.desc ~= ""
		end,
		show_help = true, -- show help message on the command line when the popup is visible
		show_keys = true, -- show the currently pressed key and its label as a message in the command line
		triggers = {
			{ "<auto>", mode = "nxsot" },
		},
		-- disable the WhichKey popup for certain buf types and file types.
		-- Disabled by default for Telescope
		disable = {
			bt = {},
			ft = { "TelescopePrompt" },
		},
	})

	which_key.add({
		{ "<leader>", group = "leader" },

		{
			"<leader>q",
			"<cmd>confirm q<CR>",
			desc = "Quit",
			noremap = true,
			nowait = true,
		},

		{
			"<leader>/",
			"<cmd>lua require('Comment.api').toggle.linewise.current()<CR>",
			desc = "Comment",
			noremap = true,
			nowait = true,
		},

		{
			"<leader>h",
			"<cmd>nohlsearch<CR>",
			desc = "No Highlight",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>e",
			"<cmd>NvimTreeToggle<CR>",
			desc = "Explorer",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>w",
			"<cmd>w!<CR>",
			desc = "Save",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>c",
			"<cmd>lua require('bufdelete').bufdelete(0, false)<CR>",
			desc = "Save",
			noremap = true,
			nowait = true,
		},

		{
			"<leader>b",
			"<cmd>Telescope buffers previewer=false<cr>",
			desc = "Find",
			noremap = true,
			nowait = true,
		},
	})

	-- Debug group and its mappings
	which_key.add({
		{ "<leader>d",  group = "Debug" },
		{
			"<leader>dt",
			"<cmd>lua require'dap'.toggle_breakpoint()<cr>",
			desc = "Toggle Breakpoint",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>db",
			"<cmd>lua require'dap'.step_back()<cr>",
			desc = "Step Back",
			noremap = true,
			nowait = true,
		},
		{ "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue" },
		{
			"<leader>dC",
			"<cmd>lua require'dap'.run_to_cursor()<cr>",
			desc = "Run To Cursor",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>dd",
			"<cmd>lua require'dap'.disconnect()<cr>",
			desc = "Disconnect",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>dg",
			"<cmd>lua require'dap'.session()<cr>",
			desc = "Get Session",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>di",
			"<cmd>lua require'dap'.step_into()<cr>",
			desc = "Step Into",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>do",
			"<cmd>lua require'dap'.step_over()<cr>",
			desc = "Step Over",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>du",
			"<cmd>lua require'dap'.step_out()<cr>",
			desc = "Step Out",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>dp",
			"<cmd>lua require'dap'.pause()<cr>",
			desc = "Pause",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>dr",
			"<cmd>lua require'dap'.repl.toggle()<cr>",
			desc = "Toggle Repl",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>ds",
			"<cmd>lua require'dap'.continue()<cr>",
			desc = "Start",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>dq",
			"<cmd>lua require'dap'.close()<cr>",
			desc = "Quit",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>dU",
			"<cmd>lua require'dapui'.toggle({reset = true})<cr>",
			desc = "Toggle UI",
			noremap = true,
			nowait = true,
		},
	})

	which_key.add({
		-- Find group and its mappings
		{ "<leader>f",  group = "Find" },
		{
			"<leader>fb",
			"<cmd>Telescope git_branches<cr>",
			desc = "Checkout branch",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>fc",
			"<cmd>Telescope colorscheme<cr>",
			desc = "Colorscheme",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>ff",
			"<cmd>Telescope find_files<cr>",
			desc = "Find files",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>fp",
			"<cmd>lua require('telescope').extensions.projects.projects()<cr>",
			desc = "Projects",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>ft",
			"<cmd>Telescope live_grep<cr>",
			desc = "Find Text",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>fs",
			"<cmd>Telescope grep_string<cr>",
			desc = "Find String",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>fh",
			"<cmd>Telescope help_tags<cr>",
			desc = "Help",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>fH",
			"<cmd>Telescope highlights<cr>",
			desc = "Highlights",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>fi",
			"<cmd>lua require('telescope').extensions.media_files.media_files()<cr>",
			desc = "Media",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>fl",
			"<cmd>Telescope resume<cr>",
			desc = "Last Search",
			noremap = true,
			nowait = true,
		},
		{ "<leader>fM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages", noremap = true, nowait = true },
		{
			"<leader>fr",
			"<cmd>Telescope oldfiles<cr>",
			desc = "Recent File",
			noremap = true,
			nowait = true,
		},
		{ "<leader>fR", "<cmd>Telescope registers<cr>", desc = "Registers", noremap = true, nowait = true },
		{ "<leader>fk", "<cmd>Telescope keymaps<cr>",   desc = "Keymaps",   noremap = true, nowait = true },
		{ "<leader>fC", "<cmd>Telescope commands<cr>",  desc = "Commands",  noremap = true, nowait = true },
	})

	which_key.add({
		-- Git group and its mappings
		{ "<leader>g",  group = "Git" },
		{
			"<leader>gj",
			"<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>",
			desc = "Next Hunk",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>gk",
			"<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>",
			desc = "Prev Hunk",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>gl",
			"<cmd>lua require 'gitsigns'.blame_line()<cr>",
			desc = "Blame",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>gp",
			"<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
			desc = "Preview Hunk",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>gr",
			"<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
			desc = "Reset Hunk",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>gR",
			"<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
			desc = "Reset Buffer",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>gs",
			"<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
			desc = "Stage Hunk",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>gu",
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			desc = "Undo Stage Hunk",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>go",
			"<cmd>Telescope git_status<cr>",
			desc = "Open changed file",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>gb",
			"<cmd>Telescope git_branches<cr>",
			desc = "Checkout branch",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>gc",
			"<cmd>Telescope git_commits<cr>",
			desc = "Checkout commit",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>gC",
			"<cmd>Telescope git_bcommits<cr>",
			desc = "Checkout commit (for current file)",
			noremap = true,
			nowait = true,
		},
		{ "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Git Diff", noremap = true, nowait = true },
	})

	which_key.add({
		-- LSP group and its mappings
		{ "<leader>l", group = "LSP" },
		{
			"<leader>la",
			"<cmd>lua vim.lsp.buf.code_action()<cr>",
			desc = "Code Action",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>ld",
			"<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>",
			desc = "Buffer Diagnostics",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>lw",
			"<cmd>Telescope diagnostics<cr>",
			desc = "Diagnostics",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>lf",
			"<cmd>lua vim.lsp.buf.format({timeout_ms = 1000000})<cr>",
			desc = "Format",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>li",
			"<cmd>LspInfo<cr>",
			desc = "Info",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>lI",
			"<cmd>Mason<cr>",
			desc = "Mason Info",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>lj",
			"<cmd>lua vim.diagnostic.goto_next()<cr>",
			desc = "Next Diagnostic",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>lk",
			"<cmd>lua vim.diagnostic.goto_prev()<cr>",
			desc = "Prev Diagnostic",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>ll",
			"<cmd>lua vim.lsp.codelens.run()<cr>",
			desc = "CodeLens Action",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>lq",
			"<cmd>lua vim.diagnostic.setloclist()<cr>",
			desc = "Quickfix",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>lr",
			"<cmd>lua require('renamer').rename({empty = true})<cr>",
			desc = "Rename",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>ls",
			"<cmd>Telescope lsp_document_symbols<cr>",
			desc = "Document Symbols",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>lS",
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			desc = "Workspace Symbols",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>le",
			"<cmd>Telescope quickfix<cr>",
			desc = "Telescope Quickfix",
			noremap = true,
			nowait = true,
		},
		{
			"<leader>lt",
			"<cmd>lua vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())<cr>",
			desc = "Toggle Inlay Hints",
			noremap = true,
			nowait = true,
		},
	})

	which_key.add({
		mode = "v", -- Visual mode
		{
			"/",
			"<Plug>(comment_toggle_linewise_visual)",
			desc = "Comment toggle linewise (visual)",
			noremap = true,
			nowait = true,
		},
		{ "la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", noremap = true, nowait = true },
	})

	which_key.add({
		mode = "n", -- Normal mode
		{
			"mj",
			function()
				harpoon:list():prev()
			end,
			desc = "Harpoon Prev",
			noremap = true,
			nowait = true,
		},
		{
			"mk",
			function()
				harpoon:list():next()
			end,
			desc = "Harpoon Next",
			noremap = true,
			nowait = true,
		},
	})
end

return M
