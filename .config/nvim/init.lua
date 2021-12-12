require('jer.plugins')

vim.api.nvim_exec(
[[
set number
set relativenumber

set mouse=a

" Reload the file when it changes
set autoread

set noswapfile
syntax enable

set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set smartindent
set ai " autoindent

set showmode " show the current mode
set showcmd " show the command as it's being typed

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

set incsearch
set ignorecase
set smartcase
set nohlsearch " I don't like highlights when I search

set scrolloff=3
set cursorline

set hidden "navigate to and from without saving

set splitbelow splitright

set background=dark
set termguicolors
let g:gruvbox_italicize_comments = 0
let g:gruvbox_contrast_dark = 'hard'
colorscheme duskfox
]],
false)

local actions = require('telescope.actions')
local themes = require'telescope.themes'
require('telescope').setup {
    defaults = {
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        prompt_prefix = '> ',
        layout_strategy = 'horizontal',
        color_devicons = true,
        path_display = {shorten = 2},
        file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
        sorting_strategy = "ascending",
        layout_config = {
            width = .95,
            height = .9,
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
          }
        },
        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-q>"] = actions.send_to_qflist,
                ["<C-y>"] = require('jer.telescope').copy_path_to_clipboard,
                ["<C-c>"] = actions.close,
            },
            n = {
                ["<C-c>"] = actions.close
            },
        }
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    }
}

require('telescope').load_extension('fzy_native')
require('gitsigns').setup()

require('jer.lsp')
require('jer.completion')
require('jer.remaps')
require('jer.treesitter')

