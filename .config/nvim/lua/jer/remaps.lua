----------------- Many Keymaps -----------------
local keymap = require("jer.keymaps")
local nremap = keymap.nremap
local iremap = keymap.iremap

local function find_classes()
  require("telescope.builtin").grep_string {
    prompt_title = "Classes",
    search = "^class ",
    use_regex = true,
    path_display = { "hidden" },
  }
end

-- python --
nremap("<leader>fc", find_classes, "Find Class")
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
nremap("<leader>rw", [[viwp]], "Replace Word")
nremap("<leader>rW", [[viWp]], "Replace Entire Word")
nremap("<leader>rN", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], "Rename All Occurences of Word in File")
nremap("<leader>Sp", [[<CMD>set spell!<CR>]], "Set Spelling")
nremap("<leader>Sc", [[1z=]], "Correct Spelling")
nremap("<leader>cl", [[:set cursorline<CR>]], "Turn on Cursor Line")
nremap("<leader>Cl", [[:set nocursorline<CR>]], "Turn off Cursor Line")
nremap("<leader>o", [[:<C-u>call append(line("."),   repeat([""], v:count1))<CR>]], "Append a Line Below")
nremap("<leader>O", [[:<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>]], "Append a Line Above")

----------------- Insert -----------------
iremap("<Tab>", "")
iremap("<C-o>", "<C-c>o", "New Line Above")
iremap("<C-O>", "<C-c>O", "New Line Below")
