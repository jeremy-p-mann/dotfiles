local nremap = require("jer.keymaps").nremap
local vremap = require("jer.keymaps").vremap
local iremap = require("jer.keymaps").iremap

require("neoclip").setup {
  history = 1000,
  enable_persistent_history = false,
  continious_sync = false,
  db_path = vim.fn.stdpath "data" .. "/databases/neoclip.sqlite3",
  filter = nil,
  preview = true,
  default_register = '"',
  default_register_macros = "q",
  enable_macro_history = true,
  content_spec_column = false,
  on_paste = {
    set_reg = false,
  },
  on_replay = {
    set_reg = false,
  },
  keys = {
    telescope = {
      i = {
        select = "<cr>",
        paste = "<cr>",
        paste_behind = "<c-k>",
        replay = "<c-q>", -- replay a macro
        delete = "<c-d>", -- delete an entry
        custom = {},
      },
      n = {
        select = "<cr>",
        paste = "p",
        paste_behind = "P",
        replay = "q",
        delete = "d",
        custom = {},
      },
    },
    fzf = {
      select = "default",
      paste = "ctrl-p",
      paste_behind = "ctrl-k",
      custom = {},
    },
  },
}
require('telescope').load_extension('neoclip')
vremap("<leader>y", [["+y]], "Copy to System Register")
nremap("<leader>y", [["+y]], "Yank Motion to System Register")
nremap("<leader>Y", [[gg"+yG]], "Yank File to System Register")
nremap("<leader>p", [["+p]], "Paste From System Register")
nremap("<leader>P", [["+P]], "Paste Above/Before From System Register")
nremap("<leader>tr", [[:Telescope neoclip<cr>]], "Telescope Register")
iremap("<C-v>", [[<C-c>"+pa]], "Telescope Register")
