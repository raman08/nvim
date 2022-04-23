local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git", "clone", "--depth", "1",
        "https://github.com/wbthomason/packer.nvim", install_path
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
        end
    }
}

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here

    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
    use "folke/tokyonight.nvim" -- Defalut theme
    use 'tomasiser/vim-code-dark' -- Color Theme

    use "windwp/nvim-autopairs" -- Auto Complete Bracket
    use "numToStr/Comment.nvim" -- Comment Helper

    use "akinsho/bufferline.nvim" -- BufferLine
    use "moll/vim-bbye"
    use "akinsho/toggleterm.nvim" -- Open Program in nvim
    use "ahmedkhalf/project.nvim" -- Project Management Made easy
    use 'lewis6991/impatient.nvim' -- Improve Loadup Time
    use "lukas-reineke/indent-blankline.nvim" -- Show Intend lines
    use 'goolord/alpha-nvim' -- Nvim Greeter
    use 'antoinemadec/FixCursorHold.nvim' -- fix some unknow issue
    use "folke/which-key.nvim"
    -- use "unblevable/quick-scope" -- Quickly jump to chracters
    use "norcalli/nvim-colorizer.lua" -- Color the Color
    -- use "rcarriga/nvim-notify"
    use {
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        ft = "markdown"
    }
    use "andymass/vim-matchup"
    use "folke/todo-comments.nvim"

    use "mbbill/undotree"

    -- Cmp Plugins
    use 'hrsh7th/nvim-cmp' -- Completion Client
    use 'hrsh7th/cmp-buffer' -- Buffer Completion
    use 'hrsh7th/cmp-path' -- Path Completion
    use 'hrsh7th/cmp-cmdline' -- Comandline Completion
    use "saadparwaiz1/cmp_luasnip" -- Snippets Completion
    use "hrsh7th/cmp-nvim-lsp" -- LSP Completion
    use "hrsh7th/cmp-nvim-lua" -- LUA Completion
    use 'karb94/neoscroll.nvim' -- Use for custom scroll animation
    use "hrsh7th/cmp-emoji"

    -- Snippets
    use "L3MON4D3/LuaSnip" -- Snippets Engine
    use "rafamadriz/friendly-snippets" -- A bunch of community driven Snippets

    -- LSP
    use "neovim/nvim-lspconfig" -- Nvim Lsp
    use "williamboman/nvim-lsp-installer" -- LSP Client installer
    use "jose-elias-alvarez/null-ls.nvim" -- For Formatting and Linting
    use {"phpactor/phpactor", run = "composer install --no-dev -o", ft = "php"} -- Php Support for Nvim
    use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
    use "glepnir/lspsaga.nvim"
    use "filipdutescu/renamer.nvim"
    use "simrat39/symbols-outline.nvim"
    use "ray-x/lsp_signature.nvim"
    use "b0o/SchemaStore.nvim"
    use "fatih/vim-go"
    -- use "RRethy/vim-illuminate"

    -- Telescope
    use "nvim-telescope/telescope.nvim" -- Telescope
    use "nvim-telescope/telescope-media-files.nvim" -- View Media in Telescope
    use {"nvim-telescope/telescope-file-browser.nvim"}
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}

    -- TreeSitter
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"} -- TreeSitter
    use "p00f/nvim-ts-rainbow" -- Rainbow Color Bracket
    use "nvim-treesitter/playground" -- TreeSitter playground
    use "JoosepAlviste/nvim-ts-context-commentstring" -- Setting Comment Based On curser location
    use "windwp/nvim-ts-autotag"
    use "romgrk/nvim-treesitter-context"

    -- Git
    use "lewis6991/gitsigns.nvim"
    use "f-person/git-blame.nvim"
    use "tpope/vim-fugitive"
    -- use "mattn/vim-gist"
    -- use "mattn/webapi-vim"
    use "junegunn/gv.vim"
    -- use "rudylee/nvim-gist"

    -- File Tree
    use "kyazdani42/nvim-tree.lua" -- File Tree
    use "kyazdani42/nvim-web-devicons" -- File Tree Icons

    -- LuaLine
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    -- Compititve programming --
    use {"searleser97/cpbooster.vim"}
    use {
        'xeluxee/competitest.nvim',
        requires = {'MunifTanjim/nui.nvim', opt = true}
    }
    use 'skywind3000/asynctasks.vim'
    use 'skywind3000/asyncrun.vim'

    -- Debugging Applications --
    use "puremourning/vimspector"

    -- Wakatimw for coding activity --
    use "wakatime/vim-wakatime"

    -- firenvim
    -- use {
    --     'glacambre/firenvim',
    --     run = function() vim.fn['firenvim#install'](0) end
    -- }

    -- use "ianding1/leetcode.vim"

    -- Nvim Dap --
    -- use "mfussenegger/nvim-dap"
    -- use "theHamsta/nvim-dap-virtual-text"
    -- use "rcarriga/nvim-dap-ui"
    -- use "Pocco81/DAPInstall.nvim"

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then require("packer").sync() end
end)
