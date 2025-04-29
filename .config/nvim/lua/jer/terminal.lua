local nremap = require("jer.keymaps").nremap
local tremap = require("jer.keymaps").tremap
local execute_sql = require("jer.sql").execute_sql_query_from_file
local async = require "plenary.async"
local notify = require("notify").async

-- vim.g.floaterm_keymap_toggle = "<C-f>"
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
  vim.cmd "wa"
  if filetype == "python" then
    local files_in_current_directory = vim.fn.system "ls"
    local package_manager_command = ""
    if string.find(files_in_current_directory, "Pipfile.lock") then
      package_manager_command = "pipenv run "
    end
    if string.find(files_in_current_directory, "poetry.lock") then
      package_manager_command = "poetry run "
    end
    local shell_command = package_manager_command .. "python3 " .. current_file
    local command = 'VimuxRunCommand("' .. shell_command .. '")'
    vim.cmd(command)
  elseif filetype == "go" then
    local shell_command = "go run " .. current_file
    local command = 'VimuxRunCommand("' .. shell_command .. '")'
    vim.cmd(command)
  elseif filetype == "rust" then
    local shell_command = "cargo run " .. current_file
    local command = 'VimuxRunCommand("' .. shell_command .. '")'
    vim.cmd(command)
  elseif filetype == "sql" then
    execute_sql()
  elseif filetype == "lua" then
    vim.cmd "luafile %"
  end
end

local command_prompt = function()
  local on_confirm = function(input)
    if input then
      local output = vim.fn.system(input)
      require "notify"(output, "> ", { title = input })
    end
  end
  vim.ui.input({ prompt = "Command" }, on_confirm)
end

local function _get_week_day()
  local day_number = os.date("*t").wday
  local week_days = {
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  }
  return week_days[day_number]
end

local get_cal = function(n_months)
  n_months = n_months or 0
  local cmd = "cal -h"
  if n_months >= 1 then
    cmd = cmd .. " -A" .. n_months
  end

  async.run(function()
    local joke = vim.fn.system(cmd)
    notify(joke, "", { title = _get_week_day() .. " " .. os.date "%d" })
  end)
end

nremap("<leader><leader>x", command_prompt, "command")
nremap("<leader><leader>c", function()
  get_cal(nil)
end, "Get this month")
nremap("<leader>c1", function()
  get_cal(1)
end, "Get this month")
nremap("<leader>c2", function()
  get_cal(2)
end, "Get this month")

nremap("<leader>ex", execute_code, "Execute Code in Floating Window")
nremap(
  "<leader>vp",
  [[<CMD>VimuxPromptCommand<CR>]],
  "Run Command From Prompt in Tmux"
)
nremap(
  "<leader>vl",
  [[<CMD>VimuxRunLastCommand<CR>]],
  "Run Last command in Tmux"
)
nremap("<leader>vv", [[<CMD>VimuxCloseRunner<CR>]], "Close Tmux window")
nremap("<leader>vc", [[<CMD>VimuxClearTerminalScreen<CR>]], "Clear Tmux Screen")
nremap("<leader>sl", [[<CMD>SlimeSendCurrentLine<CR>]], "Send Current Line")
nremap("<leader>sf", [[<CMD>%SlimeSend<CR>]], "Send The File")
tremap("<ESC>", [[<C-\><C-n>]], "Escape in terminal mode")
