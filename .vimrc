"  Jeremy Mann's .vimrc
set number
set ai " autoindent
set relativenumber
set title
set noswapfile
syntax enable
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set smartindent
set nohlsearch

nnoremap <SPACE> <Nop>
let mapleader="\<Space>"

" show the current mode
set showmode
" show the command as it's being typed
set showcmd

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

set incsearch
set ignorecase
set smartcase

" make new window open on right/below
set splitbelow splitright

nnoremap ; :
nnoremap : ;

" add line above/below without entering insert mode or moving cursor
nnoremap <silent> <leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

" dturn on spell check
nnoremap <silent> <leader>sp :set spell!<CR>

" resize windows
nnoremap <silent> <leader>k :resize +5<CR>
nnoremap <silent> <leader>j :resize -5<CR>

" make moving windows easier
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" easier to move to start/end of the line
map H ^
map L $

" Control t for fuzzy file finder
nnoremap <silent> <C-t> :Files<CR>

" Remove crutches in Command Mode
cnoremap <Down> <Nop>
cnoremap <Left> <Nop>
cnoremap <Right> <Nop>
cnoremap <Up> <Nop>

" Remove crutches in Insert Mode
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>

" Remove crutches in Normal Mode
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>

" Remove crutches in Visual Mode
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
vnoremap <Up> <Nop>	

" Make html with sphinx--must be in docs folder
nnoremap <silent> <leader>c :w<CR> :silent ! make html<CR> 
nnoremap <silent> <leader>sd :w<CR> :silent ! open -a firefox build/html/index.html<CR> 

" Typing and testing
nnoremap <silent> <leader>mp :w<CR> :! mypy %<CR>
nnoremap <silent> <leader>pt :w<CR> :!pytest<CR>

nnoremap <silent> <leader>df :w <CR> :YcmCompleter GoToDefinition<CR> 
nnoremap <silent> <leader>dc :w <CR> :YcmCompleter GoToDeclaration<CR>

" Snippets
nnoremap <silent> <leader>sn :Snippets<CR>

call plug#begin('~/.vim/plugged')

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
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" LIMELIGHT/Goyo
let g:limelight_conceal_ctermfg = 'DarkGray'
let g:limelight_default_coefficient = 0.1

nnoremap <silent> <leader>l :Limelight <CR>
nnoremap <silent> <leader>L :Limelight! <CR>
nnoremap <silent> <leader>g :Goyo <CR>

" Gruvbox 
let g:gruvbox_italicize_comments = 0
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
set background=dark

" Ale
let g:ale_linters = {'python': ['flake8', 'mypy']}
