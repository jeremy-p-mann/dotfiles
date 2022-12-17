local notify = require "notify"
local nremap = require("jer.keymaps").nremap
local telescope = require "telescope.builtin"

require("gitsigns").setup {
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
}

local gs = package.loaded.gitsigns
local blame_line = function()
  gs.blame_line { full = true }
end

local function git_status()
  telescope.git_status {
    attach_mappings = function(_, map)
      map("i", "<c-s>", require("telescope.actions").git_staging_toggle)
      return true
    end,
  }
end

nremap("<leader>gs", git_status, "Telescope Git Status")
nremap("<leader>gbr", telescope.git_branches, "Telescope Branches")
nremap("<leader>gc", telescope.git_commits, "Telescope Commits")
nremap("<leader>gh", telescope.git_bcommits, "Telescope Branch Commits")
nremap("<leader>hp", gs.preview_hunk, "Preview Git Hunk")
nremap("<leader>hr", gs.reset_hunk, "Reset Git Hunk")
nremap("<leader>hs", gs.stage_hunk, "Stage Git Hunk")
nremap("<leader>hb", blame_line, "Toggle Full Git Blame Commit")
nremap("<leader>hB", gs.toggle_current_line_blame, "Toggle Git Blame Line")
nremap("<leader>hd", gs.diffthis, "View Git Diff of the File")
nremap("<leader>hk", "<cmd>Gitsigns prev_hunk<CR>", "Go to previous Git Hunk")
nremap("<leader>hj", "<cmd>Gitsigns next_hunk<CR>", "Go to Next Git Hunk")
nremap(
  "<leader>lg",
  [[<CMD> FloatermNew! --height=0.99999 --width=0.99999 lazygit<CR>]],
  "Lazygit"
)

-- local message = vim.ui.input({ prompt = "Commit Message:" }, function(input)
--   local cmd = "touch " .. (input or "")
--   vim.fn.system(cmd)
-- end)
-- vim.wait(1000, function() require'notify'('hi') end)
