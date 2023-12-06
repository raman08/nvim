local M = {
	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
}

function M.config()
	local lsp_lines = require("lsp_lines")
	lsp_lines.setup()

	vim.cmd([[ command! LspLinesToggle execute 'lua require("lsp_lines").toggle()' ]])
end

return M
