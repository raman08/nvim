local M = {
	"saecki/crates.nvim",
	tag = "stable",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = { "BufRead Cargo.toml" },
}

function M.config()
	local crates = require("crates")
	crates.setup({
		thousands_separator = ",",
		null_ls = {
			enabled = true,
			name = "crates.nvim",
		},
		text = {
			loading = "   Loading",
			version = "   %s",
			prerelease = "   %s",
			yanked = "   %s",
			nomatch = "   No match",
			upgrade = "   %s",
			error = "   Error fetching crate",
		},
	})
end

return M
