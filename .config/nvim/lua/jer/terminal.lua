local nremap = require("jer.keymaps").nremap

vim.g.floaterm_keymap_toggle = "<C-f>"
vim.g.slime_default_config = {
  ["socket_name"] = "default",
  ["target_pane"] = "1",
}
vim.g.slime_paste_file = vim.fn.tempname()
vim.g.slime_target = "tmux"
vim.g.slime_dont_ask_default = 1

local execute_code = function()
  local current_file = vim.fn.expand "%"
  local filetype = vim.bo.filetype
  if filetype == "python" then
    local command = "FloatermNew! --height=0.99 --width=0.99 python3 " .. current_file
    vim.cmd(command)
  elseif filetype == "lua" then
    vim.cmd("luafile %")
  end
end

nremap("<leader>ex", execute_code, "Execute Code in Floating Window")
nremap("<leader>vp", [[<CMD>VimuxPromptCommand<CR>]], "Run Command From Prompt in Tmux")
nremap("<leader>vl", [[<CMD>VimuxRunLastCommand<CR>]], "Run Last command in Tmux")
nremap("<leader>vv", [[<CMD>VimuxCloseRunner<CR>]], "Close Tmux window")
nremap("<leader>vc", [[<CMD>VimuxClearTerminalScreen<CR>]], "Clear Tmux Screen")
nremap("<leader>sl", [[<CMD>SlimeSendCurrentLine<CR>]], "Send Current Line")
nremap("<leader>sf", [[<CMD>%SlimeSend<CR>]], "Send The File")
nremap("<leader>sp", "<Plug>SlimeParagraphSend", "Send the Paragraph")
