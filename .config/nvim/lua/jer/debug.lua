local dap = require('dap')
require('dap-python').test_runner = 'pytest'
require('dap-python').setup('/usr/local/bin/python3')
require("dapui").setup()
dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = "Launch file";
    program = "${file}";
    pythonPath = function()
      return '/usr/bin/python'
    end;
  },
}
