local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local icons = require("user.icons")

local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	api.config.mappings.default_on_attach(bufnr)

	vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
	vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
end

nvim_tree.setup({
	sort_by = "name",
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		show_on_open_dirs = true,
		icons = {
			hint = icons.diagnostics.Hint,
			info = icons.diagnostics.Information,
			warning = icons.diagnostics.Warning,
			error = icons.diagnostics.Error,
		},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
		show_on_dirs = true,
		show_on_open_dirs = true,
	},
	update_focused_file = {
		enable = true,
		update_root = true,
	},
	modified = {
		enable = true,
		show_on_dirs = true,
		show_on_open_dirs = true,
	},
	filesystem_watchers = {
		enable = true,
		debounce_delay = 100,
	},
	on_attach = on_attach,
	view = {
		width = 30,
		side = "left",
		signcolumn = "yes",
		number = false,
		relativenumber = false,
	},
	renderer = {
		add_trailing = false,
		group_empty = false,
		full_name = false,
		highlight_git = false,
		highlight_opened_files = "none",
		root_folder_modifier = ":t",
		indent_width = 4,
		indent_markers = {
			enable = false,
			icons = { corner = "└ ", edge = "│ ", none = "  " },
		},
		icons = {
			webdev_colors = true,
			git_placement = "before",
			modified_placement = "before",
			padding = " ",
			symlink_arrow = " ➛ ",
			show = { file = true, folder = true, folder_arrow = true, git = true },
			glyphs = {
				default = "",
				symlink = "",
				folder = {
					arrow_open = icons.ui.ArrowOpen,
					arrow_closed = icons.ui.ArrowClosed,
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = "",
					staged = "S",
					unmerged = "",
					renamed = "➜",
					untracked = "U",
					deleted = "",
					ignored = "◌",
				},
			},
		},
		special_files = {
			"Cargo.toml",
			"Makefile",
			"README.md",
			"readme.md",
			"package.json",
			".env",
		},
	},
	filters = {
		dotfiles = false,
		custom = { ".git", "node_modules" },
		exclude = { ".gitignore", ".env" },
	},
	trash = { cmd = "trash" },
	actions = {
		use_system_clipboard = true,
		change_dir = {
			enable = true,
			global = false,
			restrict_above_cwd = false,
		},
		expand_all = {
			max_folder_discovery = 300,
			exclude = {},
		},
		file_popup = {
			open_win_config = {
				col = 1,
				row = 1,
				relative = "cursor",
				border = "shadow",
				style = "minimal",
			},
		},
		open_file = {
			quit_on_open = false,
			resize_window = true,
			window_picker = {
				enable = true,
				picker = "default",
				chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
				exclude = {
					filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
					buftype = { "nofile", "terminal", "help" },
				},
			},
		},
		remove_file = {
			close_window = true,
		},
	},
	ui = {
		confirm = {
			remove = true,
			trash = true,
		},
	},
})
