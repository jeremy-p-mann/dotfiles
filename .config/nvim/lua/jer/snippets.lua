local ls = require "luasnip"

ls.config.set_config {
  -- Jump back into snippet even if you move outside of the selection
  history = true,
  --updates as you type!
  updateevents = "TextChanged,TextChangedI",
  -- Autosnippets:
  enable_autosnippets = true
}

require("luasnip.loaders.from_vscode").load()
