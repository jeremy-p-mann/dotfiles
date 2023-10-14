local ls = require "luasnip"
local ps = ls.parser.parse_snippet


local snippets = {
  ps(
    "u",
    [[
## User

$1

]]
  ),
}
return snippets
