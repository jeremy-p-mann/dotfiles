nnoremap <leader>so :w <CR> :so %<CR> :echo "sourced " . expand("%")<CR>

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
nnoremap <silent> <leader>ws :call TrimWhitespace()<CR>

let current_file = expand("%")
" FloatTerm
nnoremap <leader>lg :FloatermNew! --height=0.9 --width=0.9 lazygit<CR>
nnoremap <leader>asc :FloatermNew! --height=0.999 --width=0.999 asciiquarium<CR>
nnoremap <leader>asl :FloatermNew! --height=0.99 --width=0.99 asciiquarium \| lolcat<CR>
nnoremap <leader>dj :FloatermNew! --height=0.99 --width=0.99 dadjoke \| cowsay \| lolcat<CR>

" Completion
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
