local keymap = require("jer.keymaps")
local nremap = keymap.nremap

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local action_state = require "telescope.actions.state"
local action = require "telescope.actions"

local _get_tmux_sessions = function()
  return vim.fn.systemlist "tmux list-sessions -F '#{session_name}'"
end

local _get_current_tmux_session = function()
  return vim.fn.systemlist("tmux display-message -p '#S'")[1]
end

local _switch_tmux_sessions = function(session_name)
  vim.fn.system("tmux switch -t " .. session_name)
end

local _remove_value = function(list, value_to_replace)
  local new_list = {}
  local index = 1
  for _, val in pairs(list) do
    if val ~= value_to_replace then
      new_list[index] = val
      index = index + 1
    end
  end
  return new_list
end

local _get_unattached_tmux_sessions = function()
  local sessions = _get_tmux_sessions()
  local current_session = _get_current_tmux_session()
  return _remove_value(sessions, current_session)
end

local _switch_tmux_sessions_action = function(prompt_bufnr)
  local session_name = action_state.get_selected_entry().value
  action.close(prompt_bufnr)
  _switch_tmux_sessions(session_name)
  return true
end

local tmux_sessions = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "select a tmux session",
    finder = finders.new_table {
      results = _get_unattached_tmux_sessions(),
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry,
          ordinal = entry:upper(),
        }
      end,
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(_, map)
      map("i", "<CR>", _switch_tmux_sessions_action)
      map("n", "<CR>", _switch_tmux_sessions_action)
      return true
    end,
  }):find()
end

local tmux_session_dropdown = function ()
    tmux_sessions(require('telescope.themes').get_dropdown({}))
end

nremap("<leader>fp", tmux_session_dropdown, "Navigate to new tmux session")
