local nremap = require("jer.keymaps").nremap

-- local dap = require('dap')
-- -- Python
-- require('dap-python').test_runner = 'pytest'
-- require('dap-python').setup('/usr/local/bin/python3')
-- require("dapui").setup()
-- dap.configurations.python = {
--   {
--     type = 'python';
--     request = 'launch';
--     name = "Launch file";
--     program = "${file}";
--     pythonPath = function()
--       local cwd = vim.fn.getcwd()
--       if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
--         return cwd .. '/venv/bin/python'
--       elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
--         return cwd .. '/.venv/bin/python'
--       else
--         return '/usr/bin/python'
--       end
--     end;
--   },
-- }

nremap("<leader>bp", [[oimport pdb; pdb.set_trace()<C-c>]], "Add breakpoint")
