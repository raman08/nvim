local M = {
	"nvim-treesitter/nvim-treesitter",
	version = false,
	build = ":TSUpdate",
	--event = { "LazyFile", "VeryLazy" },
	lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
	cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			event = "VeryLazy",
		},
		{
			"windwp/nvim-ts-autotag",
			event = "VeryLazy",
		},
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
		},

		{
			"p00f/nvim-ts-rainbow",
			event = "VeryLazy",
		},
	},
}

function M.config()
	local treesitter = require("nvim-treesitter.configs")

	---@diagnostic disable-next-line: missing-fields
	treesitter.setup({
		auto_install = false,
		ensure_installed = {
			"astro",
			"css",
			"dockerfile",
			"lua",
			"markdown",
			"markdown_inline",
			"bash",
			"python",
			"rust",
			"git_config",
			"gitcommit",
			"git_rebase",
			"gitignore",
			"gitattributes",
			"go",
			"gomod",
			"gowork",
			"gosum",
			"json5",
			"hyprlang",
			"rasi",
		},
		ignore_install = { "" },
		sync_install = false,

		highlight = {
			enable = true,
			disable = { "markdown" },
			additional_vim_regex_highlighting = false,
		},

		indent = { enable = true, disable = { "yaml", "python", "css" } },

		matchup = {
			enable = { "astro" },
			disable = { "lua" },
		},

		autotag = { enable = true, disable = { "xml", "markdown" } },

		autopairs = { enable = true },

		rainbow = {
			enable = true,
			extended_modes = true,
			max_file_line = nil,
			colors = {
				"Gold",
				"Orchid",
				"DodgerBlue",
				"Cornsilk",
				"Salmon",
				"LawnGreen",
			},
			disable = { "html" },
		},

		vim.filetype.add({
			extension = { rasi = "rasi", rofi = "rasi", wofi = "rasi" },
			filename = {
				["vifmrc"] = "vim",
			},
			pattern = {
				[".*/waybar/config"] = "jsonc",
				[".*/mako/config"] = "dosini",
				[".*/kitty/.+%.conf"] = "kitty",
				[".*/hypr/.+%.conf"] = "hyprlang",
				["%.env%.[%w_.-]+"] = "sh",
			},
		}),

		vim.treesitter.language.register("bash", "kitty"),
	})
end

return M
