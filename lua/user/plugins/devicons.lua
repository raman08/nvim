local M = {
	"nvim-tree/nvim-web-devicons",
	event = "VeryLazy",
}

function M.config()
	local devicons = require("nvim-web-devicons")

	devicons.set_icon({
		astro = {
			icon = "󱓞",
			color = "#FF7E33",
			name = "astro",
		},
		sh = { icon = "", color = "#1DC123", cterm_color = "59", name = "Sh" },
		lock = { icon = "", name = "Lock", color = "#c4c720" },
		out = { icon = "", name = "Out", color = "#abb2bf" },
		ttf = { icon = "", name = "TrueTypeFont", "#abb2bf" },
		[".gitattributes"] = {
			icon = "",
			color = "#e24329",
			cterm_color = "59",
			name = "GitAttributes",
		},
		[".gitconfig"] = {
			icon = "",
			color = "#e24329",
			cterm_color = "59",
			name = "GitConfig",
		},
		[".gitignore"] = {
			icon = "",
			color = "#e24329",
			cterm_color = "59",
			name = "GitIgnore",
		},
		[".gitlab-ci.yml"] = {
			icon = "",
			color = "#e24329",
			cterm_color = "166",
			name = "GitlabCI",
		},
		[".gitmodules"] = {
			icon = "",
			color = "#e24329",
			cterm_color = "59",
			name = "GitModules",
		},
		["diff"] = {
			icon = "",
			color = "#e24329",
			cterm_color = "59",
			name = "Diff",
		},
		["robots.txt"] = { icon = "ﮧ", name = "Robots", "#abb2bf" },
	})
end

return M
