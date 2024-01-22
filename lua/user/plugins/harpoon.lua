local M = {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
}

local function mark_file()
	local harpoon = require("harpoon")
	harpoon:list():append()
	vim.notify("󱡅  marked file")
end

function M.config()
	local keymap = vim.keymap.set
	local opts = { noremap = true, silent = true }

	local harpoon = require("harpoon")

	harpoon:setup()

	keymap("n", "<s-m>", mark_file, opts)
	keymap("n", "<TAB>", function()
		harpoon.ui:toggle_quick_menu(harpoon:list())
	end, opts)
end

return M
