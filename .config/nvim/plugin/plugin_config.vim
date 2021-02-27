" Jeremy's NeoVim Plugin Configurations

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
let g:ale_linters = {
            \ 'python': ['flake8', 'mypy'],
            \ 'rst': ['rstcheck'], 
            \ 'markdown': ['markdownlint'],
            \ }

" fzf
" open files in a separate window
let g:fzf_action = {
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" vim-test
let test#strategy = 'vimux'

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_insertion = 1

" LSP stuff


" Completions

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_trigger_keyword_length = 2

" TreeSitter 
" Syntax Highlighting 
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = { enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
  },
}
EOF
