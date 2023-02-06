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

local function time()
  return os.date("%I:%M %p")
end


local function date()
  return os.date("%m/%d/%y")
end

return {
  -- mark time
  s("mtime", { 
    t("<<mark '"), f(time), t("' time>>")
  }),

  -- mark date
  s("mdate", { 
    t("<<mark '"), f(date), t("' time>>")
  }),

  -- table time block
  s("timeblock", {
    t({"|Time |Plan |Rev. |h",
    "|08| | |",
    "|--|~|~|",
    "|09|~|~|",
    "|--|~|~|",
    "|10|~|~|",
    "|--|~|~|",
    "|11|~|~|",
    "|--|~|~|",
    "|12|~|~|",
    "|--|~|~|",
    "|01|~|~|",
    "|--|~|~|",
    "|02|~|~|",
    "|--|~|~|",
    "|03|~|~|",
    "|--|~|~|",
    "|04|~|~|",
    "|--|~|~|",
    "|05|~|~|",
    "|--|~|~|"}),
  })
}
