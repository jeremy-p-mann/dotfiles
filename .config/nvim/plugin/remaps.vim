"User
" Jeremy's Remaps
"

" Leader key = space
nnoremap <SPACE> <Nop>
let mapleader="\<Space>"

" add line above/below without entering insert mode or moving cursor
nnoremap <silent> <leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

" spell check stuff
nnoremap <silent> <leader>sp :set spell!<CR>
nnoremap <silent> <leader>sc 1z=

nnoremap <silent> <leader>af gqk

" git blame
nnoremap <silent> <leader>gb :GitBlameToggle<CR>

" Search for current python class
nnoremap <silent> <leader>fc /^class <CR>

" resize windows
nnoremap <silent> <leader>k :resize +10<CR>
nnoremap <silent> <leader>j :resize -10<CR>

" make moving windows easier
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Navigate Through a Quickfix List
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>

" Copy/paste to/from the clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG
nnoremap <leader>p "+p


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
nnoremap <silent> <Leader>ff :Files<CR>

" Linting on/off
nnoremap <silent> <leader>lt :ALEToggle <CR>

" Minimal Modes
nnoremap <silent> <leader>li :Limelight <CR>
nnoremap <silent> <leader>Li :Limelight! <CR>
nnoremap <silent> <leader>go :Goyo <CR>


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
nnoremap <silent> <leader>lf :w <CR>:VimuxRunCommand("lua " . expand("%"))<CR>


" UltiSnips
nnoremap <silent> <leader>ue <C-w>s :w <CR>:UltiSnipsEdit<CR>

" Vim-test
nnoremap <silent> <leader>tn :TestNearest<CR>
nnoremap <silent> <leader>tf :TestFile<CR>
nnoremap <silent> <leader>ts :TestSuite<CR>
nnoremap <silent> <leader>tl :TestLast<CR>
" Visits the test file from which you last run your tests
nnoremap <silent> <leader>tv :TestVisit<CR>

" Telescope
nnoremap <C-p>  :lua require'telescope.builtin'.find_files(require('telescope.themes'))<cr>
nnoremap <Leader>fb :lua require'telescope.builtin'.buffers(require('telescope.themes'))<cr>
nnoremap <leader>fs :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <leader>vrc :lua require('jer.telescope').search_dotfiles()<CR>
nnoremap <leader>ft :lua require('jer.telescope').find_tests()<CR>

" Completion
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" LSP
nnoremap <Leader>df :lua vim.lsp.buf.definition()<CR>
nnoremap <Leader>rn :lua vim.lsp.buf.rename()<CR>
nnoremap <Leader>ho :lua vim.lsp.buf.hover()<CR>
nnoremap <Leader>fm :lua vim.lsp.buf.formatting()<CR>
nnoremap <Leader>rf :lua vim.lsp.buf.references()<CR>
