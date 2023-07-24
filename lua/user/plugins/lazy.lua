local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")

local plugins = {
	{
		"nvim-lua/plenary.nvim",
		module = true,
	}, -- Lua Functions

	-- UI Decorations
	{
		"stevearc/dressing.nvim",
		config = function()
			require("user.plugins.dressing")
		end,
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			require("user.plugins.notify")
		end,
	},
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("user.plugins.neoscroll")
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = "BufRead",
		config = function()
			require("user.plugins.colorized")
		end,
		dependencies = {},
	}, -- Color the Color

	{ "kevinhwang91/nvim-bqf", ft = "qf" }, -- Advance quick fix list

	{
		"ghillb/cybu.nvim",
		config = function()
			require("user.plugins.cybu")
		end,
	}, -- Buffer List in float
	{
		"nvim-lualine/lualine.nvim",
		event = "BufRead",
		config = function()
			require("user.plugins.lualine")
		end,
	},

	{
		"nvim-tree/nvim-tree.lua",
		module = true,
		dependencies = {
			{
				"nvim-tree/nvim-web-devicons",

				config = function()
					require("user.plugins.nvim-web-devicons")
				end,
			},
		},
		config = function()
			require("user.plugins.nvim-tree")
		end,
	},

	{
		"folke/tokyonight.nvim",
		init = function()
			require("user.plugins.tokyonight")
		end,
		config = function()
			require("user.core.colorscheme")
		end,
		lazy = false,
		priority = 1000,
	},

	-- CMP
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			-- snippets
			"L3MON4D3/LuaSnip", -- Snippet Engine
			"rafamadriz/friendly-snippets", -- Bunch of Snippets

			-- buffer
			"hrsh7th/cmp-buffer", -- Buffer Completion

			-- lsp
			"hrsh7th/cmp-nvim-lsp", -- LSP Completion

			"hrsh7th/cmp-path", -- Path Completion
			"saadparwaiz1/cmp_luasnip", -- Snippets Completion
			"hrsh7th/cmp-nvim-lua", -- LUA Completion
			"hrsh7th/cmp-cmdline", -- Comandline Completion
			"hrsh7th/cmp-emoji", -- Emoji Completion
			{
				"windwp/nvim-autopairs",
				config = function()
					require("user.plugins.autopairs") -- Auto Pairs
				end,
			},
		},
		config = function()
			require("user.plugins.cmp")
		end,
	},

	-- TreeSitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufRead",
		cmd = {
			"TSInstall",
			"TSInstallInfo",
			"TSUpdate",
			"TSBufEnable",
			"TSBufDisable",
			"TSEnable",
			"TSDisable",
			"TSModuleInfo",
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"windwp/nvim-ts-autotag",
			"p00f/nvim-ts-rainbow",
			"nvim-treesitter/nvim-treesitter-context",
		},
		build = ":TSUpdate",
		config = function()
			require("user.plugins.treesitter")
		end,
	},

	-- LSP --
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"williamboman/mason.nvim",
				cmd = {
					"Mason",
					"MasonInstall",
					"MasonUninstall",
					"MasonUninstallAll",
					"MasonLog",
				},
			},
			"williamboman/mason-lspconfig.nvim",
			"jose-elias-alvarez/null-ls.nvim",
			"b0o/SchemaStore.nvim",
		},

		config = function()
			require("user.plugins.lsp")
		end,
	},
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		event = "LspAttach",
		config = function()
			require("user.plugins.fidget")
		end,
	},
	{
		"filipdutescu/renamer.nvim",
		config = function()
			require("user.plugins.renamer")
		end,
	},
	{
		"numToStr/Comment.nvim", -- Comment Helper
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring", -- Setting Comment Based On curser location
		},
		config = function()
			require("user.plugins.comment")
		end,
		event = "BufRead",
	},
	{
		"RRethy/vim-illuminate",
		config = function()
			require("user.plugins.illuminate")
		end,
	},
	{
		"SmiteshP/nvim-navic",
		config = function()
			require("user.plugins.navic")
		end,
	}, -- For breadcrums

	-- Debugging
	{

		"mfussenegger/nvim-dap",
		dependencies = {

			"rcarriga/nvim-dap-ui",
			"mxsdev/nvim-dap-vscode-js",
			-- "theHamsta/nvim-dap-virtual-text",
			-- "Pocco81/DAPInstall.nvim"
		},
		config = function()
			require("user.plugins.dap")
		end,
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-media-files.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			require("user.plugins.telescope")
		end,
	},

	-- Which Key
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		config = function()
			require("user.plugins.whichkey")
		end,
	},

	-- GIT
	{
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		config = function()
			require("user.plugins.gitsigns")
		end,
	},
	"tpope/vim-fugitive",

	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("user.plugins.toggleterm")
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("user.plugins.indentline")
		end,
	},
	{
		"goolord/alpha-nvim",
		config = function()
			require("user.plugins.alpha")
		end,
	},
	{
		"folke/todo-comments.nvim",
		config = function()
			require("user.plugins.todo-comments")
		end,
	},
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("user.plugins.project")
		end,
	},

	-- MISC
	"wakatime/vim-wakatime",
	"moll/vim-bbye",
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = "markdown",
	}, -- Markdown Previewer
}

