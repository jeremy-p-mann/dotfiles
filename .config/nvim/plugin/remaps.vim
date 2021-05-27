"User
" Jeremy's Remaps
"

" Leader key = space
nnoremap <SPACE> <Nop>
let mapleader="\<Space>"

" add line above/below without entering insert mode or moving cursor
nnoremap <silent> <leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

nnoremap <silent> <leader>so :w <CR> :so %<CR>


" Replace word
nnoremap <silent> <leader>rw viwp

" spell check stuff
nnoremap <silent> <leader>sp :set spell!<CR>
nnoremap <silent> <leader>sc 1z=

" Format things like paragraphs
nnoremap <silent> <leader>af gqk

" git blame
nnoremap <silent> <leader>gb :GitBlameToggle<CR>

" resize windows
nnoremap <silent> <leader>k :resize +10<CR>
nnoremap <silent> <leader>j :resize -10<CR>

" make moving windows easier
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Navigate Through a Quickfix List
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>

nnoremap <leader>bp oimport pdb; pdb.set_trace()

" Copy/paste to/from the clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG
nnoremap <leader>p "+p
nnoremap <leader>P "+P


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

" Formatting JSONS
noremap <silent><leader>jq :%!python -m json.tool<cr>

" Minimal Modes
nnoremap <silent> <leader>li :Limelight <CR>
nnoremap <silent> <leader>Li :Limelight! <CR>
nnoremap <silent> <leader>go :Goyo <CR>

let current_file = expand("%")
" FloatTerm
nnoremap <silent><leader>lg :FloatermNew! --height=0.9 --width=0.9 lazygit<CR>
nnoremap <silent> <leader>asc :FloatermNew! --height=0.999 --width=0.999 asciiquarium<CR>
nnoremap <silent> <leader>asl :execute("FloatermNew! --height=0.9 --width=0.9 asciiquarium \| lolcat)<CR>
nnoremap <silent><leader>mp :execute("FloatermNew! --height=0.9 --width=0.9 mypy " . current_file)<CR>
nnoremap <silent><leader>ex :execute("FloatermNew! --height=0.9 --width=0.9 python " . current_file)<CR>
nnoremap <silent><leader>ip :execute("FloatermNew! --height=0.9 --width=0.9 ipython")<CR>



" Vimux
nnoremap <leader>vp :VimuxPromptCommand<CR>
nnoremap <leader>vl :VimuxRunLastCommand<CR>
nnoremap <Leader>vv :VimuxCloseRunner<CR>
nnoremap <silent> <leader>mh :w <CR>:VimuxRunCommand("make html")<CR>
let showdocs  = "open -a 'Brave Browser' build/html/index.html"
nnoremap <silent> <leader>sd :VimuxRunCommand(showdocs)<CR>
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
nnoremap <Leader>ff  :lua require'telescope.builtin'.find_files(require('telescope.themes'))<cr>
nnoremap <C-p>  :lua require'telescope.builtin'.git_files(require('telescope.themes'))<cr>
nnoremap <Leader>fb :lua require'telescope.builtin'.buffers(require('telescope.themes'))<cr>
nnoremap <leader>fs :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <leader>fz :lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>vrc :lua require('jer.telescope').search_dotfiles()<CR>
nnoremap <leader>ft :lua require('jer.telescope').find_tests()<CR>
nnoremap <leader>fc :lua require('jer.telescope').find_in_current_directory()<CR>
nnoremap <silent><leader>ch <cmd>lua require('telescope.builtin').command_history{}<CR>


nnoremap <silent><leader>tb :Tabularize /,<CR>


" Completion
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" LSP
nnoremap <Leader>df :lua vim.lsp.buf.definition()<CR>
nnoremap <Leader>rn :lua vim.lsp.buf.rename()<CR>
nnoremap <Leader>ho :lua vim.lsp.buf.hover()<CR>
nnoremap <Leader>fm :lua vim.lsp.buf.formatting()<CR>
nnoremap <Leader>rf <cmd>lua require'telescope.builtin'.lsp_references{}<CR>

" Harpoon
" Harpoon Throw
nnoremap <Leader>ht :lua require("harpoon.mark").add_file()<CR>
nnoremap <Leader>1 :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <Leader>2 :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <Leader>3 :lua require("harpoon.ui").nav_file(3)<CR>
" Harpoon File
nnoremap <Leader>hf :lua require("harpoon.ui").toggle_quick_menu()<CR>
