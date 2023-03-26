local ls = require "luasnip"
local ps = ls.parser.parse_snippet

local snippets = {
  ps(
    "exercise",
    [[
  - exercise: $1
    reps: $2
    load: $3 pounds
]]
),
}

return snippets
