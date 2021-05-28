
" All Things Completion

set completeopt=menuone,noinsert,noselect

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_trigger_keyword_length = 1
let g:completion_trigger_on_delete = 1

let g:completion_chain_complete_list = [
    \{'complete_items': ['lsp', 'snippet', 'buffers']},
    \{'mode': '<c-p>'},
    \{'mode': '<c-n>'}
\]
