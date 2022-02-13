local status_ok ,configs = pcall( require,"nvim-treesitter.configs")

if not status_ok then
	return
end

configs.setup {
	ensure_installed = "maintained",
	sync_install = false,
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
	enable = true, -- false will disable the whole extension
	disable = { "" }, -- list of language that will be disabled
	additional_vim_regex_highlighting = true,
	},
	indent = { enable = true, disable = { "yaml" } },
	rainbow = {
	-- Setting colors
	enable=true,
	extended_modes = true,
	max_file_line = nil
	},
	autopairs = {
		enable = true,
	},
	autotag = {
		enable = true,
		disable = { "xml" },
	},
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
		  toggle_query_editor = 'o',
		  toggle_hl_groups = 'i',
		  toggle_injected_languages = 't',
		  toggle_anonymous_nodes = 'a',
		  toggle_language_display = 'I',
		  focus_language = 'f',
		  unfocus_language = 'F',
		  update = 'R',
		  goto_node = '<cr>',
		  show_help = '?',
		},
	  },
	context_commentstring = {
	enable = true
	}
}
