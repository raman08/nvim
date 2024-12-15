local M = {
	"williamboman/mason.nvim",
	cmd = "Mason",
	build = ":MasonUpdate",
}

function M.config()
	require("mason").setup({
		ui = {
			border = "rounded",
		},
		log_level = vim.log.levels.INFO,
		ensure_installed = { "hadolint" },
	})
end

return M
