" 
" Jeremy's Remaps
"

" Leader key = spacce
nnoremap <SPACE> <Nop>
let mapleader="\<Space>"

" I don't know how I feel about this but I don't like pressing shift
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

" Make html with sphinx--must be in docs folder
nnoremap <silent> <leader>c :w<CR> :silent ! make html<CR> 
nnoremap <silent> <leader>sd :w<CR> :silent ! open -a firefox build/html/index.html<CR> 

" Typing and testing
nnoremap <silent> <leader>mp :w<CR> :! mypy %<CR>
nnoremap <silent> <leader>pt :w<CR> :!pytest<CR>

" AutoComplete
nnoremap <silent> <leader>df :w <CR> :YcmCompleter GoToDefinition<CR> 
nnoremap <silent> <leader><tab> :YcmCompleter GetDoc<CR> 

" Linting
nnoremap <silent> <leader>lt :ALEToggle <CR>

" Minimal Modes
nnoremap <silent> <leader>li :Limelight <CR>
nnoremap <silent> <leader>Li :Limelight! <CR>
nnoremap <silent> <leader>g :Goyo <CR>

