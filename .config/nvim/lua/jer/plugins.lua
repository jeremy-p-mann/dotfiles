local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-commentary'
  use 'benmills/vimux'
  use 'voldikss/vim-floaterm'
  use 'tpope/vim-capslock'
  use 'vim-test/vim-test'
  use 'lewis6991/gitsigns.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-fzy-native.nvim'
  use 'norcalli/nvim-colorizer.lua'
  use 'gruvbox-community/gruvbox'
  use 'EdenEast/nightfox.nvim'
  use 'rose-pine/neovim'
  use 'aditya-azad/candle-grey'
  -- use 'SirVer/ultisnips'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'tpope/vim-surround'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'onsails/lspkind-nvim'
  use 'hrsh7th/cmp-nvim-lua'
  use 'rcarriga/nvim-notify'
  use 'jpalardy/vim-slime'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  if packer_bootstrap then
    require('packer').sync()
  end
end)
