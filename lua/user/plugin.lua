local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugin.lua source <afile> | PackerSync
	augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then return end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float {border = "rounded"}
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here

    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

    use "windwp/nvim-autopairs" -- Auto Complete Bracket
    use "numToStr/Comment.nvim" -- Comment Helper
    use "folke/todo-comments.nvim"

    use "akinsho/bufferline.nvim" -- BufferLine
    use "moll/vim-bbye"
    use "lewis6991/impatient.nvim" -- Improve Loadup Time

    use "akinsho/toggleterm.nvim" -- Open Program in nvim
    use "ahmedkhalf/project.nvim" -- Project Management Made easy
    use "lukas-reineke/indent-blankline.nvim" -- Show Intend lines

    use "goolord/alpha-nvim" -- Nvim Greeter
    use "nacro90/numb.nvim"
    use "folke/which-key.nvim"

    use "MattesGroeger/vim-bookmarks" -- bookmarks save the life

    use "phaazon/hop.nvim" -- Hop the lines easily
    use "andymass/vim-matchup" -- Match start and the ending
    use "kylechui/nvim-surround" -- Pairup easily

    -- Markdown Support 
    use {
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        ft = "markdown",
    }

    -- Colorschemes
    use "folke/tokyonight.nvim" -- Defalut theme
    use "tomasiser/vim-code-dark" -- Color Theme

    -- Cmp Plugins
    use "hrsh7th/nvim-cmp" -- Completion Client
    use "hrsh7th/cmp-buffer" -- Buffer Completion
    use "hrsh7th/cmp-path" -- Path Completion
    use "hrsh7th/cmp-cmdline" -- Comandline Completion
    use "saadparwaiz1/cmp_luasnip" -- Snippets Completion
    use "hrsh7th/cmp-nvim-lsp" -- LSP Completion
    use "hrsh7th/cmp-nvim-lua" -- LUA Completion
    use "hrsh7th/cmp-emoji"

    -- Snippets
    use "L3MON4D3/LuaSnip" -- Snippets Engine
    use "rafamadriz/friendly-snippets" -- A bunch of community driven Snippets

    -- LSP
    use "neovim/nvim-lspconfig" -- Nvim Lsp
    use "williamboman/nvim-lsp-installer" -- LSP Client installer
    use "jose-elias-alvarez/null-ls.nvim" -- For Formatting and Linting
    use {"phpactor/phpactor", run = "composer install --no-dev -o", ft = "php"} -- Php Support for Nvim
    use "glepnir/lspsaga.nvim"
    use "filipdutescu/renamer.nvim"
    use "ray-x/lsp_signature.nvim"
    use "b0o/SchemaStore.nvim"
    use "RRethy/vim-illuminate"
    use "simrat39/symbols-outline.nvim"
    use "folke/trouble.nvim"
    use "j-hui/fidget.nvim"
    -- use "fatih/vim-go"
    -- use "tamago324/nlsp-settings.nvim" -- language server settings defined in json formate

    -- Telescope
    use {"nvim-telescope/telescope.nvim", branch = "0.1.x"} -- Telescope
    use "nvim-telescope/telescope-media-files.nvim" -- View Media in Telescope
    use {"nvim-telescope/telescope-file-browser.nvim"}
    use {"nvim-telescope/telescope-fzf-native.nvim", run = "make"}
    use "tom-anders/telescope-vim-bookmarks.nvim"
    use "lalitmee/browse.nvim"

    -- TreeSitter
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"} -- TreeSitter
    use "JoosepAlviste/nvim-ts-context-commentstring" -- Setting Comment Based On curser location
    use "p00f/nvim-ts-rainbow" -- Rainbow Color Bracket
    use "windwp/nvim-ts-autotag"
    use "romgrk/nvim-treesitter-context"

    -- Git
    use "lewis6991/gitsigns.nvim"
    use "f-person/git-blame.nvim"
    use "tpope/vim-fugitive"
    use "tpope/vim-rhubarb"
    use "tyru/open-browser.vim"
    use "junegunn/gv.vim"
    use "rhysd/conflict-marker.vim"

    -- File Tree
    use "kyazdani42/nvim-tree.lua" -- File Tree
    use "kyazdani42/nvim-web-devicons" -- File Tree Icons

    -- LuaLine
    use {
        "christianchiarulli/lualine.nvim",
        -- "nvim-lualine/lualine.nvim",
        requires = {"kyazdani42/nvim-web-devicons", opt = true},
    }

    -- Compititve programming --
    use {
        "xeluxee/competitest.nvim",
        requires = {"MunifTanjim/nui.nvim", opt = true},
    }
    use "skywind3000/asynctasks.vim"
    use "skywind3000/asyncrun.vim"
    -- use "ianding1/leetcode.vim"
    use {"michaelb/sniprun", run = "bash ./install.sh"}

    -- Wakatimw for coding activity --
    use "wakatime/vim-wakatime"

    -- Session Management
    use "rmagatti/auto-session"
    use "rmagatti/session-lens"

    -- UI Management
    use {"stevearc/dressing.nvim"}
    use "rcarriga/nvim-notify"
    use "karb94/neoscroll.nvim"
    use "norcalli/nvim-colorizer.lua" -- Color the Color
    use {"kevinhwang91/nvim-bqf", ft = "qf"} -- Advance quick fix list
    -- use "ghillb/cybu.nvim" -- Buffer List in float
    use "matbme/JABS.nvim"

    -- Debugging Applications --
    use "puremourning/vimspector"

    -- Nvim Dap --
    -- use "mfussenegger/nvim-dap"
    -- use "theHamsta/nvim-dap-virtual-text"
    -- use "rcarriga/nvim-dap-ui"
    -- use "Pocco81/DAPInstall.nvim"

    -- Graveyard
    -- use "folke/twilight.nvim"
    -- use "mbbill/undotree"

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then require("packer").sync() end
end)
