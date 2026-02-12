-- Python LuaSnip Snippets
-- Comprehensive coverage: core patterns, FastAPI, pytest, type hints, async

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {
  -- ══════════════════════════════════════════════════
  -- CORE PATTERNS
  -- ══════════════════════════════════════════════════

  -- Function with type hints
  s("def", fmt([[
def {}({}) -> {}:
    """{}"""
    {}
]], {
    i(1, "function_name"),
    i(2, ""),
    i(3, "None"),
    i(4, "Description"),
    i(0, "pass"),
  })),

  -- Function with choice between sync/async
  s("fn", fmt([[
{} {}({}) -> {}:
    """{}"""
    {}
]], {
    c(1, {
      t("def"),
      t("async def"),
    }),
    i(2, "function_name"),
    i(3, ""),
    i(4, "None"),
    i(5, "Description"),
    i(0, "pass"),
  })),

  -- Class definition
  s("cls", fmt([[
class {}({}):
    """{}"""

    def __init__(self, {}):
        {}
]], {
    i(1, "ClassName"),
    i(2, ""),
    i(3, "Class description"),
    i(4, ""),
    i(0, "pass"),
  })),
}
