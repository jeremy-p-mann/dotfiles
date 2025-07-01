local iremap = require("jer.keymaps").iremap
local ls = require "luasnip"

ls.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = false,
}

local snippet_ft_map = {
  python = "python_snippets",
  javascript = "javascript_snippets",
  lua = "lua_snippets",
  go = "go_snippets",
  rust = "rust_snippets",
  yaml = "yaml_snippets",
  markdown = "markdown_snippets",
}

-- Track loaded filetypes to prevent duplicates
local loaded_filetypes = {}

local group = vim.api.nvim_create_augroup("LazyLoadSnippets", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = vim.tbl_keys(snippet_ft_map),
  callback = function(args)
    local ft = args.match
    local modname = snippet_ft_map[ft]

    -- Only load if not already loaded
    if modname and not loaded_filetypes[ft] then
      ls.add_snippets(ft, require("jer.snippets." .. modname))
      loaded_filetypes[ft] = true
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "html", "css" },
  callback = function(args)
    local ft = args.match

    -- Only load if not already loaded
    if not loaded_filetypes[ft .. "_vscode"] then
      require("luasnip.loaders.from_vscode").load { include = { ft } }
      loaded_filetypes[ft .. "_vscode"] = true
    end
  end,
})

require("luasnip").filetype_extend("javascript", { "javascriptreact" })
require("luasnip").filetype_extend("javascript", { "html" })

local expand_jump_snippet = function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end

local previous_item_snippet = function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end

iremap("<c-l>", expand_jump_snippet, "Expand or Jump Snippet")
iremap("<c-h>", previous_item_snippet, "Go to Previous Item in Snipppet")
