
local keymap = vim.api.nvim_set_keymap
local noremap_silent = { noremap = true, silent = true }
local iremap = function(rhs, lhs) keymap('i', rhs, lhs, noremap_silent) end
local nremap = function(rhs, lhs) keymap('n', rhs, lhs, noremap_silent) end
local vremap = function(rhs, lhs) keymap('v', rhs, lhs, noremap_silent) end



----------------- Normal -----------------
vim.g.mapleader = ' '
nremap(' ', '')

-- Navigate quickfix list
nremap('<C-j>', [[<CMD>cnext<CR>]])
nremap('<C-k>', [[<CMD>cprev<CR>]])

-- File Navigation

nremap('<leader>fd', [[<CMD>lua require'jer.telescope'.search_dotfiles()<CR>]])
nremap('<leader>fF',  [[<CMD>lua require'telescope.builtin'.find_files()<cr>]])
nremap('<C-p>',  [[<CMD>lua require'telescope.builtin'.git_files()<cr>]])
nremap('<leader>fs', [[<CMD>lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>]])
nremap('<leader>fg', [[<CMD>lua require('telescope.builtin').live_grep()<CR>]])
nremap('<leader>fv', [[<CMD>lua require('telescope.builtin').treesitter()<CR>]])
nremap('<leader>fb', [[<CMD>lua require('telescope.builtin').buffers()<CR>]])
nremap('<leader>ff', [[<CMD>lua require('jer.telescope').find_in_current_directory()<CR>]])

-- Testing

nremap('<leader>tn', [[<CMD>TestNearest<CR>]])
nremap('<leader>tf', [[<CMD>TestFile<CR>]])
nremap('<leader>ts', [[<CMD>TestSuite<CR>]])
nremap('<leader>tl', [[<CMD>TestLast<CR>]])
nremap('<leader>tv', [[<CMD>TestVisit<CR>]])

-- LSP

nremap('<leader>df', [[<CMD>lua vim.lsp.buf.definition()<CR>]])
nremap('<leader>rn', [[<CMD>lua vim.lsp.buf.rename()<CR>]])
nremap('<leader>ho', [[<CMD>lua vim.lsp.buf.hover()<CR>]])
nremap('<leader>rf', [[<CMD>lua require'telescope.builtin'.lsp_references{}<CR>]])
nremap('<leader>dg', [[<CMD>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>]])

-- Harpoon

nremap('<leader>ht', [[<CMD>require("harpoon.mark").add_file()<CR>]])
nremap('<leader>1', [[<CMD>require("harpoon.ui").nav_file(1)<CR>]])
nremap('<leader>2', [[<CMD>require("harpoon.ui").nav_file(2)<CR>]])
nremap('<leader>3',  [[<CMD>:lua require("harpoon.ui").nav_file(3)<CR>]])
nremap('<leader>hf', [[<CMD>require("harpoon.ui").toggle_quick_menu()<CR>]])

-- Slime

nremap('<leader>sl', [[<CMD>SlimeSendCurrentLine<CR>]])
nremap('<leader>sf', [[<CMD>%SlimeSend<CR>]])
keymap('n', '<leader>sp', '<Plug>SlimeParagraphSend', {})


-- Format
nremap('<leader>fm', [[<CMD>lua vim.lsp.buf.formatting()<CR>]])
nremap('<leader>af', [[gqk]])
-- Help
nremap('<leader>ch', [[<CMD>lua require('telescope.builtin').command_history{}<CR>]])
nremap('<leader>km', [[<CMD>lua require('telescope.builtin').keymaps()<CR>]])
nremap('<leader>hc', [[<CMD>lua require('telescope.builtin').commands()<CR>]])
nremap('<leader>hv', [[<CMD>lua require('telescope.builtin').help_tags()<CR>]])
nremap('<leader>hm', [[<CMD>lua require('telescope.builtin').man_pages()<CR>]])
-- Floating Terminal
vim.g.floaterm_keymap_toggle = '<C-f>'
-- git
nremap('<leader>gb', [[<CMD>GitBlameToggle<CR>]])
nremap('<leader>gs', [[<CMD>lua require('jer.telescope').git_status({})<CR>]])
nremap('<leader>gbr', [[<CMD>lua require('telescope.builtin').git_branches()<CR>]])
nremap('<leader>gc', [[<CMD>lua require('telescope.builtin').git_commits()<CR>]])
nremap('<leader>gh', [[<CMD>lua require('telescope.builtin').git_bcommits()<CR>]])
-- tmux
nremap('<leader>vp', [[<CMD>VimuxPromptCommand<CR>]])
nremap('<leader>vl', [[<CMD>VimuxRunLastCommand<CR>]])
nremap('<leader>vv', [[<CMD>VimuxCloseRunner<CR>]])
nremap('<leader>vc', [[<CMD>VimuxClearTerminalScreen<CR>]])
-- python
nremap('<leader>fT', [[<CMD>lua require('jer.telescope').find_test()<CR>]])
nremap('<leader>fx', [[<CMD>lua require('jer.telescope').find_fixtures()<CR>]])
nremap('<leader>ft', [[<CMD>lua require('jer.telescope').find_test_module({})<CR>]])
nremap('<leader>fc', [[<CMD>lua require('jer.telescope').find_classes()<CR>]])
nremap('<leader>bp', [[oimport pdb; pdb.set_trace()<C-c>]])
nremap('<leader>mh', [[<CMD>w <CR>:VimuxRunCommand("make html")<CR>]])
nremap('<leader>sd', [[<CMD>VimuxRunCommand("open -a 'Brave Browser' build/html/index.html")<CR>]])
nremap('<leader>vi', [[<CMD>VimuxRunCommand("ipython")<CR><CMD>VimuxClearTerminalScreen<CR>]])
-- Notify
nremap('<leader>nn', [[<CMD>lua require('notify')('hi')<CR>]])
nremap('<leader>jo', [[<CMD>lua require('jer.notify').get_joke()<CR>]])
-- Reload Config
nremap('<leader>si', [[<cmd>w<CR><cmd>lua require('plenary.reload').reload_module('jer', true)<CR><cmd>luafile ~/.config/nvim/init.lua<CR><CMD>PackerInstall<CR>]])
-- Misc.
nremap('<leader>rw', [[viwp]])
nremap('<leader>rW', [[viWp]])
nremap('<leader>Sp', [[<CMD>set spell!<CR>]])
nremap('<leader>Sc', [[1z=]])
nremap('<leader>y', [["+y]])
nremap('<leader>Y', [[gg"+yG]])
nremap('<leader>p', [["+p]])
nremap('<leader>P', [["+P]])
nremap('<leader>cl', [[:set cursorline<CR>]])
nremap('<leader>Cl', [[:set nocursorline<CR>]])
nremap('<leader>o', [[:<C-u>call append(line("."),   repeat([""], v:count1))<CR>]])
nremap('<leader>O', [[:<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>]])
-- Silly/Random
nremap('<leader>cc', [[<CMD>lua require('telescope.builtin').colorscheme({use_regex=true})<CR>]])
nremap('<leader>ex', [[<CMD>lua require('jer.float_term').execute_code()<CR>]])


-- calm down

----------------- Insert -----------------
iremap('<Tab>', '')
iremap('<C-o>', '<C-c>o')
iremap('<C-O>', '<C-c>O')

----------------- Visual -----------------
vremap('<leader>y', [["+y]])
