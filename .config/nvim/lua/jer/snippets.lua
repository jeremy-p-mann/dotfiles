local iremap = require("jer.keymaps").iremap
local ls = require "luasnip"
local select_choice = require'luasnip.extras.select_choice'

ls.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = false,
}

ls.add_snippets("python", require "jer.snippets.python_snippets")
ls.add_snippets("javascript", require "jer.snippets.javascript_snippets")
ls.add_snippets("lua", require "jer.snippets.lua_snippets")
ls.add_snippets("go", require "jer.snippets.go_snippets")
ls.add_snippets("rust", require "jer.snippets.rust_snippets")
ls.add_snippets("yaml", require "jer.snippets.yaml_snippets")
ls.add_snippets("markdown", require "jer.snippets.markdown_snippets")


require("luasnip.loaders.from_vscode").load { include = { "html", "css" } }
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
iremap("<c-y>", select_choice, "Select Choice")

