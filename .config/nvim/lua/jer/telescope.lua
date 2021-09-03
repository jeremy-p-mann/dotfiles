
local M = {}
M.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "Dotfiles",
        cwd = "$HOME/.config/"
    })
end

local current_directory = vim.fn.getcwd()
local tests_folder = current_directory .. "/tests/"

function M.find_tests ()
    require("telescope.builtin").find_files({
        prompt_title = "Tests",
        cwd = tests_folder
    })
end

function M.find_in_current_directory ()
    require("telescope.builtin").find_files({
        prompt_title = "Files",
        cwd = vim.fn.expand('%'):match('.*/')
    })
end

function M.find_classes ()
    require("telescope.builtin").grep_string({
        prompt_title = "Classes",
        search='^class ',
        use_regex=true
    })
end

function M.find_individual_test ()
    require("telescope.builtin").grep_string({
        prompt_title = "Tests",
        search='def test_',
        use_regex=true
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

return M

