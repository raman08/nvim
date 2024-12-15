local M = {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim",   build = "make", lazy = true },
		{ "nvim-lua/plenary.nvim",                      lazy = true },
		{ "nvim-telescope/telescope-media-files.nvim",  lazy = true },
		{ "nvim-telescope/telescope-file-browser.nvim", lazy = true },
	},
	lazy = true,
	cmd = "Telescope",
}

function M.config()
	local telescope = require("telescope")

	local icons = require("user.icons")
	local actions = require("telescope.actions")

	telescope.setup({
		defaults = {
			prompt_prefix = icons.ui.Telescope .. " ",
			selection_caret = icons.ui.ChevronRight .. " ",
			entry_prefix = "   ",
			initial_mode = "insert",
			selection_strategy = "reset",
			path_display = { "smart" },
			color_devicons = true,
			set_env = { ["COLORTERM"] = "truecolor" },
			sorting_strategy = nil,
			layout_strategy = nil,
			layout_config = {},
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--hidden",
				"--glob=!.git/",
			},
			file_ignore_patterns = {
				".git/",
				"target/",
				"vendor/*",
				"%.lock",
				"__pycache__/*",
				"%.sqlite3",
				"%.ipynb",
				"node_modules/*",
				"node_modules/",
				".vscode",
				"__pycache__/",
			},

			mappings = {
				i = {
					["<C-n>"] = actions.cycle_history_next,
					["<C-p>"] = actions.cycle_history_prev,

					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,

					["<Down>"] = actions.move_selection_next,
					["<Up>"] = actions.move_selection_previous,

					["<CR>"] = actions.select_default,

					["<C-x>"] = actions.select_horizontal,
					["<C-v>"] = actions.select_vertical,
					["<C-t>"] = actions.select_tab,

					["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				},
				n = {
					["<esc>"] = actions.close,
					["q"] = actions.close,

					["j"] = actions.move_selection_next,
					["k"] = actions.move_selection_previous,

					["<CR>"] = actions.select_default,

					["<C-x>"] = actions.select_horizontal,
					["<C-v>"] = actions.select_vertical,
					["<C-t>"] = actions.select_tab,

					["<Down>"] = actions.move_selection_next,
					["<Up>"] = actions.move_selection_previous,
					["gg"] = actions.move_to_top,
					["G"] = actions.move_to_bottom,
				},
			},
		},
		pickers = {
			live_grep = {
				theme = "dropdown",
			},

			grep_string = {
				theme = "dropdown",
			},

			find_files = {
				theme = "dropdown",
				previewer = false,
			},

			buffers = {
				theme = "dropdown",
				previewer = false,
				initial_mode = "normal",
				mappings = {
					i = {
						["<C-d>"] = actions.delete_buffer,
					},
					n = {
						["dd"] = actions.delete_buffer,
					},
				},
			},

			planets = {
				show_pluto = true,
				show_moon = true,
			},

			colorscheme = {
				enable_preview = true,
			},

			lsp_references = {
				theme = "dropdown",
				initial_mode = "normal",
			},

			lsp_definitions = {
				theme = "dropdown",
				initial_mode = "normal",
			},

			lsp_declarations = {
				theme = "dropdown",
				initial_mode = "normal",
			},

			lsp_implementations = {
				theme = "dropdown",
				initial_mode = "normal",
			},
		},
		extensions = {
			fzf = {
				fuzzy = true,       -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			},

			media_files = {
				-- filetypes whitelist
				-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
				filetypes = { "png", "webp", "jpg", "jpeg" },
				find_cmd = "rg", -- find command (defaults to `fd`)
			},

			file_browser = {
				-- theme = "ivy",
				-- require("telescope.themes").get_dropdown {
				--   previewer = false,
				--   -- even more opts
				-- },
				mappings = {
					["i"] = {
						-- your custom insert mode mappings
					},
					["n"] = {
						-- your custom normal mode mappings
					},
				},
			},
		},
	})
	telescope.load_extension("file_browser")
	telescope.load_extension("fzf")
	telescope.load_extension("media_files")
end

return M
