local ls = require "luasnip"
local ps = ls.parser.parse_snippet


local snippets = {
  ps(
    "struct",
    [[
type $1 struct {
	$2
}
]]
  ),
  ps(
    "f",
    [[
func $1($2) $3 {
    $4
}
]]
  ),
  ps(
    "m",
    [[
func ($1) $2($3) $4 {
    $5
}
]]
  ),
  ps(
    "v",
    [[
$1 := $2
]]
  ),
}
return snippets
