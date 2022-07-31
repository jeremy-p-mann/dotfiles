local ls = require "luasnip"
local ps = ls.parser.parse_snippet

local snippets = {
  ps(
    "function",
    [[
${1:function_name}() {
    $2
}
]]
),
ps(
  "string comparison",
  [[
[ $(${1:variable_name}) = "${2:value}" ]
]]
),
}