local opts = {
	git = {
		-- defaults for the `Lazy log` command
		-- log = { "-10" }, -- show the last 10 commits
		log = { "--since=3 days ago" }, -- show commits from the last 3 days
		timeout = 300, -- kill processes that take more than 2 minutes
		url_format = "https://github.com/%s.git",
	},
	lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json", -- lockfile generated after running update.
	concurrency = nil, ---@type number limit the maximum amount of concurrent tasks
	dev = {
		-- directory where you store your local plugin projects
		path = "~/projects",
		---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
		patterns = {}, -- For example {"folke"}
	},
	install = {
		-- install missing plugins on startup. This doesn't increase startup time.
		missing = true,
		-- try to load one of these colorschemes when starting an installation during startup
		colorscheme = { "tokyonight", "dull", "habamax" },
	},
	ui = {

		-- a number <1 is a percentage., >1 is a fixed size
		size = { width = 0.8, height = 0.8 },
		-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
		border = "rounded",
		icons = {
			cmd = " ",
			config = "",
			event = "",
			ft = " ",
			init = " ",
			keys = " ",
			plugin = " ",
			runtime = " ",
			source = " ",
			start = "",
			task = "✔ ",
		},
		throttle = 20, -- how frequently should the ui process render events
		custom_keys = {},
		diff = {
			-- diff command <d> can be one of:
			-- * browser: opens the github compare view. Note that this is always mapped to <K> as well,
			--   so you can have a different command for diff <d>
			-- * git: will run git diff and open a buffer with filetype git
			-- * terminal_git: will open a pseudo terminal with git diff
			-- * diffview.nvim: will open Diffview to show the diff
			cmd = "git",
		},
	},

	checker = {
		-- automatically check for plugin updates
		enabled = false,
		concurrency = nil, ---@type number? set to 1 to check for updates very slowly
		notify = true, -- get a notification when new updates are found
		frequency = 3600, -- check for updates every hour
	},
	change_detection = {
		-- automatically check for config file changes and reload the ui
		enabled = true,
		notify = true, -- get a notification when changes are found
	},
	-- lazy can generate helptags from the headings in markdown readme files,
	-- so :help works even for plugins that don't have vim docs.
	-- when the readme opens with :help it will be correctly displayed as markdown
	performance = {
		cache = {
			enabled = true,
			path = vim.fn.stdpath("state") .. "/lazy/cache",
			-- Once one of the following events triggers, caching will be disabled.
			-- To cache all modules, set this to `{}`, but that is not recommended.
			-- The default is to disable on:
			--  * VimEnter: not useful to cache anything else beyond startup
			--  * BufReadPre: this will be triggered early when opening a file from the command line directly
			disable_events = { "VimEnter", "BufReadPre" },
		},
		reset_packpath = true, -- reset the package path to improve startup time
		rtp = {
			reset = false, -- reset the runtime path to $VIMRUNTIME and your config directory
			---@type string[] list any plugins you want to disable here
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	readme = {
		root = vim.fn.stdpath("state") .. "/lazy/readme",
		files = { "README.md" },
		-- only generate markdown helptags for plugins that dont have docs
		skip_if_doc_exists = true,
	},
}
if not status_ok then
	print("something wrong with lazy")
	return
end

lazy.setup(plugins, opts)
