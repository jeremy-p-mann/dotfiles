local keymap = require "jer.keymaps"
local nremap = keymap.nremap
local telescope = require "telescope.builtin"
local action_state = require("telescope.actions.state")
local entry_display = require("telescope.pickers.entry_display")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values
local harpoon = require("harpoon")
local harpoon_mark = require("harpoon.mark")

-- Harpoon
local function filter_empty_string(list)
    local next = {}
    for idx = 1, #list do
        if list[idx].filename ~= "" then
            table.insert(next, list[idx])
        end
    end
    return next
end
local generate_new_finder = function()
    return finders.new_table({
        results = filter_empty_string(harpoon.get_mark_config().marks),
        entry_maker = function(entry)
            local line = entry.filename .. ":" .. entry.row .. ":" .. entry.col
            local displayer = entry_display.create({
                separator = " - ",
                items = {
                    { width = 2 },
                    { width = 50 },
                    { remaining = true },
                },
            })
            local make_display = function(entry)
                return displayer({
                    tostring(entry.index),
                    line,
                })
            end
            local line = entry.filename .. ":" .. entry.row .. ":" .. entry.col
            return {
                value = entry,
                ordinal = line,
                display = make_display,
                lnum = entry.row,
                col = entry.col,
                filename = entry.filename,
            }
        end,
    })
end

local delete_harpoon_mark = function(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    harpoon_mark.rm_file(selection.filename)
    local current_picker = action_state.get_current_picker(prompt_bufnr)
    current_picker:refresh(generate_new_finder(), { reset_prompt = true })
end

local telescope_harpoon = function(opts)
    opts = opts or {}
    pickers.new(opts, {
        prompt_title = "harpoon marks",
        finder = generate_new_finder(),
        sorter = conf.generic_sorter(opts),
        previewer = conf.grep_previewer(opts),
        attach_mappings = function(_, map)
            map("i", "<c-d>", delete_harpoon_mark)
            map("n", "<c-d>", delete_harpoon_mark)
            return true
        end,
    }):find()
end

local find_in_current_directory = function()
  require("telescope.builtin").find_files {
    prompt_title = "Files",
    cwd = vim.fn.expand("%"):match ".*/",
  }
end
local search_dotfiles = function()
  require("telescope.builtin").find_files {
    prompt_title = "Dotfiles",
    cwd = "$HOME/.config/",
  }
end
local grep_string = function()
  telescope.grep_string { search = vim.fn.input "Grep For > " }
end

-- Quickfix
nremap("<C-j>", [[<CMD>cnext<CR>]], "Quickfix Next")
nremap("<C-k>", [[<CMD>cprev<CR>]], "Quickfix Previous")
-- General Finding
nremap("<leader>fd", search_dotfiles, "Telescope Dotfiles")
nremap("<leader>fF", telescope.find_files, "Telescope all Files")
nremap("<C-p>", telescope.git_files, "Telescope Git Files")
nremap("<leader>fs", grep_string, "Grep For String")
nremap("<leader>fg", telescope.live_grep, "Telescope Live Grep")
nremap("<leader>fv", telescope.treesitter, "Treesitter Entities")
nremap("<leader>fb", telescope.buffers, "Telescope Buffers")
nremap("<leader>ff", find_in_current_directory, "Telescope Current Directory")

-- Marks
nremap("<leader>mt", require("harpoon.mark").add_file, "Add a Mark")
nremap("<leader>mj", require("harpoon.ui").nav_next, "Next Mark")
nremap("<leader>mk", require("harpoon.ui").nav_prev, "Previous Mark")
nremap("<leader>1", function()
  require("harpoon.ui").nav_file(1)
end, "First Mark")
nremap("<leader>2", function()
  require("harpoon.ui").nav_file(2)
end, "Second Mark")
nremap("<leader>3", function()
  require("harpoon.ui").nav_file(3)
end, "Third Mark")
nremap("<leader>mf", telescope_harpoon, "Find Mark")
