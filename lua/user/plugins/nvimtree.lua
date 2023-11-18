local M = {
	"nvim-tree/nvim-tree.lua",
	event = "VeryLazy",
}

function M.config()
	local function on_attach(bufnr)
		local api = require("nvim-tree.api")

		local function opts(desc)
			return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
		end

		api.config.mappings.default_on_attach(bufnr)

		vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
		vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
		vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
		vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))

		vim.keymap.del("n", "<C-k>", { buffer = bufnr })
		vim.keymap.set("n", "<S-k>", api.node.open.preview, opts("Open Preview"))
	end

	local icons = require("user.icons")

	require("nvim-tree").setup({
		on_attach = on_attach,
		sort_by = "name",
		sync_root_with_cwd = true,
		respect_buf_cwd = true,
		renderer = {
			add_trailing = false,
			group_empty = false,
			highlight_git = false,
			full_name = false,
			highlight_opened_files = "none",
			root_folder_label = ":t",
			indent_width = 2,
			indent_markers = {
				enable = false,
				inline_arrows = true,
				icons = {
					corner = "└",
					edge = "│",
					item = "│",
					none = " ",
				},
			},
			icons = {
				git_placement = "before",
				padding = " ",
				symlink_arrow = " ➛ ",
				glyphs = {
					default = icons.ui.Text,
					symlink = icons.ui.FileSymlink,
					bookmark = icons.ui.BookMark,
					folder = {
						arrow_closed = icons.ui.ChevronRight,
						arrow_open = icons.ui.ChevronShortDown,
						default = icons.ui.Folder,
						open = icons.ui.FolderOpen,
						empty = icons.ui.EmptyFolder,
						empty_open = icons.ui.EmptyFolderOpen,
						symlink = icons.ui.FolderSymlink,
						symlink_open = icons.ui.FolderOpen,
					},
					git = {
						unstaged = icons.git.FileUnstaged,
						staged = icons.git.FileStaged,
						unmerged = icons.git.FileUnmerged,
						renamed = icons.git.FileRenamed,
						untracked = icons.git.FileUntracked,
						deleted = icons.git.FileDeleted,
						ignored = icons.git.FileIgnored,
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
			symlink_destination = true,
		},
		view = {
			width = 30,
			side = "left",
			signcolumn = "yes",
			number = false,
			relativenumber = false,
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
			debounce_delay = 15,
			update_root = true,
			ignore_list = {},
		},

		diagnostics = {
			enable = true,
			show_on_dirs = false,
			show_on_open_dirs = true,
			debounce_delay = 50,
			severity = {
				min = vim.diagnostic.severity.HINT,
				max = vim.diagnostic.severity.ERROR,
			},
			icons = {
				hint = icons.diagnostics.BoldHint,
				info = icons.diagnostics.BoldInformation,
				warning = icons.diagnostics.BoldWarning,
				error = icons.diagnostics.BoldError,
			},
		},
		--filters = {
		--	dotfiles = false,
		--	custom = { ".git", "node_modules" },
		--	exclude = { ".gitignore", ".env" },
		--},
		trash = { cmd = "trash" },
	})
end

return M