local ls = require "luasnip"
local ps = ls.parser.parse_snippet

local snippets = {
ps(
  "c",
  [[
const $1 = $2;
]]
),
ps(
  "clv",
  [[
console.log("$1", $1);
]]
),
ps(
  "cl",
  [[
console.log();
]]
),
ps(
  "jest test",
  [[
test('$1', () => {
  $2
});
]]
),
}
return snippets
