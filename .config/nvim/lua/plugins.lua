-- This file can be loaded by calling `lua require('plugins')` from your init.vim

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Sensible defaults
  use 'tpope/vim-sensible'

  use 'dcharbon/vim-flatbuffers'

  -- Tab lines
  use 'Yggdroot/indentLine'

  -- Wakatime
  -- use 'wakatime/vim-wakatime'

  -- Themes
  -- AYU: use 'ayu-theme/ayu-vim'
  use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
  -- use 'bradcush/base16-nvim'
  use 'RRethy/nvim-base16'

  -- Git
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'

  use 'famiu/feline.nvim'
  use 'kyazdani42/nvim-web-devicons'

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  -- Lib
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'mfussenegger/nvim-dap'

  -- File Tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'
  }

  -- Fuzzy Finder
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-ui-select.nvim'

  use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}

  -- Formatting
  use 'sbdchd/neoformat'

  -- LSP
  use 'neovim/nvim-lspconfig'

  -- use 'MunifTanjim/eslint.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'
  use {'jose-elias-alvarez/nvim-lsp-ts-utils', requires = {'neovim/nvim-lspconfig', 'nvim-lua/plenary.nvim', 'jose-elias-alvarez/null-ls.nvim'}}

  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'

  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/nvim-cmp'
  use 'simrat39/symbols-outline.nvim'
  use 'folke/trouble.nvim'
  use 'kosayoda/nvim-lightbulb'

  use 'editorconfig/editorconfig-vim'

  use 'rust-lang/rust.vim'
  use 'simrat39/rust-tools.nvim'

  use 'docker/docker'
  use 'skanehira/docker-compose.vim'
end)
