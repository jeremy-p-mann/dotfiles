local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local pickers = require "telescope.pickers"
local conf = require("telescope.config").values

local M = {}
M.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "Dotfiles",
        cwd = "$HOME/.config/"
    })
end

local current_directory = vim.fn.getcwd()
local folder_name_trailing_newling = vim.fn.system('basename $(pwd)')
local folder_name, _ = string.gsub(folder_name_trailing_newling, "\n", "")

function M.find_code ()
    require("telescope.builtin").find_files({
        prompt_title = "Tests",
        cwd = current_directory .. "/" .. folder_name
    })
end

M.find_test_module = function(opts)
  -- By creating the entry maker after the cwd options,
  -- we ensure the maker uses the cwd options when being created.
  opts.entry_maker = opts.entry_maker or make_entry.gen_from_file(opts)
  opts.path_display = {"tail"}

  pickers.new(opts, {
    prompt_title = "Test",
    finder = finders.new_oneshot_job(
      vim.tbl_flatten { "find", ".", "-name", "*test_*.py" },
      opts
    ),
    previewer = conf.file_previewer(opts),
  }):find()
end

function M.find_in_current_directory ()
    require("telescope.builtin").find_files({
        prompt_title = "Files",
        cwd = vim.fn.expand('%'):match('.*/'),
    })
end

function M.find_classes ()
    require("telescope.builtin").grep_string({
        prompt_title = "Classes",
        search='^class ',
        use_regex=true,
        path_display = {"hidden"},
    })
end

function M.find_test ()
    require("telescope.builtin").grep_string({
        prompt_title = "Tests",
        search='^def test_',
        use_regex=true,
        path_display = {"hidden"},
    })
end

function M.find_fixtures ()
    require("telescope.builtin").grep_string({
        prompt_title = "Fixtures",
        search='fixture',
        use_regex=true
    })
end

function M.copy_path_to_clipboard(prompt_bufnr, map)
    local content = require('telescope.actions.state').get_selected_entry(prompt_bufnr)
    vim.fn.system('echo ' .. content.value .. ' | pbcopy')
    require('telescope.actions').close(prompt_bufnr)
    return true
end

local actions = require('telescope.actions')

function M.git_status ()
    require("telescope.builtin").git_status({
        attach_mappings = function(_, map)
            map('i', '<c-s>', actions.git_staging_toggle)
            return true
        end
    })
end

return M

