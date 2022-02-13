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
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
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
  use "JoosepAlviste/nvim-ts-context-commentstring" -- Setting Comment Based On curser location

  use "akinsho/bufferline.nvim" -- BufferLine
  use "moll/vim-bbye"
  use "akinsho/toggleterm.nvim" -- Open Program in nvim
  use "ahmedkhalf/project.nvim" -- Project Management Made easy
  use 'lewis6991/impatient.nvim' -- Improve Loadup Time
  use "lukas-reineke/indent-blankline.nvim" -- Show Intend lines
  use 'goolord/alpha-nvim' -- Nvim Greeter
  use 'antoinemadec/FixCursorHold.nvim' -- fix some unknow issue
  use "folke/which-key.nvim"

  -- Cmp Plugins
  use 'hrsh7th/nvim-cmp' -- Completion Client
  use 'hrsh7th/cmp-buffer' -- Buffer Completion
  use 'hrsh7th/cmp-path' -- Path Completion
  use 'hrsh7th/cmp-cmdline' -- Comandline Completion
  use "saadparwaiz1/cmp_luasnip" -- Snippets Completion
  use "hrsh7th/cmp-nvim-lsp" -- LSP Completion
  use "hrsh7th/cmp-nvim-lua" -- LUA Completion

  -- Snippets
  use "L3MON4D3/LuaSnip" -- Snippets Engine
  use "rafamadriz/friendly-snippets" -- A bunch of community driven Snippets

  -- LSP
  use "neovim/nvim-lspconfig" -- Nvim Lsp
  use "williamboman/nvim-lsp-installer" -- LSP Client installer
  use "jose-elias-alvarez/null-ls.nvim" -- For Formatting and Linting
  use {"phpactor/phpactor", run="composer install --no-dev -o", ft="php"} -- Php Support for Nvim

  -- Telescope
  use "nvim-telescope/telescope.nvim" -- Telescope
  use "nvim-telescope/telescope-media-files.nvim" -- View Media in Telescope

  -- TreeSitter
  use {"nvim-treesitter/nvim-treesitter", run=":TSUpdate"} -- TreeSitter
  use "p00f/nvim-ts-rainbow" -- Rainbow Color Bracket
  use "nvim-treesitter/playground" -- TreeSitter playground

  -- Git
  use "lewis6991/gitsigns.nvim"

  -- File Tree
  use "kyazdani42/nvim-tree.lua" -- File Tree
  use "kyazdani42/nvim-web-devicons" -- File Tree Icons

  -- LuaLine
	use {
	  'nvim-lualine/lualine.nvim',
	  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

  -- Nvim Dap --
  use "mfussenegger/nvim-dap"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

