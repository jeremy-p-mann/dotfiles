local iremap = require("jer.keymaps").iremap
local ls = require "luasnip"

ls.config.set_config {
  -- Jump back into snippet even if you move outside of the selection
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true
}
require("luasnip.loaders.from_vscode").load()

local expand_jump_snippet = function()
  if ls.expand_or_jumpable() then ls.expand_or_jump() end
end
local previous_item_snippet = function()
  if ls.jumpable(-1) then ls.jump(-1) end
end

iremap("<c-l>", expand_jump_snippet, "Expand or Jump Snippet" )
iremap("<c-h>", previous_item_snippet, "Go to Previous Item in Snipppet")

