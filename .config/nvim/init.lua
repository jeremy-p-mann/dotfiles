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


require('jer')

require('jer.lsp')
require('jer.completion')
require('jer.treesitter')
require('jer.float_term')
require('jer.notify')
require('jer.remaps')

