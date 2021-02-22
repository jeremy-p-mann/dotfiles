"
" Jeremy' init.vim
"

" See the number of the current line and relative line numbers otherwise
set number
set relativenumber

set noswapfile
syntax enable
set spell spelllang=en_us

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

set scrolloff=4
set cursorline

set hidden "navigate to and from without saving

set splitbelow splitright

set completeopt=menuone,noinsert,noselect

call plug#begin('~/.config/nvim/plugged')

" File Navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'SirVer/ultisnips'
" Nice Viewing
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
" Color Schemes
Plug 'gruvbox-community/gruvbox'
" Integrate tmux
Plug 'benmills/vimux'
" REPL-Driven Development
Plug 'metakirby5/codi.vim'
" Comment stuff out
Plug 'tpope/vim-commentary'
" Testing stuff
Plug 'vim-test/vim-test'
" For git stuff
Plug 'tpope/vim-fugitive'

" Telescope Requirements
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

call plug#end()


