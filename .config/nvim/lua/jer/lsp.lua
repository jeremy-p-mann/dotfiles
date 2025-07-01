--- LSP Related Stuff ---

local capabilities = require("blink.cmp").get_lsp_capabilities()

local on_attach = function()
  vim.keymap.set(
    "n",
    "K",
    vim.lsp.buf.hover,
    { buffer = 0, desc = "Hover Documentation" }
  )
  vim.keymap.set(
    "n",
    "grd",
    require("telescope.builtin").lsp_definitions,
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
    "grr",
    require("telescope.builtin").lsp_references,
    { desc = "Telescope References" }
  )
  vim.keymap.set(
    "n",
    "grn",
    vim.lsp.buf.rename,
    { buffer = 0, desc = "LSP Rename" }
  )
  vim.keymap.set(
    "n",
    "gra",
    vim.lsp.buf.code_action,
    { buffer = 0, desc = "LSP Code Actions" }
  )
  vim.keymap.set(
    "n",
    "grt",
    require("telescope.builtin").lsp_type_definitions,
    { buffer = 0, desc = "Go to Type Definition" }
  )
end

local opts = {
  capabilities = capabilities,
  on_attach = on_attach,
}

local util = require "lspconfig/util"

local path = util.path

local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end

  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs { "*", ".*" } do
    local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
    if match ~= "" then
      return path.join(vim.fs.dirname(match), "bin", "python")
    end
  end

  return vim.fn.exepath "python3" or vim.fn.exepath "python" or "python"
end

local pyright_opts = opts
pyright_opts.before_init = function(_, config)
  local python_settings = config.settings.python
  if python_settings then
    python_settings.pythonPath = get_python_path(config.root_dir)
  end
end

require("lspconfig").pyright.setup(pyright_opts)

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
}

require("lspconfig").ts_ls.setup {
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
