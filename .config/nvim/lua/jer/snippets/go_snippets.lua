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
    "im",
    [[
import (
	"$1"
)
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
    "handler",
    [[
func $1(w http.ResponseWriter, req *http.Request) {
    $2
}
]]
  ),
  ps(
    "handlerhtml",
    [[
func $1(w http.ResponseWriter, req *http.Request) {
	w.Header().Set("Content-Type", "text/html")
    $2
}
]]
  ),
  ps(
    "main",
    [[
func main() {
    $1
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
    "ve",
    [[
$1, err := $2
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
  ps(
    "p",
    [[
fmt.Println($1)$0
]]
  ),
  ps(
    "test",
    [[
func Test${1:FunctionName}(t *testing.T) {
    $2
}
]]
  ),
  ps(
    "assert",
    [[
if ${1:actual} != ${2:expected} {
    t.Errorf("Expected %v, got %v", ${2:expected}, ${1:actual})
}
]]
  ),
}
return snippets
