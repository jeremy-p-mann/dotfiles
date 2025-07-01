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
    dependencies = { "saghen/blink.cmp" },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      auto_install = true,
      ensure_installed = {
        "c",
        "html",
        "typescript",
        "python",
        "rust",
        "lua",
        "bash",
        "sql",
        "bash",
        "json",
        "yaml",
        "ruby",
        "rst",
        "markdown",
        "latex",
        "javascript",
        "go",
        "dockerfile",
        "cpp",
        "c_sharp",
        "toml",
        "vim",
        "vimdoc",
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
    },
  },
  "nvim-treesitter/nvim-treesitter-textobjects",
  "nvim-treesitter/nvim-treesitter-context",
  "L3MON4D3/LuaSnip",
  "rcarriga/nvim-notify",
  "nvimtools/none-ls.nvim",
  "AckslD/nvim-neoclip.lua",
  "stevearc/oil.nvim",
  "camgraff/telescope-tmux.nvim",
  "kkharji/sqlite.lua",
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      indent = {
        enabled = true,
        animate = { enabled = false },
        scope = { enabled = false },
      },
      input = { enabled = true },
      image = {
        enabled = true,
        doc = { float = false, inline = false },
      },
      gitbrowse = { enabled = true },
      picker = { enabled = true },
      quickfile = { enabled = true },
    },
    styles = {
      input = {
        win_opts = {
          relative = "cursor",
          anchor = "SW",
          row = -1,
          col = 0,
        },
      },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    config = true,
    event = "VeryLazy",
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      { "L3MON4D3/LuaSnip", version = "v2.*" },
    },
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = "default" },
      appearance = { nerd_font_variant = "mono" },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
      },
      snippets = { preset = "luasnip" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
          path = {
            opts = {
              get_cwd = function(_)
                return vim.fn.getcwd()
              end,
            },
          },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require "lint"
      lint.linters_by_ft = {
        python = { "mypy", "ruff" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd(
        { "BufEnter", "BufWritePost", "InsertLeave" },
        {
          group = lint_augroup,
          callback = function()
            if vim.bo.modifiable then
              lint.try_lint()
            end
          end,
        }
      )
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<leader>fm",
        function()
          require("conform").format { async = true }
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        sql = { "sqlfluff" },
      },
      default_format_opts = { lsp_format = "fallback" },
      -- Set up format-on-save
      format_on_save = { timeout_ms = 500 },
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" },
        },
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
for _, plugin in ipairs(local_plugins) do
  table.insert(plugins, plugin)
end
lazy.setup(plugins)
