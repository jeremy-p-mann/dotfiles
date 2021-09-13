"
" Jeremy' init.vim
"

" See the number of the current line and relative line numbers otherwise
set number
set relativenumber

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

Plug 'SirVer/ultisnips'
" Nice Viewing
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
" Integrate tmux
Plug 'benmills/vimux'

Plug 'voldikss/vim-floaterm'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-capslock'

Plug 'vim-test/vim-test'

Plug 'f-person/git-blame.nvim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'neovim/nvim-lspconfig'

Plug 'nvim-lua/completion-nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }

Plug 'gruvbox-community/gruvbox'
Plug 'flazz/vim-colorschemes'
Plug 'sainnhe/sonokai'
Plug 'mangeshrex/uwu.vim'
Plug 'dylanaraps/wal.vim'
Plug 'norcalli/nvim-colorizer.lua' " This brings me the most joy

call plug#end()

set background=dark
set termguicolors

lua require('jer')
