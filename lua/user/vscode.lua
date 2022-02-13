local opts = { noremap = true, silent = true }
-- VsCode extentions
 -- map keyboard quickfix;
vim.api.nvim_set_keymap('n', 'z=',"<Cmd>call VSCodeNotify('keyboard-quickfix.open Quick Fix')<Cr>", opts )
vim.api.nvim_set_keymap('n', 'gd',"<Cmd>call VSCodeNotify('editor.action.revealDefinitionAside')<CR>",opts )
