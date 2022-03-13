local nremap = require("jer.keymaps").nremap
local vremap = require("jer.keymaps").vremap

vremap("<leader>y", [["+y]], "Copy to System Register")
nremap("<leader>y", [["+y]], "Yank Motion to System Register")
nremap("<leader>Y", [[gg"+yG]], "Yank File to System Register")
nremap("<leader>p", [["+p]], "Paste From System Register")
nremap("<leader>P", [["+P]], "Paste Above/Before From System Register")
