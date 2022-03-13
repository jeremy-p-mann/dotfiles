----------------- Many Keymaps -----------------
local keymap = vim.keymap.set
local iremap = function(rhs, lhs, desc)
  keymap("i", rhs, lhs, { noremap = true, silent = true, desc = desc })
end
local nremap = function(rhs, lhs, desc)
  keymap("n", rhs, lhs, { noremap = true, silent = true, desc = desc })
end
local vremap = function(rhs, lhs, desc)
  keymap("v", rhs, lhs, { noremap = true, silent = true, desc = desc })
end
----------------- Normal -----------------
vim.g.mapleader = " "
nremap(" ", "")
-- Navigate quickfix list
nremap("<C-j>", [[<CMD>cnext<CR>]], "Quickfix Next")
nremap("<C-k>", [[<CMD>cprev<CR>]], "Quickfix Previous")
-- File Navigation --
local telescope = require "telescope.builtin"
nremap("<leader>fd", require("jer.telescope").search_dotfiles, "Telescope Dotfiles")
nremap("<leader>fF", telescope.find_files, "Telescope all Files")
nremap("<C-p>", telescope.git_files, "Telescope Git Files")
nremap("<leader>fs", function()
  telescope.grep_string { search = vim.fn.input "Grep For > " }
end, "Grep For String")
nremap("<leader>fg", telescope.live_grep, "Telescope Live Grep")
nremap("<leader>fv", telescope.treesitter, "Treesitter Entities")
nremap("<leader>fb", telescope.buffers, "Telescope Buffers")
nremap("<leader>ff", require("jer.telescope").find_in_current_directory, "Telescope Current Directory")
-- Harpoon --
nremap("<leader>mt", require("harpoon.mark").add_file)
nremap("<leader>mj", require("harpoon.ui").nav_next)
nremap("<leader>mk", require("harpoon.ui").nav_prev)
nremap("<leader>1", function()
  require("harpoon.ui").nav_file(1)
end)
nremap("<leader>2", function()
  require("harpoon.ui").nav_file(2)
end)
nremap("<leader>3", function()
  require("harpoon.ui").nav_file(3)
end)
nremap("<leader>mf", require("jer.harpoon").telescope_harpoon)

-- python --
nremap("<leader>fc", require("jer.telescope").find_classes, "Find Class")
nremap("<leader>mh", [[<CMD>w <CR>:VimuxRunCommand("make html")<CR>]])
nremap("<leader>sd", [[<CMD>VimuxRunCommand("open -a 'Brave Browser' build/html/index.html")<CR>]])
nremap("<leader>vi", [[<CMD>VimuxRunCommand("ipython")<CR><CMD>VimuxClearTerminalScreen<CR>]], "Open ipython in tmux")
-- Reload Config --
nremap(
  "<leader>rl",
  [[<cmd>w<CR><cmd>lua require('plenary.reload').reload_module('jer', true)<CR><cmd>luafile ~/.config/nvim/init.lua<CR><CMD>PackerInstall<CR>]],
  "Reload Entire Config"
)
-- Misc --
nremap("<leader>wr", "<cmd>wa<cr>", "Save all files")
nremap("<leader>co", require("jer.chill").chill, "Chill out")
nremap("<leader>uc", require("jer.chill").unchill, "UnChill")
nremap("<leader>rw", [[viwp]], "Replace Word")
nremap("<leader>rW", [[viWp]], "Replace Entire Word")
nremap("<leader>rN", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], "Rename All Occurences of Word in File")
nremap("<leader>Sp", [[<CMD>set spell!<CR>]], "Set Spelling")
nremap("<leader>Sc", [[1z=]], "Correct Spelling")
nremap("<leader>y", [["+y]], "Yank Motion to System Register")
nremap("<leader>Y", [[gg"+yG]], "Yank File to System Register")
nremap("<leader>p", [["+p]], "Paste From System Register")
nremap("<leader>P", [["+P]], "Paste Above/Before From System Register")
nremap("<leader>cl", [[:set cursorline<CR>]], "Turn on Cursor Line")
nremap("<leader>Cl", [[:set nocursorline<CR>]], "Turn off Cursor Line")
nremap("<leader>o", [[:<C-u>call append(line("."),   repeat([""], v:count1))<CR>]], "Append a Line Below")

nremap("<leader>O", [[:<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>]], "Append a Line Above")

----------------- Insert -----------------
iremap("<Tab>", "")
iremap("<C-o>", "<C-c>o", "New Line Above")
iremap("<C-O>", "<C-c>O", "New Line Below")

local ls = require "luasnip"
vim.keymap.set({ "i", "s" }, "<c-l>", function()
  if require("luasnip").expand_or_jumpable() then
    require("luasnip").expand_or_jump()
  end
end, { desc = "Expand or Jump Snippet" })

-- <c-j> is my jump backwards key.
-- this always moves to the previous item within the snippet
vim.keymap.set({ "i", "s" }, "<c-h>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true, desc = "Go to Previous Item in Snipppet" })

----------------- Visual -----------------
vremap("<leader>y", [["+y]], "Copy to System Register")
