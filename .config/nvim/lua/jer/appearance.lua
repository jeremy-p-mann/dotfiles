vim.api.nvim_exec2(
  [[highlight ColorColumn ctermbg=0 guibg=lightgrey
colorscheme carbonfox
]],
{}
)

local keymap = require "jer.keymaps"
local nremap = keymap.nremap
local colorscheme = require("telescope.builtin").colorscheme

nremap("<leader>cl", [[:set cursorline<CR>]], "Turn on Cursor Line")
nremap("<leader>Cl", [[:set nocursorline<CR>]], "Turn off Cursor Line")
nremap("<leader>cc", colorscheme, "Telescope to Change Colorscheme")
