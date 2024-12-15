local M = {
	"folke/flash.nvim",
	event = "VeryLazy",
	vscode = true,
}

function M.config()
	local keymap = vim.keymap.set
	local opts = { noremap = true, silent = true }

	keymap({ "n", "x", "o" }, "s", function()
		require("flash").jump()
	end, vim.tbl_extend("force", opts, { desc = "Flash" }))
	keymap({ "n", "o", "x" }, "S", function()
		require("flash").treesitter()
	end, vim.tbl_extend("force", opts, { desc = "Flash Treesitter" }))
	keymap("o", "r", function()
		require("flash").remote()
	end, vim.tbl_extend("force", opts, { desc = "Remote Flash" }))
	keymap({ "o", "x" }, "R", function()
		require("flash").treesitter_search()
	end, vim.tbl_extend("force", opts, { desc = "Treesitter Search" }))
	keymap("c", "<c-s>", function()
		require("flash").toggle()
	end, vim.tbl_extend("force", opts, { desc = "Toggle Flash Search" }))
end

return M
