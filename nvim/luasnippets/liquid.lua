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

local function mirrorInput(
  args,     -- text from i(2) in this example i.e. { { "456" } }
  parent,   -- parent snippet or parent node
  user_args -- user_args from opts.user_args 
  )
  return args[1][1] .. user_args
end

return {
  -- comment
  s("comment", { 
    t("{% comment %}"),
    t({""}), i(1),
    t("{% endcomment %}"),
  }),

  -- expression
  s("expression", {
    t("{{ "), i(1), t(" }}")
  }),

  -- statement
  s("statement", {
    t("{% "), i(1), t(" %}")
  }),

  -- assign variable
  s("assign", {
    t({"{% assign "}), i(1, "variable"), t{" = "}, i(2, "value"), t({" %}"}),
  }),

  -- set complex string as variable
  s("capture", {
    t({"{% capture "}), i(1, "variable"), t({" %}"}),
    t({""}), i(2),
    t({"","{% endcapture %}"})
  }),

  -- for loop
  s("for", {
    t({"{% for "}), i(1, "i"), t({" in "}), i(2, "range"), t({" %}"}),
    t({"",""}), i(3, "..."),
    t({"","{% else %}"}),
    t({"",""}), i(4, "..."),
    t({"","{% endfor %}"})
  }),

  -- if statement
  s("if", {
    t({"{% if "}), i(1, "condition"), t({" %}"}),
    t({"","{% endif %}"})
  }),

  -- unless statement, inverted it
  s("unless", {
    t({"{% unless "}), i(1, "condition"), t({" %}"}),
    t({"","{% endif %}"})
  }),

  -- end (with placeholder for other end statements)
  s("end", {
    t({"{% end"}), i(1, ""), t({" %}"})
  }),

  -- end (with placeholder for other end statements)
  s("include", {
    t({"{% include components/"}), i(1, "component"),
    t({"", "  "}), i(2, "prop"), t({" = "}), i(3, "value"),
    t({"", "%}"})
  }),
}
