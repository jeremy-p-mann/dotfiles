local keymap = require("jer.keymaps")
local nremap = keymap.nremap
local iremap = keymap.iremap

nremap(
  "<leader>rl",
  [[<cmd>w<CR><cmd>lua require('plenary.reload').reload_module('jer', true)<CR><cmd>luafile ~/.config/nvim/init.lua<CR><CMD>PackerInstall<CR>]],
  "Reload Entire Config"
)
nremap("<leader>wr", "<cmd>wa<cr>", "Save all files")
nremap("<leader>rw", [[viwp]], "Replace Word")
nremap("<leader>rW", [[viWp]], "Replace Entire Word")
nremap("<leader>rN", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], "Rename All Occurences of Word in File")
nremap("<leader>Sp", [[<CMD>set spell!<CR>]], "Set Spelling")
nremap("<leader>Sc", [[1z=]], "Correct Spelling")
nremap("<leader>o", [[:<C-u>call append(line("."),   repeat([""], v:count1))<CR>]], "Append a Line Below")
nremap("<leader>O", [[:<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>]], "Append a Line Above")
iremap("<Tab>", "")
iremap("<C-o>", "<C-c>o", "New Line Above")
iremap("<C-O>", "<C-c>O", "New Line Below")
