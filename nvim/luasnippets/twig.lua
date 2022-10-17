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
  -- Comment
  s("comm", { 
    t("{# "), i(1), t(" #}")
  }),

  s("expression", {
    t("{{ "), i(1), t(" }}")
  }),

  s("statement", {
    t("{% "), i(1), t(" %}")
  }),

  s("set", {
    t({"{% set "}), i(1), t({" %}"}),
    t({""}), i(2),
    t({"","{% endset %}"})
  }),

  s("for", {
    t({"{% for "}), i(1, "i"), t({" in "}), i(2, "range"), t({" %}"}),
    t({"",""}), i(3, "..."),
    t({"","{% endfor %}"})
  }),

  s("if", {
    t({"{% if "}), i(1, "condition"), t({" %}"}),
    t({"",""}), i(2, "..." ),
    t({"","{% endif %}"})
  }),

  -- Custom component, expects case match for filename and component name
  s("component", {
    t("{% from '_components/"), i(1,"Component"), t(".twig' import "), f(mirrorInput, {1}, { user_args = { "" }}), t(" %}")
  }),

  -- Macro component
  s("macroComponent",{
    t({"{% macro "}), i(1, "Component"), t{("(props = {}) %}")},
    t({"",""}),
    t({"", "{% set props = {"}),
    t({"","  "}), i(2, "propName"), t(": props."), f(mirrorInput, {2}, {user_args={""}}), t(" ?? null,"),
    t({"","} %}"}),
    t({"",""}),
    t({"",""}), i(3, "..."),
    t({"",""}),
    t({"","{% endmacro %}"})
  }),

  -- Macro Prop
  s("propDef", {
    i(1, "propName"), t(": props."), f(mirrorInput, {1}, {user_args={""}}), t(" ?? null,"),
  }),

  -- Parts Kit Boilerplate
  s("kitBoilerplate", {
    t("{% extends 'viget-base/_layouts/parts-kit' %}"),
    t({"",""}),
    t({"","{% block main %}"}),
    t({"",'<div class="p-responsive-xl-32">'}),
    t({"",'  <h1 class="text-heading-lg mb-responsive-xl-20">'}), i(1, "Title"), t("</h1>"),
    t({"",""}),
    t({"","  "}), i(2, "..."),
    t({"",""}),
    t({"","</div>"}),
    t({"","{% endblock %}"}),
  })
}
