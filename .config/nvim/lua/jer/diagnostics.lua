local nremap = require("jer.keymaps").nremap
local telescope = require "telescope.builtin"

nremap("<leader>ds", vim.diagnostic.open_float, "Show Diagnostic")
nremap("]d", vim.diagnostic.goto_next, "Go to Next Diagnostic")
nremap("[d", vim.diagnostic.goto_prev, "Go to Previous Diagnostic")
nremap("<leader>df", telescope.diagnostics, "Telescope Diagnostics")
