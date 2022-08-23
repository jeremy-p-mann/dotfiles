local ls = require "luasnip"
local ps = ls.parser.parse_snippet

local snippets = {
  ps(
    "function",
    [[
$1 = function ($2)
  $3
end
$4
]]
  ),
  ps(
    "for_loop_list",
    [[
for $1,$2 in ipairs($3) do
  $4
end
]]
  ),
  ps(
    "for_loop_items",
    [[
for ${1:key},${2:value} in pairs(${3:table}) do
  $4
end
]]
  ),
  ps(
    "if_else",
    [[
if $1 then
  $2
else
  $3
end
$4
]]
  ),
}
return snippets