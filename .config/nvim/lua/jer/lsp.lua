--- LSP Related Stuff ---

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach=function()
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
      vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer=0})
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0})
      vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, {buffer=0})
      vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, {buffer=0})
      vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", {buffer=0})
      vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer=0})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {buffer=0})
    end

local opts = {
    capabilities=capabilities,
    on_attach=on_attach,
}

require'lspconfig'.pylsp.setup{opts}

require'lspconfig'.tsserver.setup{opts}

require'lspconfig'.bashls.setup{opts}

require'lspconfig'.rust_analyzer.setup{opts}

-- LUA
-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = '/Users/jeremymann/Documents/code/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  capabilities=capabilities,
  on_attach=on_attach,
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  -- on_attach=require'completion'.on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
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
