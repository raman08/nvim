local status_hop_ok, hop = pcall(require, "hop")
if not status_hop_ok then
	return
end

hop.setup({
	keys = "etovxqpdygfblzhckisuran",
	case_insensitive = false,
	uppercase_labels = false,
	multi_windows = false,
})

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("", "s", ":HopWordCurrentLine<cr>", { silent = true })
-- keymap("", "S", ":HopChar2<cr>", { silent = true })
keymap("", "S", ":HopPattern<cr>", { silent = true })

keymap(
	"n",
	"f",
	":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<CR>",
	opts
)
keymap(
	"n",
	"F",
	":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<CR>",
	opts
)
