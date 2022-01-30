local api = vim.api
local patterns = {
  [[%s/\s\+$//e]],
  [[%s/\($\n\s*\)\+\%$//]],
  [[%s/\%^\n\+//]],
  [[%s/\(\n\n\)\n\+/\1/]],
}
local M = {}

M.trim_whitespace = function()
  local save = vim.fn.winsaveview()
  for _, v in pairs(patterns) do
    api.nvim_exec(string.format("silent! %s", v), false)
  end
  vim.fn.winrestview(save)
end

return M
