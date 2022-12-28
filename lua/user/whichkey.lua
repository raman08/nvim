local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local setup = {
	plugins = {
		marks = false, -- shows a list of your marks on ' and `
		registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = false, -- adds help for motions
			text_objects = false, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "center", -- align columns left, center or right
	},
	ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local m_opts = {
	mode = "n", -- NORMAL mode
	prefix = "m",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local vopts = {
	mode = "v", -- VISUAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local m_mappings = {
	a = { "<cmd>silent BookmarkAnnotate<cr>", "Annotate Bookmark" },
	c = { "<cmd>silent BookmarkClear<cr>", "Clear Bookmark" },
	b = { "<cmd>silent BookmarkToggle<cr>", "Toggle Bookmark" },
	j = { "<cmd>silent BookmarkNext<cr>", "Next Bookmark" },
	k = { "<cmd>silent BookmarkPrev<cr>", "Prev Bookmark" },
	l = { "<cmd>silent BookmarkShowAll<cr>", "List Bookmarks" },
	x = { "<cmd>BookmarkClearAll<cr>", "Clear All Bookmark" },
	-- m = {"<cmd>lua require(\"harpoon.mark\").add_file()<cr>", "Harpoon Bookmark"},
	-- ["."] = {"<cmd>lua require(\"harpoon.ui\").nav_next()<cr>", "Harpoon Next Bookmark"},
	-- [","] = {"<cmd>lua require(\"harpoon.ui\").nav_prev()<cr>", "Harpoon Prev Bookmark"},
	-- l = {"<cmd>lua require('user.bfs').open()<cr>", "Buffers Bookmark"},
	-- s = {"<cmd>Telescope harpoon marks<cr>", "Search Files Bookmark"},
	-- s = {
	--   "<cmd>lua require('telescope').extensions.vim_bookmarks.all({ hide_filename=false, prompt_title=\"bookmarks\", shorten_path=false })<cr>",
	--   "Show",
	-- },
	-- [";"] = {
	--     "<cmd>lua require(\"harpoon.ui\").toggle_quick_menu()<cr>",
	--     "Harpoon UI",
	-- },
}

local mappings = {
	-- ["a"] = {"<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action"},

	-- ["b"] = {
	--     "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
	--     "Buffers",
	-- },

	["b"] = { "<cmd>Telescope buffers<cr>", "Buffers" },

	["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
	["w"] = { "<cmd>w!<CR>", "Save" },

	["q"] = { "<cmd>q!<CR>", "Quit" },
	-- ["q"] = {"<cmd>lua require('user.functions').smart_quit()<CR>", "Quit"},

	["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
	["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
	["/"] = {
		"<cmd>lua require('Comment.api').toggle.linewise.current()<CR>",
		"Comment",
	},
	["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
	["P"] = {
		"<cmd>lua require('telescope').extensions.projects.projects()<cr>",
		"Projects",
	},

	B = {
		name = "Browse",
		i = { "<cmd>BrowseInputSearch<cr>", "Input Search" },
		b = { "<cmd>Browse<cr>", "Browse" },
		d = { "<cmd>BrowseDevdocsSearch<cr>", "Devdocs" },
		f = { "<cmd>BrowseDevdocsFiletypeSearch<cr>", "Devdocs Filetype" },
		m = { "<cmd>BrowseMdnSearch<cr>", "Mdn" },
	},

	-- TODO: Find what it do?
	-- ["gy"] = "Link",

	-- p = {
	--     name = "Packer",
	--     c = {"<cmd>PackerCompile<cr>", "Compile"},
	--     i = {"<cmd>PackerInstall<cr>", "Install"},
	--     s = {"<cmd>PackerSync<cr>", "Sync"},
	--     S = {"<cmd>PackerStatus<cr>", "Status"},
	--     u = {"<cmd>PackerUpdate<cr>", "Update"},
	-- },

	-- ERROR: These don't work
	-- o = {
	--     name = "Options",
	--     w = {
	--         "<cmd>lua require(\"user.functions\").toggle_option(\"wrap\")<cr>",
	--         "Wrap",
	--     },
	--     r = {
	--         "<cmd>lua require(\"user.functions\").toggle_option(\"relativenumber\")<cr>",
	--         "Relative",
	--     },
	--     l = {
	--         "<cmd>lua require(\"user.functions\").toggle_option(\"cursorline\")<cr>",
	--         "Cursorline",
	--     },
	--     s = {
	--         "<cmd>lua require(\"user.functions\").toggle_option(\"spell\")<cr>",
	--         "Spell",
	--     },
	--     t = {
	--         "<cmd>lua require(\"user.functions\").toggle_tabline()<cr>",
	--         "Tabline",
	--     },
	-- },

	s = {
		name = "Session",
		s = { "<cmd>SaveSession<cr>", "Save" },
		r = { "<cmd>RestoreSession<cr>", "Restore" },
		x = { "<cmd>DeleteSession<cr>", "Delete" },
		f = { "<cmd>Autosession search<cr>", "Find" },
		d = { "<cmd>Autosession delete<cr>", "Find Delete" },
	},

	-- p = {
	--     name = "Comptitive Programming",
	--     t = {"<cmd>CompetiTestReceive<cr>", "Receive TestCase"},
	--     c = {"<cmd>CompetiTestRun<cr>", "Run Program"},
	-- },

	f = {
		name = "Find",
		c = { "<cmd>Telescope commands<cr>", "Commands" },
		f = {
			"<cmd>lua require('telescope.builtin').git_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
			"Find files",
		},
		F = {
			"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
			"Find files",
		},
		t = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
		h = { "<cmd>Telescope help_tags<cr>", "Help" },
		i = {
			"<cmd>lua require('telescope').extensions.media_files.media_files()<cr>",
			"Media",
		},
		l = { "<cmd>Telescope resume<cr>", "Last Search" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
	},

	g = {
		name = "Git",
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		C = {
			"<cmd>Telescope git_bcommits<cr>",
			"Checkout commit(for current file)",
		},
		d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Git Diff" },
	},

	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		c = {
			"<cmd>lua require('user.lsp').server_capabilities()<cr>",
			"Get Capabilities",
		},
		d = { "<cmd>TroubleToggle<cr>", "Diagnostics" },
		f = { "<cmd>lua vim.lsp.buf.format({ async=true })<cr><cr>", "Format" },
		F = { "<cmd>LspToggleAutoFormat<cr>", "Toggle Autoformat" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>Mason<cr>", "Mason Info" },
		j = {
			"<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
			"Next Diagnostic",
		},
		k = {
			"<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
			"Prev Diagnostic",
		},
		l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		o = { "<cmd>SymbolsOutline<cr>", "Outline" },
		q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
		R = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
		t = {
			'<cmd>lua require("user.functions").toggle_diagnostics()<cr>',
			"Toggle Diagnostics",
		},
		u = { "<cmd>LuaSnipUnlinkCurrent<cr>", "Unlink Snippet" },
	},

	S = {
		name = "SnipRun",
		c = { "<cmd>SnipClose<cr>", "Close" },
		f = { "<cmd>%SnipRun<cr>", "Run File" },
		i = { "<cmd>SnipInfo<cr>", "Info" },
		m = { "<cmd>SnipReplMemoryClean<cr>", "Mem Clean" },
		r = { "<cmd>SnipReset<cr>", "Reset" },
		t = { "<cmd>SnipRunToggle<cr>", "Toggle" },
		x = { "<cmd>SnipTerminate<cr>", "Terminate" },
	},
}

local vmappings = {
	["/"] = {
		"<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
		"Comment",
	},
	s = { "<esc><cmd>'<,'>SnipRun<cr>", "Run range" },
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
which_key.register(m_mappings, m_opts)
