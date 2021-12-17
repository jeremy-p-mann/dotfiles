print('hi')
local M = {}
M.execute_code = function()
    local current_file = vim.fn.expand('%')
    local filetype = vim.bo.filetype
    if filetype == 'python'
    then
        local command = "FloatermNew! --height=0.9 --width=0.9 python3 " .. current_file
        vim.cmd(command)
    elseif filetype == 'lua' then
        local command = "FloatermNew! --height=0.9 --width=0.9 lua " .. current_file
        vim.cmd(command)
    end
end

return M

