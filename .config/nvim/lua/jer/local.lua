local M = {}

M.has__local = string.find(
  vim.fn.system "ls $XDG_CONFIG_HOME/nvim/lua/jer",
  "_local.lua"
) ~= nil
M.do_stuff = function()
  if M.has__local then
    require("jer._local").load_keymaps()
  end
end
M.get_plugins = function()
  if M.has__local then
    return require("jer._local").plugins or {}
  end
  return {}
end

return M
