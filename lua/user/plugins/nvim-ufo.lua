local M = {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async",
		{
			"luukvbaal/statuscol.nvim",
			config = function()
				local builtin = require("statuscol.builtin")
				require("statuscol").setup({
					relculright = true,
					segments = {
						{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
						{ text = { "%s" }, click = "v:lua.ScSa" },
						{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
					},
				})
			end,
		},
	},
	event = "BufReadPost",
}

function M.config()
	local status_ufo_ok, ufo = pcall(require, "ufo")
	if not status_ufo_ok then
		return
	end

	local foldIcon = ""
	local hlgroup = "NonText"

	local function foldTextFormatter(virtText, lnum, endLnum, width, truncate)
		local newVirtText = {}
		local suffix = "  " .. foldIcon .. "  " .. tostring(endLnum - lnum)
		local sufWidth = vim.fn.strdisplaywidth(suffix)
		local targetWidth = width - sufWidth
		local curWidth = 0
		for _, chunk in ipairs(virtText) do
			local chunkText = chunk[1]
			local chunkWidth = vim.fn.strdisplaywidth(chunkText)
			if targetWidth > curWidth + chunkWidth then
				table.insert(newVirtText, chunk)
			else
				chunkText = truncate(chunkText, targetWidth - curWidth)
				local hlGroup = chunk[2]
				table.insert(newVirtText, { chunkText, hlGroup })
				chunkWidth = vim.fn.strdisplaywidth(chunkText)
				if curWidth + chunkWidth < targetWidth then
					suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
				end
				break
			end
			curWidth = curWidth + chunkWidth
		end
		table.insert(newVirtText, { suffix, hlgroup })
		return newVirtText
	end

	ufo.setup({
		provider_selector = function(_, ft, _)
			local lspWithOutFolding = { "markdown", "bash", "sh", "bash", "zsh", "css" }
			if vim.tbl_contains(lspWithOutFolding, ft) then
				return { "treesitter", "indent" }
			else
				return { "lsp", "indent" }
			end
		end,

		close_fold_kinds = { "imports" },
		open_fold_hl_timeout = 500,
		fold_virt_text_handler = foldTextFormatter,
	})

	vim.keymap.set("n", "zR", ufo.openAllFolds)
	vim.keymap.set("n", "zM", ufo.closeAllFolds)
	vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds)
	vim.keymap.set("n", "zm", ufo.closeFoldsWith)
end

return M
