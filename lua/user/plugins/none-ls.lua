local M = {
	"nvimtools/none-ls.nvim",
}

function M.config()
	local none_ls = require("null-ls")

	local formatting = none_ls.builtins.formatting
	-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
	-- local diagnostics = null_ls.builtins.diagnostics
	-- local code_actions = null_ls.builtins.code_actions

	none_ls.setup({

		root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
		sources = {
			formatting.stylua,
			-- formatting.prettier,
			formatting.prettier.with({
				extra_filetypes = { "toml", "astro" },
				extra_args = {
					-- "--single-quote",
					-- "--jsx-single-quote",
					"--tab-width",
					"4",
					"--use-tabs",
					"--arrow-parens",
					"avoid",
				},
			}),
			formatting.clang_format,
			formatting.black,
			-- formatting.beautysh,
			-- null_ls.builtins.diagnostics.eslint,
			-- null_ls.builtins.completion.spell,
		},
	})
end

return M
