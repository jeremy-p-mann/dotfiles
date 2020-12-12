"
" Jeremy' init.vim
" 
set relativenumber

set noswapfile
syntax enable

set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set smartindent
set ai " autoindent

set spell spelllang=en_us

set showmode " show the current mode
set showcmd " show the command as it's being typed

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

set incsearch
set ignorecase
set smartcase
set nohlsearch " I don't like highlights when I search


set splitbelow splitright " make new window open on right/below

call plug#begin('~/.config/nvim/plugged')

" File Navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Completions/Snippets
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'SirVer/ultisnips'

" Linters/Fixers
Plug 'dense-analysis/ale'

Plug 'tpope/vim-fugitive'

" Nice Viewing
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Color Schemes
Plug 'gruvbox-community/gruvbox'
call plug#end()

source remaps.vim
source plugin_config.vim
