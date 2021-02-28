" need to also install mypy, pyflakes
lua << EOF
require'lspconfig'.pyls.setup{
  enable = true,
  plugins = {
    pyls_mypy = {
      enabled = true,
      live_mode = false
    },
  },
}
EOF

autocmd BufEnter * lua require'completion'.on_attach()
