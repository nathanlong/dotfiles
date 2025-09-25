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
  -- HTML tag
  s('tag', {
    t('<'), i(1, 'div'), t(' class="'), i(2, ''), t('"></'), f(mirrorInput, {1}, {user_args={''}}), t('>'),
  }),

  -- Placeholder Images
  s('placehold', {
    t('https://placehold.co/'), i(1, '600'), t('x'), i(2, '400'),
  }),
}
