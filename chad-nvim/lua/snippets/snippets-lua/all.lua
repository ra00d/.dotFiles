local ls = require("luasnip")
-- some shorthands...
local s = ls.s
-- local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local l = require("luasnip.extras").lambda
-- local rep = require("luasnip.extras").rep
-- local p = require("luasnip.extras").partial
-- local m = require("luasnip.extras").match
-- local n = require("luasnip.extras").nonempty
-- local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
-- local conds = require("luasnip.extras.conditions")
-- local conds_expand = require("luasnip.extras.conditions.expand")

ls.add_snippets("all", {
	s("local", t("127.0.0.1")),
	s('msql', fmt('mysql://root:@127.0.0.1:3306/{}', { i(0, "db_name") })),
	s('psql', fmt('postqresql://root:@127.0.0.1:5432/{}', { i(0, "db_name") }))
}
)
