local ls = require "luasnip"
local ps = ls.parser.parse_snippet


local snippets = {
  ps(
    "test",
    [[
    #[test]
    fn ${1:name}() {
        $2
    }
]]
  ),
  ps(
    "test_module",
    [[
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn ${1:test_name}() {
        ${2:assert_eq!(0, 1)};
    }
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
