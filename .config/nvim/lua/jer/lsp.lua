--- LSP Related Stuff ---

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = function()
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0, desc="Hover Documentation"} )
  vim.keymap.set("n", "gd", "<CMD>Telescope lsp_definitions<CR>", { buffer = 0, desc="Telescope Definitions"})
  vim.keymap.set("n", "gi", "<CMD>Telescope lsp_implementations<CR>", { buffer = 0,  desc="Telescope Implementations"})
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0, desc="Go to Type Definition"})
  vim.keymap.set("n", "<leader>rf", require("telescope.builtin").lsp_references, {desc="Telescope References"})
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = 0, desc="LSP Rename"})
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0, desc="LSP Code Actions"})
end

local opts = {
  capabilities = capabilities,
  on_attach = on_attach,
}

local null_ls = require "null-ls"
require("null-ls").setup {
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.diagnostics.write_good,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.pg_format.with {
      extra_args = {"-w", "80"},
    },
  },
}
require("lspconfig").pylsp.setup(opts)

require'lspconfig'.texlab.setup(opts)

require("lspconfig").tsserver.setup(opts)

require("lspconfig").bashls.setup(opts)

require("lspconfig").rust_analyzer.setup(opts)

-- LUA
-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
local system_name
if vim.fn.has "mac" == 1 then
  system_name = "macOS"
elseif vim.fn.has "unix" == 1 then
  system_name = "Linux"
elseif vim.fn.has "win32" == 1 then
  system_name = "Windows"
else
  print "Unsupported system for sumneko"
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = "/Users/jeremymann/Documents/code/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require("lspconfig").sumneko_lua.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
  -- on_attach=require'completion'.on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path,
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
    },
  },
}
