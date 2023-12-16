local keymap = require "jer.keymaps"
local nremap = keymap.nremap
local vremap = keymap.vremap

local chat_folder = vim.env.BASEDIR .. "/chats"

local function split_by_newlines(s)
  local t = {}
  for line in s:gmatch "([^\n]*)\n?" do
    table.insert(t, line)
  end
  return t
end


local _prompts = {
  {
    description = "",
    prompt = "",
  },
  {
    description = "Generic",
    prompt = [[Be concise, with minimal exposition.]],
  },
  {
    description = "Python Code",
    prompt = [[Respond with python code, No explanation or exposition.]],
  },
  {
    description = "Lua/Neovim Code",
    prompt = [[You respond with lua code that can be executed by neovim. No explanation, exposition or comments.]],
  },
  {
    description = "Linux",
    prompt = [[You are a linux expert speaking to someone familiar with linux. Respond concisely with minimal exposition]],
  },
  {
    description = "Sqlite",
    prompt = [[Respond with sql code in the sqlite dialect, No explanation or exposition.]],
  },
  {
    description = "Writing assistant",
    prompt = [[Act as a writing assistant. Given text, you will:

Maintain the structure and sequence of information.

Err on the side of being concise without removing any essential information

Information should be in a clear and fact-based manner ensuring that it's easy to follow along with the information being presented

Tone should be neutral and professional which is appropriate for a speech-language report

Maintain the verbiage - if changes are to be made, they should be recommended in the Recommended Changes section. Refrain from altering the language used directly in the text. All suggested modifications should be included in the Recommended Changes section.]],
  },
}

local function get_prompt_from_description(description)
  for _, prompt in ipairs(_prompts) do
    if prompt.description == description then
      return split_by_newlines(prompt.prompt)
    end
  end
  return { "" }
end

local function get_prompt_from_descriptions()
  local descriptions = {}
  for _, prompt in ipairs(_prompts) do
    table.insert(descriptions, prompt.description)
  end
  return descriptions
end

local function format_filename(file)
  local lowercase = string.lower(file)
  local formatted = string.gsub(lowercase, " ", "_")
  local datetime = os.date "%Y-%m-%dT%H:%M:%S%z"
  local filename = formatted .. "_" .. datetime
  return filename
end

local function concat(arrays)
  local result = {}
  for _, array in ipairs(arrays) do
    for _, element in ipairs(array) do
      table.insert(result, element)
    end
  end
  return result
end

local function create_chat(file, model, prompt_description)
  local has_prompt
  if #prompt_description >= 1 then
    has_prompt = true
    prompt_description = get_prompt_from_description(prompt_description)
  else
    has_prompt = false
    prompt_description = { "" }
  end
  local filename = format_filename(file)
  local cmd = "edit " .. chat_folder .. "/" .. filename .. ".md"
  vim.cmd(cmd)
  local bufnr = vim.api.nvim_get_current_buf()
  local model_lines = { "## Model", "", model, "" }
  local system_lines =
    concat { { "## System", "" }, prompt_description, { "" } }
  local user_lines = { "## User", "", "", "" }
  local lines = concat { model_lines, system_lines, user_lines }
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  local cursor_cmd
  if has_prompt then
    cursor_cmd = ":" .. #lines - 1
  else
    cursor_cmd = ":7"
  end
  vim.cmd(cursor_cmd)
end

local function new_chat()
  vim.ui.input({ prompt = "Name of Chat" }, function(file)
    vim.ui.select(
      { "gpt-3.5-turbo", "gpt-4" },
      { prompt = "Select Model" },
      function(model)
        vim.ui.select(
          get_prompt_from_descriptions(),
          { prompt = "Select Prompt" },
          function(prompt)
            create_chat(file, model, prompt)
          end
        )
      end
    )
  end)
end

local function find_chat()
  require("telescope.builtin").find_files {
    prompt_title = "Open Chat",
    cwd = chat_folder,
  }
end

local function search_chat()
  require("telescope.builtin").live_grep {
    cwd = chat_folder,
  }
end

nremap("<leader>cn", new_chat, "Create a New Chat")
nremap("<leader>cf", find_chat, "Find a Chat")
nremap("<leader>cs", search_chat, "Search Through your Chats")
nremap("<leader>cg", "<CMD>Chat<CR>", "Chat")
