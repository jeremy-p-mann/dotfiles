local M = {}


M.chill = function ()
    vim.diagnostic.hide()
end

M.unchill = function ()
    vim.diagnostic.show()
end

return M
