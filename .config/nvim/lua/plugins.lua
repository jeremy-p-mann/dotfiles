local local_plugins = require("jer.local").get_plugins()

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
  vim.cmd [[packadd packer.nvim]]
end

return require("packer").startup(function(use)
  use "nvim-lua/plenary.nvim"

  use "lewis6991/impatient.nvim"
  use "eandrju/cellular-automaton.nvim"
  use "nvim-treesitter/playground"

  use "wbthomason/packer.nvim"
  use "tpope/vim-commentary"

  use "benmills/vimux"
  use "voldikss/vim-floaterm"
  use "jpalardy/vim-slime"

  use "tpope/vim-capslock"
  use "nvim-lua/popup.nvim"
  use "jmann277/tarot.nvim"

  use { "vim-test/vim-test", commit = "dfbf93d" }

  use "lewis6991/gitsigns.nvim"

  use "ThePrimeagen/harpoon"
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-fzy-native.nvim"
  use "jmann277/telescope-send-to-harpoon.nvim"
  use "nvim-telescope/telescope-ui-select.nvim"
  use { "nvim-telescope/telescope-file-browser.nvim" }

  use "norcalli/nvim-colorizer.lua"
  use "gruvbox-community/gruvbox"
  use "EdenEast/nightfox.nvim"
  use "rose-pine/neovim"
  use "aditya-azad/candle-grey"
  use "olimorris/onedarkpro.nvim"

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
    run = function()
      require("nvim-treesitter.install").update { with_sync = true }
    end,
  }
  use "hashivim/vim-terraform"

  use "rcarriga/nvim-dap-ui"
  use "mfussenegger/nvim-dap"
  use "mfussenegger/nvim-dap-python"

  use "AckslD/nvim-neoclip.lua"
  use "nvim-telescope/telescope-symbols.nvim"

  use "stevearc/dressing.nvim"

  use "kkharji/sqlite.lua"
  for _, plugin_name in ipairs(local_plugins) do
    use(plugin_name)
  end

  if packer_bootstrap then
    require("packer").sync()
  end
end)
