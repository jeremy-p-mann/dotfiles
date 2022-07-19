local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
end

vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
  if packer_bootstrap then
    require("packer").sync()
  end
  use "nvim-lua/plenary.nvim"

  use "wbthomason/packer.nvim"
  use "tpope/vim-commentary"

  use "benmills/vimux"
  use "voldikss/vim-floaterm"
  use "jpalardy/vim-slime"

  use "tpope/vim-capslock"
  use "nvim-lua/popup.nvim"
  use "jmann277/tarot.nvim"

  use "vim-test/vim-test"

  use "lewis6991/gitsigns.nvim"

  use "ThePrimeagen/harpoon"
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-fzy-native.nvim"
  use '/Users/jeremymann/Documents/code/telescope-send-to-harpoon.nvim'

  use "Pocco81/TrueZen.nvim"
  use "norcalli/nvim-colorizer.lua"
  use "gruvbox-community/gruvbox"
  use "EdenEast/nightfox.nvim"
  use "rose-pine/neovim"
  use "aditya-azad/candle-grey"

  use "neovim/nvim-lspconfig"

  use "tpope/vim-surround"
  use "nvim-treesitter/nvim-treesitter-textobjects"

  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/cmp-nvim-lua"
  use "onsails/lspkind-nvim"

  use "L3MON4D3/LuaSnip"
  use "saadparwaiz1/cmp_luasnip"
  use "rafamadriz/friendly-snippets"

  use "rcarriga/nvim-notify"

  use "jose-elias-alvarez/null-ls.nvim"
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "hashivim/vim-terraform"

  use "rcarriga/nvim-dap-ui"
  use "mfussenegger/nvim-dap"
  use "mfussenegger/nvim-dap-python"

  use "AckslD/nvim-neoclip.lua"
end)
