local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then return end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
-- local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    debug = false,
    sources = {
        formatting.prettier.with({
            extra_args = {
                "--single-quote",
                "--jsx-single-quote",
                "--tab-width",
                "4",
                "--use-tabs",
                "--arrow-parens",
                "avoid",
            },
        }),
        formatting.phpcsfixer,
        formatting.clang_format.with({extra_args = {"--style=file"}}),
        formatting.lua_format.with({
            extra_args = {
                "--chop-down-kv-table",
                "--extra-sep-at-table-end",
                "--single-quote-to-double-quote",
                "--spaces-around-equals-in-field",
                "--chop-down-table",
            },
        }),
        -- formatting.uncrustify
        -- formatting.black.with { extra_args = { "--fast" } },
        -- formatting.stylua,
    },
})
