--- LSP Related Stuff ---

-- This has to before lsp setups
require("neodev").setup {}

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local on_attach = function()
  vim.keymap.set(
    "n",
    "K",
    vim.lsp.buf.hover,
    { buffer = 0, desc = "Hover Documentation" }
  )
  vim.keymap.set(
    "n",
    "gd",
    "<CMD>Telescope lsp_definitions<CR>",
    { buffer = 0, desc = "Telescope Definitions" }
  )
  vim.keymap.set(
    "n",
    "gt",
    vim.lsp.buf.type_definition,
    { buffer = 0, desc = "Go to Type Definition" }
  )
  vim.keymap.set(
    "n",
    "<leader>rf",
    require("telescope.builtin").lsp_references,
    { desc = "Telescope References" }
  )
  vim.keymap.set(
    "n",
    "<leader>rn",
    vim.lsp.buf.rename,
    { buffer = 0, desc = "LSP Rename" }
  )
  vim.keymap.set(
    "n",
    "<leader>ca",
    vim.lsp.buf.code_action,
    { buffer = 0, desc = "LSP Code Actions" }
  )
end

local opts = {
  capabilities = capabilities,
  on_attach = on_attach,
}

local null_ls = require "null-ls"
require("null-ls").setup {
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
    -- null_ls.builtins.diagnostics.write_good,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.pg_format.with {
      extra_args = { "-w", "80" },
    },
  },
}

require("lspconfig").pyright.setup(opts)

require("lspconfig").ansiblels.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

require("lspconfig").dockerls.setup(opts)

require("lspconfig").texlab.setup(opts)

require("lspconfig").gopls.setup(opts)

require("lspconfig").terraformls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "tf" },
}

require("lspconfig").tsserver.setup {
  capabilities = opts.capabilities,
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    on_attach()
  end,
}

require("lspconfig").bashls.setup(opts)

require("lspconfig").rust_analyzer.setup(opts)

require("lspconfig").html.setup {}

require("lspconfig").cssls.setup {}

require("lspconfig").lua_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
      completion = {
        callSnippet = "Replace",
      },
    },
  },
}
