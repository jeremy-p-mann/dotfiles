local make_entry = require "telescope.make_entry"
local nremap = require("jer.keymaps").nremap
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

local save_files = function()
  vim.cmd [[wa]]
end
-- Testing --

local is_lua = function()
  local ans = string.find(vim.api.nvim_buf_get_name(0), "lua")
  return ans ~= nil
end

local test_nearest = function()
  save_files()
  if is_lua() then
    require("plenary.test_harness").test_directory(vim.fn.expand "%")
  else
    vim.cmd [[TestNearest]]
  end
end

local test_debug = function()
  save_files()
  if is_lua() then
    require("plenary.test_harness").test_directory('tests/')
  else
    vim.cmd [[TestNearest --pdb]]
  end
end

local test_file = function()
  save_files()
  if is_lua() then
    require("plenary.test_harness").test_directory(vim.fn.expand "%")
  else
    vim.cmd [[TestFile]]
  end
end

local test_suite = function()
  save_files()
  if is_lua() then
    require("plenary.test_harness").test_directory('tests/')
  else
    return vim.cmd [[TestSuite]]
  end
end

local test_last = function()
  save_files()
  if is_lua() then
    require("plenary.test_harness").test_directory('tests/')
  else
    return vim.cmd [[TestLast]]
  end
end

local test_vist = function()
  return vim.cmd [[TestVisit]]
end

local function test_find()
  require("telescope.builtin").grep_string {
    prompt_title = "Tests",
    search = "def test_",
    use_regex = true,
    path_display = "hidden",
  }
end

local function test_module_find()
  require("telescope.builtin").find_files {
    prompt_title = "Test Modules",
    cwd = vim.fn.getcwd() .. "/tests",
  }
end

local function find_fixtures()
  require("telescope.builtin").grep_string {
    prompt_title = "Fixtures",
    search = "fixture",
    use_regex = true,
  }
end

-- Keymaps --

nremap("<leader>tn", test_nearest, "Run Nearest Tests")
nremap("<leader>tf", test_file, "Run Test File")
nremap("<leader>ts", test_suite, "Run Test Suite")
nremap("<leader>tl", test_last, "Run Last Test(s)")
nremap("<leader>td", test_debug, "Run test in debug")
nremap("<leader>tv", test_vist, "Visit Last Test")
nremap("<leader>ft", test_find, "Find Individual Test")
nremap("<leader>fT", test_module_find, "Find Test Module")
nremap("<leader>fx", find_fixtures, "Find Fixture")
