local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require("telescope.actions")
local icons = require("user.icons")

telescope.load_extension("media_files")

telescope.setup({
	defaults = {
		prompt_prefix = icons.ui.Telescope .. " ",
		selection_caret = " ",
		path_display = { "smart" },
		file_ignore_patterns = {
			".git/",
			"target/",
			"vendor/*",
			"%.lock",
			"__pycache__/*",
			"%.sqlite3",
			"%.ipynb",
			"node_modules/*",
			-- "%.jpg",
			-- "%.jpeg",
			-- "%.png",
			-- "%.svg",
			-- "%.otf",
			-- "%.ttf",
			-- "%.webp",
			-- ".dart_tool/",
			-- ".github/",
			-- ".gradle/",
			".idea/",
			-- ".settings/",
			-- ".vscode/",
			"__pycache__/",
			-- "build/",
			"env/",
			-- "gradle/",
			"node_modules/",
			"%.pdb",
			-- "%.dll",
			"%.class",
			-- "%.exe",
			"%.cache",
			"%.ico",
			-- "%.pdf",
			"%.dylib",
			-- "%.jar",
			-- "%.docx",
			-- "%.met",
			"smalljre_*/*",
			".vale/",
			-- "%.burp",
			-- "%.mp4",
			-- "%.mkv",
			-- "%.rar",
			-- "%.zip",
			-- "%.7z",
			-- "%.tar",
			-- "%.bz2",
			-- "%.epub",
			-- "%.flac",
			-- "%.tar.gz",
		},

		mappings = {
			i = {
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,

				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,

				["<C-c>"] = actions.close,

				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,

				["<CR>"] = actions.select_default,

				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,

				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,

				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,

				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<C-l>"] = actions.complete_tag,
				["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
			},

			n = {
				["<esc>"] = actions.close,
				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,

				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

				["j"] = actions.move_selection_next,
				["k"] = actions.move_selection_previous,
				["H"] = actions.move_to_top,
				["M"] = actions.move_to_middle,
				["L"] = actions.move_to_bottom,
				["q"] = actions.close,

				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,
				["gg"] = actions.move_to_top,
				["G"] = actions.move_to_bottom,

				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,

				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,

				["?"] = actions.which_key,
			},
		},
	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
		live_grep = { theme = "dropdown" },
		grep_string = { theme = "dropdown" },
		find_files = { theme = "dropdown", previewer = false },
		buffers = {
			theme = "dropdown",
			previewer = false,
			initial_mode = "normal",
		},
		planets = { show_pluto = true },
	},
	extensions = {
		-- Your extension configuration goes here:
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

-- telescope.load_extension "ui-select"
telescope.load_extension("file_browser")
telescope.load_extension("fzf")