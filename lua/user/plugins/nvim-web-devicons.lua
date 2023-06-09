local status_ok, nvim_web_devicons = pcall(require, "nvim-web-devicons")
if not status_ok then
	return
end

nvim_web_devicons.set_icon({
	sh = { icon = "", color = "#1DC123", cterm_color = "59", name = "Sh" },
	lock = { icon = "", name = "Lock", color = "#c4c720" },
	out = { icon = "", name = "Out", color = "#abb2bf" },
	ttf = { icon = "", name = "TrueTypeFont", "#abb2bf" },
	astro = { icon = "", color = "#FFFFFF", name = "astro" },
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
