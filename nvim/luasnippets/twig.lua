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
  s("comm", {
    t("{# "), i(1), t(" #}")
  }),

  -- expression
  s("expression", {
    t("{{ "), i(1), t(" }}")
  }),

  -- statement
  s("statement", {
    t("{% "), i(1), t(" %}")
  }),

  -- set variable
  s("set", {
    t({"{% set "}), i(1), t({" %}"}),
  }),

  -- set block (multiline)
  s("setblock", {
    t({"{% set "}), i(1), t({" %}"}),
    t({""}), i(2),
    t({"","{% endset %}"})
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

  -- end (with placeholder for other end statements)
  s("end", {
    t({"{% end"}), i(1, ""), t({" %}"})
  }),

  -- custom component, expects case match for filename and component name
  s("component", {
    t("{% from '_components/"), i(1,"Component"), t(".twig' import "), f(mirrorInput, {1}, { user_args = { "" }}), t(" %}")
  }),

  -- Macro component
  s('macroComponent',{
    t({'{% macro '}), i(1, 'Component'), t{('(props = {}) %}')},
    t({'',''}),
    t({'', '{% set props = {'}),
    t({'','  '}), i(2, 'propName'), t(': props.'), f(mirrorInput, {2}, {user_args={''}}), t(' ?? null,'),
    t({'','} %}'}),
    t({'',''}),
    t({'',''}), i(3, '...'),
    t({'',''}),
    t({'','{% endmacro %}'})
  }),

  -- Macro simple
  s('macroSimple',{
    t({'{%- macro '}), i(1, 'Component'), t{('(var=null) -%}')},
    t({'',''}), i(3, '...'),
    t({'','{%- endmacro -%}'})
  }),

  -- Macro Prop
  s('propDef', {
    i(1, 'propName'), t(': props.'), f(mirrorInput, {1}, {user_args={''}}), t(' ?? null,'),
  }),

  -- Parts Kit Boilerplate
  s('kitBoilerplate', {
    t('{% extends "viget-base/_layouts/parts-kit" %}'),
    t({'',''}),
    t({'','{% block main %}'}),
    t({'','  '}), i(2, '...'),
    t({'','{% endblock %}'}),
  }),

  -- Include partial
  s('partialinclude', {
    t('{% include "'), i(1, '_partials/component.twig'), t('" with {'),
    t({'','} only %}'}),
  }),

  -- Dump
  s('dump', {
    t({'{{ dump('}), i(1, 'var'), t({') }}'})
  }),

  -- Viget partsKit function
  s('partsKit', {
    t({'craft.viget.partsKit'}), i(1)
  }),

  -- Div with classnames
  s('cxdiv', {
    t('<div class="{{ cx("'), i(1, 'class'), t('", {'),
    t({'','  "class": condition,'}),
    t({'','}) }}">'}),
    t({'','</div>'}),
  }),

  -- HTML tag
  s('tag', {
    t('<'), i(1, 'div'), t(' class="'), i(2, ''), t('"></'), f(mirrorInput, {1}, {user_args={''}}), t('>'),
  }),

  -- Placeholder Images
  s('placehold', {
    t('https://placehold.co/'), i(1, '600'), t('x'), i(2, '400'),
  }),
}
