-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = {
        "Jaq",
        "qf",
        "help",
        "man",
        "lspinfo",
        "spectre_panel",
        "lir",
        "DressingSelect",
        "tsplayground",
    },
    callback = function()
        vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]]
    end,
})

-- Remove statusline and tabline when in Alpha
vim.api.nvim_create_autocmd({"User"}, {
    pattern = {"AlphaReady"},
    callback = function()
        vim.cmd [[
      set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]]
    end,
})

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = {"gitcommit", "markdown"},
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

vim.api.nvim_create_autocmd({"BufEnter"}, {
    pattern = {""},
    callback = function()
        local buf_ft = vim.bo.filetype
        if buf_ft == "" or buf_ft == nil then
            vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR> 
      nnoremap <silent> <buffer> <c-j> j<CR> 
      nnoremap <silent> <buffer> <c-k> k<CR> 
      set nobuflisted 
    ]]
        end
    end,
})

vim.api.nvim_create_autocmd({"BufEnter"}, {
    pattern = {"term://*"},
    callback = function()
        vim.cmd "startinsert!"
        -- TODO: if java = 2
        vim.cmd "set cmdheight=1"
    end,
})

vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"

-- vim.api.nvim_create_autocmd({"VimResized"}, {
--     callback = function() vim.cmd "tabdo wincmd =" end,
-- })

vim.api.nvim_create_autocmd({"CmdWinEnter"},
                            {callback = function() vim.cmd "quit" end})

-- Fixes Autocomment
vim.api.nvim_create_autocmd({"BufWinEnter"}, {
    callback = function() vim.cmd "set formatoptions-=cro" end,
})

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({"TextYankPost"}, {
    callback = function()
        vim.highlight.on_yank {higroup = "Visual", timeout = 200}
    end,
})

vim.api.nvim_create_autocmd({"VimEnter"}, {
    callback = function() vim.cmd "hi link illuminatedWord LspReferenceText" end,
})

vim.api.nvim_create_autocmd({"BufWinEnter"}, {
    pattern = {"*"},
    callback = function() vim.cmd "checktime" end,
})

vim.api.nvim_create_autocmd({"CursorHold"}, {
    callback = function()
        local luasnip = require "luasnip"
        if luasnip.expand_or_jumpable() then
            -- ask maintainer for option to make this silent
            -- luasnip.unlink_current()
            vim.cmd [[silent! lua require("luasnip").unlink_current()]]
        end
    end,
})
