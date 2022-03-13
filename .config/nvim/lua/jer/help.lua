-- Get help
local nremap = require("jer.keymaps").nremap
local telescope = require "telescope.builtin"

nremap("<leader>ch", telescope.command_history, "Telescope Command History")
nremap("<leader>km", telescope.keymaps, "Telescope Keymaps")
nremap("<leader>hc", telescope.commands, "Telescope Commands")
nremap("<leader>hv", telescope.help_tags, "Telescope Vim Help")
