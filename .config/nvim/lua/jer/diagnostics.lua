local nremap = require("jer.keymaps").nremap
local telescope = require "telescope.builtin"

nremap("<leader>ds", [[<cmd>lua vim.diagnostic.show()<cr>]], "Show Diagnostic")
nremap("<leader>dj", vim.diagnostic.goto_next, "Go to Next Diagnostic")
nremap("<leader>dk", vim.diagnostic.goto_prev, "Go to Previous Diagnostic")
nremap("<leader>df", telescope.diagnostics, "Telescope Diagnostics")
