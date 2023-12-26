local M = {}

M.has__local = string.find(
  vim.fn.system "ls $XDG_CONFIG_HOME/nvim/lua/jer",
  "_local.lua"
) ~= nil

M.do_stuff = function()
  local codedir = os.getenv "CODEDIR"
  if codedir then
    local filepath = codedir .. "/local_nvim/jer_local.lua"
    local module_name = "jer_local"
    local file = io.open(filepath, "r")
    if file then
      file:close()
      -- Add the directory to package.path
      local module_dir = codedir .. "/local_nvim/?.lua"
      package.path = package.path .. ";" .. module_dir

      local status, err = pcall(require, module_name)
      if status then
        require(module_name).do_stuff()
      end
    end
  end
end

M.get_plugins = function()
  local codedir = os.getenv "CODEDIR"
  if codedir then
    local filepath = codedir .. "/local_nvim/jer_local.lua"
    local module_name = "jer_local"
    local file = io.open(filepath, "r")
    if file then
      file:close()
      -- Add the directory to package.path
      local module_dir = codedir .. "/local_nvim/?.lua"
      package.path = package.path .. ";" .. module_dir

      local status, err = pcall(require, module_name)
      if status then
        local_plugins = require(module_name).plugins
        return local_plugins
      end
    end
  end
  return {}
end

return M
