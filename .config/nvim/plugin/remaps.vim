"
" Jeremy's Remaps
"

" Leader key = space
nnoremap <SPACE> <Nop>
let mapleader="\<Space>"

" easier to move to start/end of the line
map H ^
map L $

" add line above/below without entering insert mode or moving cursor
nnoremap <silent> <leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

" spell check stuff
nnoremap <silent> <leader>sp :set spell!<CR>
nnoremap <silent> <leader>sc 1z=

nnoremap <silent> <leader>af gqk

" resize windows
nnoremap <silent> <leader>k :resize +10<CR>
nnoremap <silent> <leader>j :resize -10<CR>

" make moving windows easier
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Toggles cursorlines
nnoremap <silent> <leader>cl :set cursorline<CR>
nnoremap <silent> <leader>Cl :set nocursorline<CR>

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
nnoremap <silent> <leader>ws :call TrimWhitespace()<CR>

" Folds
nnoremap <silent> <leader>fp zfi{

" Control p for fuzzy file finder
nnoremap <silent> <C-p> :Files<CR>

" AutoComplete
nnoremap <silent> <leader>df :w <CR> :YcmCompleter GoToDefinition<CR>
nnoremap <silent> <leader><tab> :YcmCompleter GetDoc<CR>

" Linting on/off
nnoremap <silent> <leader>lt :ALEToggle <CR>

" Minimal Modes
nnoremap <silent> <leader>li :Limelight <CR>
nnoremap <silent> <leader>Li :Limelight! <CR>
nnoremap <silent> <leader>g :Goyo <CR>

" Vimux
nnoremap <leader>vp :VimuxPromptCommand<CR>
nnoremap <leader>vl :VimuxRunLastCommand<CR>
nnoremap <Leader>vv :VimuxCloseRunner<CR>

nnoremap <silent> <leader>mh :w <CR>:VimuxRunCommand("make html")<CR>
let showdocs  = "open -a 'Brave Browser' build/html/index.html"
nnoremap <silent> <leader>sd :VimuxRunCommand(showdocs)<CR>

nnoremap <silent> <leader>lg :VimuxRunCommand("lazygit")<CR>

nnoremap <silent> <leader>ex :VimuxRunCommand("python3 " . expand('%')) <CR>

nnoremap <silent> <leader>asc :VimuxRunCommand("asciiquarium")<CR>
nnoremap <silent> <leader>asl :VimuxRunCommand("asciiquarium \| lolcat")<CR>

" UltiSnips
nnoremap <silent> <leader>ue <C-w>s :w <CR>:UltiSnipsEdit<CR>

" Vim-test
nnoremap <silent> <leader>tn :TestNearest<CR>
nnoremap <silent> <leader>tf :TestFile<CR>
nnoremap <silent> <leader>ts :TestSuite<CR>
nnoremap <silent> <leader>tl :TestLast<CR>
" Visits the test file from which you last run your tests
nnoremap <silent> <leader>tv :TestVisit<CR>
