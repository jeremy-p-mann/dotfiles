local actions = require "telescope.actions"
local themes = require "telescope.themes"

require("telescope").setup {
  defaults = {
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    prompt_prefix = "> ",
    layout_strategy = "horizontal",
    color_devicons = true,
    path_display = { shorten = 2 },
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    sorting_strategy = "ascending",
    layout_config = {
      width = 0.95,
      height = 0.9,
      prompt_position = "top",
      horizontal = {
        width_padding = 0.001,
        height_padding = 0.01,
        preview_width = 0.6,
      },
      vertical = {
        width_padding = 0.05,
        height_padding = 1,
        preview_height = 0.5,
      },
    },
    mappings = {
      i = {
        ["<C-x>"] = false,
        ["<C-q>"] = actions.send_to_qflist,
        ["<C-y>"] = require("jer.telescope").copy_path_to_clipboard,
        ["<C-c>"] = actions.close,
      },
      n = {
        ["<C-c>"] = actions.close,
      },
    },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
  },
}
require("telescope").load_extension "fzy_native"

require("gitsigns").setup()

require('jer.lsp')
require('jer.completion')
require('jer.float_term')
require('jer.notify')
require('jer.remaps')
require('jer.debug')
require('jer.testing')
require('jer.version_control')
require('jer.terminal')
require('jer.help')
require('jer.formatting')
require('jer.silly')
require('jer.diagnostics')
require('jer.snippets')

