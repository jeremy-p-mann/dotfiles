local ls = require "luasnip"
local ps = ls.parser.parse_snippet

local snippets = {
  ps(
    "s",
    [[
type $1 struct {
	$2
}
]]
  ),
  ps(
    "if",
    [[
if $1 {
	$2
}
]]
  ),
  ps(
    "el",
    [[
else {
        $1
}
]]
  ),
  ps(
    "elif",
    [[
else if $1 {
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
  ps(
    "for",
    [[
for $1 := $2; $1 < $3; $1++ {
	$0
}
]]
  ),
  ps(
    "forslice",
    [[
for index, ${1:value} := range $2 {
	$0
}
]]
  ),
}
return snippets
