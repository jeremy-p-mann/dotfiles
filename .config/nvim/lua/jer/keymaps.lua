local M = {}

local keymap = vim.keymap.set

M.iremap = function(rhs, lhs, desc)
  keymap("i", rhs, lhs, { noremap = true, silent = true, desc = desc })
end
M.nremap = function(rhs, lhs, desc)
  keymap("n", rhs, lhs, { noremap = true, silent = true, desc = desc })
end
M.vremap = function(rhs, lhs, desc)
  keymap("v", rhs, lhs, { noremap = true, silent = true, desc = desc })
end
M.tremap = function(rhs, lhs, desc)
  keymap("t", rhs, lhs, { noremap = true, silent = true, desc = desc })
end

return M
