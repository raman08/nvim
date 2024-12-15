local M = {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = "VeryLazy",
}

function M.config()
	local icons = require("user.icons")

	require("ibl").setup({

		enabled = true,
		debounce = 200,

		viewport_buffer = {
			min = 30,
			max = 100,
		},

		indent = {
			char = icons.ui.LineMiddle,
			highlight = { "Function", "Label" },
			smart_indent_cap = true,
			priority = 1,
		},

		whitespace = {
			highlight = { "Function", "Label" },
			remove_blankline_trail = true,
		},

		scope = {
			enabled = true,
			show_start = true,
			show_end = true,
			injected_languages = false,
			highlight = { "Function", "Label" },
			priority = 500,
		},

		exclude = {
			filetypes = {
				"help",
				"startify",
				"dashboard",
				"lazy",
				"neogitstatus",
				"NvimTree",
				"Trouble",
				"text",
			},
			buftypes = {
				"terminal",
				"nofile",
			},
		},
	})

	-- indent = { char = icons.ui.LineMiddle },
	-- whitespace = {
	--   remove_blankline_trail = true,
	-- },
	--
	-- exclude = {
	--   filetypes = {
	--     "help",
	--     "startify",
	--     "dashboard",
	--     "lazy",
	--     "neogitstatus",
	--     "NvimTree",
	--     "Trouble",
	--     "text",
	--   },
	--   buftypes = { "terminal", "nofile" },
	-- },
	-- scope = { enabled = false },
end

return M
