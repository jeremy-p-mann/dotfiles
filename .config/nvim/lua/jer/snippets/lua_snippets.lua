local ls = require "luasnip"
local ps = ls.parser.parse_snippet

local snippets = {}
--   ps(
--     "v",
--     [[
-- local $1 = $2
-- ]]
--   ),
--   ps(
--     "function",
--     [[
-- local $1 = function ($2)
--   $3
-- end
-- $4
-- ]]
--   ),
--   ps(
--     "for_loop_list",
--     [[
-- for $1,$2 in ipairs($3) do
--   $4
-- end
-- ]]
--   ),
--   ps(
--     "for_loop_items",
--     [[
-- for $1,$2 in pairs($3) do
--   $4
-- end
-- ]]
--   ),
--   ps(
--     "if_else",
--     [[
-- if $1 then
--   $2
-- else
--   $3
-- end
-- $4
-- ]]
--   ),
-- }

return snippets
