local actions = require('telescope.actions')

local M = {}
M.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "Dotfiles",
        cwd = "$HOME/.config/"
    })
end

current_directory = vim.fn.getcwd()
tests_folder = current_directory .. "/tests/"

function M.find_tests ()
    require("telescope.builtin").find_files({
        prompt_title = "Tests",
        cwd = tests_folder
    })
end
 

return M


