"
" Jeremy' init.vim
" 

set number
set ai " autoindent
set relativenumber
set title
set noswapfile
syntax enable
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set smartindent
set nohlsearch

set spell spelllang=en_us


set showmode " show the current mode
set showcmd " show the command as it's being typed

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

set incsearch
set ignorecase
set smartcase

source remaps.vim

" make new window open on right/below
set splitbelow splitright

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

" UltiSnips
let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" LIMELIGHT/Goyo
let g:limelight_conceal_ctermfg = 'DarkGray'
let g:limelight_default_coefficient = 0.1



" Gruvbox 
let g:gruvbox_italicize_comments = 0
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
set background=dark

" Ale
let g:ale_linters = {'python': ['flake8', 'mypy']}
