local actions = require "telescope.actions"
local Job = require "plenary.job"
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

local _async_notify = function(message, level)
  vim.schedule(function()
    vim.notify("Commit successful: " .. message, vim.log.levels.INFO)
  end)
end

local function executeGitCommit(message)
  Job:new({
    command = "git",
    args = { "commit", "-m", message },
    on_exit = function(j, return_val)
      if return_val == 0 then
        _async_notify("Commit successful: " .. message, vim.log.levels.INFO)
      else
        local err = j:stderr_result()
        _async_notify(
          "Commit failed: " .. table.concat(err, "\n"),
          vim.log.levels.ERROR
        )
      end
    end,
  }):start()
end

local function commitWithInput()
  vim.ui.input({ prompt = "Enter commit message: " }, function(input)
    if input and input ~= "" then
      executeGitCommit(input)
    else
      _async_notify("Commit aborted: No message entered.", vim.log.levels.WARN)
    end
  end)
end

local function git_status()
  telescope.git_status {
    attach_mappings = function(_, map)
      map("i", "<c-s>", require("telescope.actions").git_staging_toggle)
      map("i", "<c-m>", function(prompt_bufnr)
        actions.close(prompt_bufnr)
        -- defer else it doesn't enter in insert mode too lazy to figure out why.
        vim.defer_fn(function()
          commitWithInput()
        end, 10)
      end)
      return true
    end,
  }
end

nremap("<leader>gs", git_status, "Telescope Git Status")
nremap("<leader>gbr", telescope.git_branches, "Telescope Branches")
nremap("<leader>gc", telescope.git_commits, "Telescope Commits")
nremap("<leader>gh", telescope.git_bcommits, "Telescope Branch Commits")
nremap("<leader>gm", commitWithInput, "Commit with a Messages")
nremap("<leader>hp", gs.preview_hunk, "Preview Git Hunk")
nremap("<leader>hr", gs.reset_hunk, "Reset Git Hunk")
nremap("<leader>hs", gs.stage_hunk, "Stage Git Hunk")
nremap("<leader>hb", blame_line, "Toggle Full Git Blame Commit")
nremap("<leader>hB", gs.toggle_current_line_blame, "Toggle Git Blame Line")
nremap("<leader>hd", gs.diffthis, "View Git Diff of the File")
nremap("[g", "<cmd>Gitsigns prev_hunk<CR>", "Go to previous Git Hunk")
nremap("]g", "<cmd>Gitsigns next_hunk<CR>", "Go to Next Git Hunk")
