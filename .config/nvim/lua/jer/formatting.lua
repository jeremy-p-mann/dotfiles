local nremap = require("jer.keymaps").nremap

local trim_whitespace = function()
  local patterns = {
    [[%s/\s\+$//e]],
    [[%s/\($\n\s*\)\+\%$//]],
    [[%s/\%^\n\+//]],
    [[%s/\(\n\n\)\n\+/\1/]],
  }
  local save = vim.fn.winsaveview()
  for _, v in pairs(patterns) do
    vim.api.nvim_exec(string.format("silent! %s", v), false)
  end
  vim.fn.winrestview(save)
end

local format = function()
  vim.lsp.buf.format { async = true }
end

nremap("<leader>fm", format, "LSP formatting")
-- nremap("<leader>af", [[gqk]], "Split long line into separate lines")
nremap("<leader>ws", trim_whitespace, "Trim Whitespace")
