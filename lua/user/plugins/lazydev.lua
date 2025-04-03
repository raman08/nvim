local M = {
	"folke/lazydev.nvim",
	ft = "lua", -- only load on lua files
}

function M.config()
	---@class lazydev.Config
	require("lazydev").setup({
		library = {},
		enabled = function()
			return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
		end,
	})
end

return M
