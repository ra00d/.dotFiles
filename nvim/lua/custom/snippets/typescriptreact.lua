local ls = require 'luasnip'
-- some shorthands...
local s = ls.s
-- local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local l = require("luasnip.extras").lambda
local rep = require('luasnip.extras').rep
-- local p = require("luasnip.extras").partial
-- local m = require("luasnip.extras").match
-- local n = require("luasnip.extras").nonempty
-- local dl = require("luasnip.extras").dynamic_lambda
local fmt = require('luasnip.extras.fmt').fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local types = require("luasnip.util.types")
-- local conds = require("luasnip.extras.conditions")
-- local conds_expand = require("luasnip.extras.conditions.expand")

-- local filename = function()
--   return f(function(_args, snip)
--     local name = snip.snippet.env.TM_FILENAME_BASE
--     name = name:sub(1, 1):upper() .. name:sub(2)
--     return name or ''
--   end)
-- end
ls.add_snippets('typescriptreact', {
  s('edf', fmt('export default {};', { i(0) })),
  s('cst', fmt('const {}={}', { i(1, 'name'), i(0, 'value') })),
  s(
    'us',
    fmt([[const [{},set{}]=useState({}){} ]], {
      i(1, 'state'),
      f(function(args, parent)
        local name = args[1][1]
        name = name:sub(1, 1):upper() .. name:sub(2)
        return name or ''
      end, { 1 }),
      i(2, 'intial'),
      i(0),
    })
  ),
  -- s('rfc', fmt([[export const {}=()=>{{
  -- return (<div>{}</div>);
  -- }}]], { i(1), i(0) })),
})
