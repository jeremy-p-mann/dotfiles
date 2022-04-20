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
  use "Pocco81/TrueZen.nvim"
  use "wbthomason/packer.nvim"
  use "L3MON4D3/LuaSnip"
  use "tpope/vim-commentary"
  use "benmills/vimux"
  use "voldikss/vim-floaterm"
  use "tpope/vim-capslock"
  use "vim-test/vim-test"
  use "lewis6991/gitsigns.nvim"
  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"
  use "/Users/jeremymann/Documents/code/tarot.nvim"
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-fzy-native.nvim"
  use "norcalli/nvim-colorizer.lua"
  use "gruvbox-community/gruvbox"
  use "EdenEast/nightfox.nvim"
  use "rose-pine/neovim"
  use "aditya-azad/candle-grey"
  use "neovim/nvim-lspconfig"

  use "nvim-treesitter/nvim-treesitter-textobjects"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "tpope/vim-surround"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "saadparwaiz1/cmp_luasnip"
  use "rafamadriz/friendly-snippets"
  use "onsails/lspkind-nvim"
  use "hrsh7th/cmp-nvim-lua"
  use "rcarriga/nvim-notify"
  use "jpalardy/vim-slime"
  use "jose-elias-alvarez/null-ls.nvim"
  use "rcarriga/nvim-dap-ui"
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "mfussenegger/nvim-dap"
  use "mfussenegger/nvim-dap-python"
  if packer_bootstrap then
    require("packer").sync()
  end
  use "ThePrimeagen/harpoon"
  use "AckslD/nvim-neoclip.lua"
end)
