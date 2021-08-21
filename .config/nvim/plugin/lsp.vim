", need to also install mypy, pyflakes
lua << EOF
-- pip install 'python-lsp-server[all]'
require'lspconfig'.pylsp.setup{}
EOF


lua << EOF
-- npm install -g vscode-json-languageserver
require'lspconfig'.jsonls.setup {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
        end
      }
    }
}
EOF

" npm i -g bash-language-server
lua require'lspconfig'.bashls.setup{}

autocmd BufEnter * lua require'completion'.on_attach()
