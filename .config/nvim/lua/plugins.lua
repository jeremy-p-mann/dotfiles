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
    "eandrju/cellular-automaton.nvim",
    "benmills/vimux",
    "jpalardy/vim-slime",
    "vim-test/vim-test",
    "lewis6991/gitsigns.nvim",
    "ThePrimeagen/harpoon",
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-fzy-native.nvim",
    "debugloop/telescope-undo.nvim",
    "jmann277/telescope-send-to-harpoon.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "EdenEast/nightfox.nvim",
    "stevearc/aerial.nvim",
    {
        "neovim/nvim-lspconfig",
        dependencies = { 'saghen/blink.cmp' }
    },
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-context",
    "L3MON4D3/LuaSnip",
    "rcarriga/nvim-notify",
    "nvimtools/none-ls.nvim",
    "AckslD/nvim-neoclip.lua",
    "stevearc/oil.nvim",
    "camgraff/telescope-tmux.nvim",
    {
        "stevearc/dressing.nvim",
        event = 'VeryLazy'
    },
    "kkharji/sqlite.lua",
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            indent = { enabled = true, animate = { enabled = false }, scope = { enabled = false } },
            image = {
                enabled = true,
                doc = { float = false, inline = false },
            },
            gitbrowse = { enabled = true },
            picker = { enabled = true },
            quickfile = { enabled = true }

        },
    },
    {
        "olimorris/codecompanion.nvim",
        config = true,
        event = 'VeryLazy'
    },
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
        },
    },
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets', { 'L3MON4D3/LuaSnip', version = 'v2.*' } },
        version = '1.*',
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = { preset = 'default' },
            appearance = { nerd_font_variant = 'mono' },
            completion = { documentation = { auto_show = true, auto_show_delay_ms = 500 } },
            snippets = { preset = 'luasnip' },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
                    path = {
                        opts = {
                            get_cwd = function(_)
                                return vim.fn.getcwd()
                            end,
                        },
                    },
                },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    }
}
for _, plugin in ipairs(local_plugins) do
    table.insert(plugins, plugin)
end
lazy.setup(plugins)
