local M = {}

local function load_local_module()
  local codedir = os.getenv "CODEDIR"
  if not codedir then
    vim.print('CODEDIR env not found!!!')
    return false
  end

  local filepath = codedir .. "/local_nvim/jer_local.lua"
  local module_name = "jer_local"
  local file = io.open(filepath, "r")
  if not file then
    vim.print('local module not found!')
    return false
  end
  file:close()

  local module_dir = codedir .. "/local_nvim/?.lua"
  if not string.find(package.path, module_dir, 1, true) then
    package.path = package.path .. ";" .. module_dir
  end

  local status, module = pcall(require, module_name)
  if not status then
    vim.print('local module unable to be called!')
    return false
  end
  return module
end

M.do_stuff = function()
  local module = load_local_module()
  if module then
    module.do_stuff()
  end
end

M.get_plugins = function()
  local module = load_local_module()
  if module then
    return module.plugins or {}
  end
  return {}
end

return M
