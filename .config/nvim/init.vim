"
" Jeremy' init.vim
"

" See the number of the current line and relative line numbers otherwise
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

call plug#begin('~/.config/nvim/plugged')

Plug 'benmills/vimux'

Plug 'voldikss/vim-floaterm'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-capslock'

Plug 'vim-test/vim-test'

Plug 'lewis6991/gitsigns.nvim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'neovim/nvim-lspconfig'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }

Plug 'norcalli/nvim-colorizer.lua'
Plug 'gruvbox-community/gruvbox'
Plug 'EdenEast/nightfox.nvim'
Plug 'rose-pine/neovim'

Plug 'SirVer/ultisnips'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'onsails/lspkind-nvim'
Plug 'hrsh7th/cmp-nvim-lua'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'


call plug#end()

set background=dark
set termguicolors
let g:gruvbox_italicize_comments = 0
let g:gruvbox_contrast_dark = 'hard'
colorscheme duskfox

lua require('jer')


