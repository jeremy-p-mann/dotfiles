lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    initial_mode = "insert",
    layout_strategy = "flex",
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
    mappings = {
      i = {
        ["<C-x>"] = false,
        ["<C-s>"] = actions.goto_file_selection_split,
        ["<C-c>"] = actions.close,
      },
    },
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new, 
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new, 
  }
}
EOF
