local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local l = require("luasnip.extras").lambda
local r = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")
local events = require("luasnip.util.events")

return {
  -- tag, non-printing
  s("tag", { 
    t("<% "), i(1), t(" %>")
  }),

  -- expression, printing
  s("expression", { 
    t("<%= "), i(1), t(" %>")
  }),

  -- comment
  s("comment", { 
    t("<%# "), i(1), t(" %>")
  }),

  -- if
  s("if", {
    t({"<% if "}), i(1, "condition"), t({" %>", ""}),
    i(2, "body"), t({""}),
    t({"<% end %>"}),
  }),

  -- debug
  s("debug", { 
    t("<%= debug "), i(1), t(" %>")
  }),
}
