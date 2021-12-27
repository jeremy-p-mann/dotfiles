vim.opt.completeopt = { "menu", "menuone", "noselect" }
local lspkind = require "lspkind"
lspkind.init()
local cmp = require'cmp'

cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-s>'] = cmp.mapping.complete({
        config = {sources = {{ name = 'nvim_lsp' }}}
      }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable,
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
    },
    sources ={
      { name = 'ultisnips' },
      { name = 'nvim_lsp' },
      { name = 'path' },
      { name = 'nvim_lua'},
      { name = 'buffer', keyword_length = 4,},
    },
  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = "[buf]",
        nvim_lua = "[api]",
        nvim_lsp = "[LSP]",
        path = "[path]",
        ultisnips= "[snip]",
      },
    },
  },
    experimental = {
      native_menu = false,
  },
  require'cmp'.setup.cmdline('/', {sources = {{ name = 'buffer' }}}),
  require'cmp'.setup.cmdline(':', {sources = {{ name = 'cmdline' }}}),
})
