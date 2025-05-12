vim.api.nvim_exec2(
  [[highlight ColorColumn ctermbg=0 guibg=lightgrey
colorscheme carbonfox
]],
{}
)

local keymap = require "jer.keymaps"
local nremap = keymap.nremap
local colorscheme = require("telescope.builtin").colorscheme

require("dressing").setup {
  input = { relative = "editor", min_width = {10, .9}},
}


local chill = function()
  vim.diagnostic.hide()
end

local unchill = function()
  vim.diagnostic.show()
end

nremap("<leader>co", chill, "Chill Out")
nremap("<leader>uc", unchill, "Unchill Out")
nremap("<leader>cl", [[:set cursorline<CR>]], "Turn on Cursor Line")
nremap("<leader>Cl", [[:set nocursorline<CR>]], "Turn off Cursor Line")
nremap("<leader>cc", colorscheme, "Telescope to Change Colorscheme")
