require("nvim-treesitter.configs").setup {
  highlight = { enable = true },
  indent = { enable = true , disable = {"html"}},
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
  auto_install = true,
}
require("nvim-treesitter.configs").setup {
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
  move = {
    enable = true,
    set_jumps = true, -- whether to set jumps in the jumplist
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
}
