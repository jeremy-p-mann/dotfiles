local ts_query = require "vim.treesitter.query"
local vim_ts = require "vim.treesitter"

local function format_function_signature(functions)
  local signatures = {}
  for _, func in ipairs(functions) do
    table.insert(
      signatures,
      string.format(
        "%s(%s)",
        func["function_name"],
        table.concat(func["params"], ", ")
      )
    )
  end
  return signatures
end

local function extract_functions_and_params(bufnr)
  local parser = vim_ts.get_parser(bufnr, "lua")
  local root_tree = parser:parse()[1]:root()

  local function_query = [[
    ((function_declaration name: (identifier) @function_name parameters: (parameters (identifier) @parameter)) @function)
  ]]

  local query = ts_query.parse("lua", function_query)
  local functions = {}

  for pattern, match, metadata in query:iter_matches(root_tree, bufnr) do
    local func = { ["params"] = {}, ["line_number"] = nil } -- Added line_number
    for id, node in pairs(match) do
      local name = query.captures[id]
      if name == "function_name" then
        func["function_name"] = vim_ts.get_node_text(node, bufnr)
        local start_line = select(1, node:start()) -- Get the starting line number
        func["line_number"] = start_line + 1 -- Lua is 1-indexed, Treesitter is 0-indexed
      elseif name == "parameter" then
        table.insert(func["params"], vim_ts.get_node_text(node, bufnr))
      end
    end
    if func["function_name"] then
      table.insert(functions, func)
    end
  end

  return functions
end

local function extract_imports_with_line_numbers(bufnr)
  local parser = vim_ts.get_parser(bufnr, "lua")
  local root_tree = parser:parse()[1]:root()
  local import_query = [[
    (function_call arguments: (arguments (string) @import_path))
  ]]
  local query = ts_query.parse("lua", import_query)
  local imports = {}
  for _, match in query:iter_matches(root_tree, bufnr) do
    for id, node in pairs(match) do
      local capture_name = query.captures[id]
      if capture_name == "import_path" then
        local parent = node:parent():parent() -- (function_call -> arguments -> string)
        if parent:type() == "function_call" then
          local func_node = parent:child(0)
          if
            func_node and vim_ts.get_node_text(func_node, bufnr) == "require"
          then
            local text = vim_ts.get_node_text(node, bufnr)
            local stripped_text = text:match "^[\"'](.*)[\"']$"

            local start_line, _ = node:start()
            table.insert(
              imports,
              { text = stripped_text, line = start_line + 1 }
            )
          end
        end
      end
    end
  end
  return imports
end

local function get_file_summary()
  local buf =vim.api.nvim_get_current_buf() 
  local imports = extract_imports_with_line_numbers(buf)
  lines = {}
  for _, import in ipairs(imports) do
    table.insert(lines, string.format("Line %d: %s", import.line, import.text))
  end
 local functions_and_params = extract_functions_and_params(buf)
    -- TODO add them to the lines
    return lines
end




-- local functions_and_params =
--   extract_functions_and_params(vim.api.nvim_get_current_buf())
-- local signatures = format_function_signature(functions_and_params)
-- for _, signature in ipairs(signatures) do
--   print(signature)
-- end

