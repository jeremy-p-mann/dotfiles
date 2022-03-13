local nremap = require("jer.keymaps").nremap
vim.g.floaterm_keymap_toggle = "<C-f>"

-- Floating Terminal
nremap("<leader>ex", require("jer.float_term").execute_code, "Execute Code in Floating Window")
nremap("<leader>vp", [[<CMD>VimuxPromptCommand<CR>]], "Run Command From Prompt in Tmux")
nremap("<leader>vl", [[<CMD>VimuxRunLastCommand<CR>]], "Run Last command in Tmux")
nremap("<leader>vv", [[<CMD>VimuxCloseRunner<CR>]], "Close Tmux window")
nremap("<leader>vc", [[<CMD>VimuxClearTerminalScreen<CR>]], "Clear Tmux Screen")
nremap("<leader>sl", [[<CMD>SlimeSendCurrentLine<CR>]], "Send Current Line")
nremap("<leader>sf", [[<CMD>%SlimeSend<CR>]], "Send The File")
nremap("<leader>sp", "<Plug>SlimeParagraphSend", "Send the Paragraph")
