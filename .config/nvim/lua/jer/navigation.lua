local keymap = require "jer.keymaps"
local nremap = keymap.nremap
local telescope = require "telescope.builtin"
local action_state = require "telescope.actions.state"
local entry_display = require "telescope.pickers.entry_display"
local finders = require "telescope.finders"
local pickers = require "telescope.pickers"
local builtin = require "telescope.builtin"
local conf = require("telescope.config").values
local harpoon = require "harpoon"
local harpoon_mark = require "harpoon.mark"
local actions = require "telescope.actions"

local function copy_path_to_clipboard(prompt_bufnr, map)
  local content = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
  vim.fn.system("echo " .. content.value .. " | pbcopy")
  require("telescope.actions").close(prompt_bufnr)
  return true
end

require("telescope").setup {
  defaults = {
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    prompt_prefix = "> ",
    layout_strategy = "horizontal",
    color_devicons = true,
    path_display = { shorten = 2 },
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    sorting_strategy = "ascending",
    layout_config = {
      width = 0.95,
      height = 0.9,
      prompt_position = "top",
      horizontal = {
        width_padding = 0.001,
        height_padding = 0.01,
        preview_width = 0.6,
      },
      vertical = {
        width_padding = 0.05,
        height_padding = 1,
        preview_height = 0.5,
      },
    },
    mappings = {
      i = {
        ["<C-x>"] = false,
        ["<C-q>"] = actions.send_to_qflist,
        ["<C-y>"] = copy_path_to_clipboard,
        ["<C-h>"] = require("telescope").extensions.send_to_harpoon.actions.send_selected_to_harpoon,
        ["<C-c>"] = actions.close,
      },
      n = {
        ["<C-q>"] = actions.send_to_qflist,
        ["<C-y>"] = copy_path_to_clipboard,
        ["<C-h>"] = require("telescope").extensions.send_to_harpoon.actions.send_selected_to_harpoon,
        ["<C-c>"] = actions.close,
      },
    },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      },
    },
  },
}
require("telescope").load_extension "fzy_native"
require("telescope").load_extension "send_to_harpoon"
require("telescope").load_extension "ui-select"

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
  return finders.new_table {
    results = filter_empty_string(harpoon.get_mark_config().marks),
    entry_maker = function(entry)
      local line = entry.filename .. ":" .. entry.row .. ":" .. entry.col
      local displayer = entry_display.create {
        separator = " - ",
        items = {
          { width = 2 },
          { width = 50 },
          { remaining = true },
        },
      }
      local make_display = function(entry)
        return displayer {
          tostring(entry.index),
          line,
        }
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
  }
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
nremap("<leader>tt", builtin.builtin, "Telescope Telescope")
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


