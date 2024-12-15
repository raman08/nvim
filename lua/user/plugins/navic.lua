local M = {
	"SmiteshP/nvim-navic",
	lazy = true,
}

function M.config()
	local icons = require("user.icons")
	require("nvim-navic").setup({
		icons = icons.kind,
		highlight = true,
		lsp = {
			auto_attach = true,
		},
		click = true,
		separator = " " .. icons.ui.ChevronRight .. " ",
		depth_limit = 0,
		depth_limit_indicator = "..",
		lazy_update_context = true,
	})
end

return M
