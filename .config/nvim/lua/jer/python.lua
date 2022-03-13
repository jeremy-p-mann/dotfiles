local keymap = require("jer.keymaps")
local nremap = keymap.nremap

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
