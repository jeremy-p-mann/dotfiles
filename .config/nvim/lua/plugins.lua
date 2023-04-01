local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local lazy = require "lazy"
local local_plugins = require("jer.local").get_plugins()

local plugins = {
  "nvim-lua/plenary.nvim",
  "lewis6991/impatient.nvim",
  "eandrju/cellular-automaton.nvim",
  "nvim-treesitter/playground",
  "tpope/vim-commentary",
  "benmills/vimux",
  "voldikss/vim-floaterm",
  "jpalardy/vim-slime",
  "tpope/vim-capslock",
  "nvim-lua/popup.nvim",
  "jmann277/tarot.nvim",
  "vim-test/vim-test",
  "lewis6991/gitsigns.nvim",
  "ThePrimeagen/harpoon",
  "nvim-telescope/telescope.nvim",
  "nvim-telescope/telescope-fzy-native.nvim",
  "jmann277/telescope-send-to-harpoon.nvim",
  "nvim-telescope/telescope-ui-select.nvim",
  "nvim-telescope/telescope-file-browser.nvim",
  "norcalli/nvim-colorizer.lua",
  "gruvbox-community/gruvbox",
  "EdenEast/nightfox.nvim",
  "rose-pine/neovim",
  "aditya-azad/candle-grey",
  "olimorris/onedarkpro.nvim",
  "neovim/nvim-lspconfig",
  "tpope/vim-surround",
  "nvim-treesitter/nvim-treesitter-textobjects",
  "nvim-treesitter/nvim-treesitter-context",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lua",
  "onsails/lspkind-nvim",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  "rafamadriz/friendly-snippets",
  "rcarriga/nvim-notify",
  "jose-elias-alvarez/null-ls.nvim",
  "hashivim/vim-terraform",
  "rcarriga/nvim-dap-ui",
  "mfussenegger/nvim-dap",
  "mfussenegger/nvim-dap-python",
  "AckslD/nvim-neoclip.lua",
  "nvim-telescope/telescope-symbols.nvim",
  "camgraff/telescope-tmux.nvim",
  "benfowler/telescope-luasnip.nvim",
  "stevearc/dressing.nvim",
  "kkharji/sqlite.lua",
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update { with_sync = true }
    end,
  },
}

for _, plugin in ipairs(local_plugins) do
  table.insert(plugins, plugin)
end
lazy.setup(plugins)
