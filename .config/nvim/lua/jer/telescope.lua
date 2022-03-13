local finders = require "telescope.finders"
local utils = require "telescope.utils"
local make_entry = require "telescope.make_entry"
local pickers = require "telescope.pickers"
local conf = require("telescope.config").values

local M = {}
M.search_dotfiles = function()
  require("telescope.builtin").find_files {
    prompt_title = "Dotfiles",
    cwd = "$HOME/.config/",
  }
end

local current_directory = vim.fn.getcwd()
local folder_name_trailing_newling = vim.fn.system "basename $(pwd)"
local folder_name, _ = string.gsub(folder_name_trailing_newling, "\n", "")

function M.find_code()
  require("telescope.builtin").find_files {
    prompt_title = "Tests",
    cwd = current_directory .. "/" .. folder_name,
  }
end

function M.find_in_current_directory()
  require("telescope.builtin").find_files {
    prompt_title = "Files",
    cwd = vim.fn.expand("%"):match ".*/",
  }
end

function M.find_classes()
  require("telescope.builtin").grep_string {
    prompt_title = "Classes",
    search = "^class ",
    use_regex = true,
    path_display = { "hidden" },
  }
end

function M.copy_path_to_clipboard(prompt_bufnr, map)
  local content = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
  vim.fn.system("echo " .. content.value .. " | pbcopy")
  require("telescope.actions").close(prompt_bufnr)
  return true
end

local actions = require "telescope.actions"

return M
