local M = {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
}

function M.config()
	local colorscheme = "tokyonight-moon"

	local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

	if not status_ok then
		vim.notify("colorscheme " .. colorscheme .. " not found!")
	end
end

return M
