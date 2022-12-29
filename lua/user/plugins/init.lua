return {
	"nvim-lua/plenary.nvim",
	"wakatime/vim-wakatime",
	"moll/vim-bbye",

	{
		"windwp/nvim-autopairs",
		config = function()
			require("user.autopairs")
		end,
	},
	{
		"numToStr/Comment.nvim", -- Comment Helper
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring", -- Setting Comment Based On curser location
		},
		config = function()
			require("user.comment")
		end,
	},
	{
		"folke/todo-comments.nvim",
		config = function()
			require("user.todo-comments")
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("user.toggleterm")
		end,
	},
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("user.project")
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("user.indentline")
		end,
	},
	{
		"goolord/alpha-nvim",
		config = function()
			require("user.alpha")
		end,
	},
	{
		"nacro90/numb.nvim",
		config = function()
			require("user.numb")
		end,
	},
	{
		"folke/which-key.nvim",
		config = function()
			require("user.whichkey")
		end,
	},
	{
		"MattesGroeger/vim-bookmarks",
		config = function()
			require("user.bookmark")
		end,
	},
	{
		"phaazon/hop.nvim",
		config = function()
			require("user.hop")
		end,
	},

	{ "folke/tokyonight.nvim", lazy = false, priority = 1000 },
	{
		"tamago324/lir.nvim",
		config = function()
			require("user.lir")
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		-- lazy=false,
		dependencies = {
			{
				"nvim-tree/nvim-web-devicons",

				config = function()
					require("user.nvim-web-devicons")
				end,
			},
		},
		config = function()
			require("user.nvim-tree")
		end,
	},

	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
	},

	-- CMP
	{
		"hrsh7th/nvim-cmp",
		config = function()
			require("user.cmp")
		end,
		dependencies = {
			"hrsh7th/cmp-buffer", -- Buffer Completion
			"hrsh7th/cmp-path", -- Path Completion
			"saadparwaiz1/cmp_luasnip", -- Snippets Completion
			"hrsh7th/cmp-nvim-lsp", -- LSP Completion
			"hrsh7th/cmp-nvim-lua", -- LUA Completion
			"hrsh7th/cmp-cmdline", -- Comandline Completion
			"hrsh7th/cmp-emoji", -- Emoji Completion
		},
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},

		config = function()
			require("user.lsp")
		end,
	},

	"jose-elias-alvarez/null-ls.nvim", -- For Formatting and Linting
	--{ "phpactor/phpactor", run = "composer install --no-dev -o", ft = "php" }, -- Php Support for Nvim
	{
		"filipdutescu/renamer.nvim",
		config = function()
			require("user.renamer")
		end,
	},
	"ray-x/lsp_signature.nvim",
	"b0o/SchemaStore.nvim",
	{
		"RRethy/vim-illuminate",
		config = function()
			require("user.illuminate")
		end,
	},
	"folke/trouble.nvim",
	{
		"j-hui/fidget.nvim",
		config = function()
			require("user.fidget")
		end,
	},
	{
		"SmiteshP/nvim-navic",
		config = function()
			require("user.navic")
		end,
	}, -- For breadcrums
	"jose-elias-alvarez/typescript.nvim",

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
			require("user.dap")
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
			require("user.telescope")
		end,
	},

	-- TreeSitter
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("user.treesitter")
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"p00f/nvim-ts-rainbow",
			"windwp/nvim-ts-autotag",
			"nvim-treesitter/nvim-treesitter-context",
			"nvim-treesitter/playground",
		},
		build = ":TSUpdate",
	},

	-- Git
	"lewis6991/gitsigns.nvim",
	{
		"f-person/git-blame.nvim",
		config = function()
			require("user.gitblame")
		end,
	},
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	"tyru/open-browser.vim",
	"junegunn/gv.vim",
	"rhysd/conflict-marker.vim",

	-- Session Management
	{
		"rmagatti/auto-session",
		config = function()
			require("user.session-manager")
		end,
	},
	{
		"rmagatti/session-lens",
		config = function()
			require("user.session-lens")
		end,
	},

	-- UI Decorations
	{
		"stevearc/dressing.nvim",
		config = function()
			require("user.dressing")
		end,
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			require("user.notify")
		end,
	},
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("user.neoscroll")
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("user.colorized")
		end,
	}, -- Color the Color
	{ "kevinhwang91/nvim-bqf", ft = "qf" }, -- Advance quick fix list
	{
		"ghillb/cybu.nvim",
		config = function()
			require("user.cybu")
		end,
	}, -- Buffer List in float

	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("user.lualine")
		end,
	},
}
