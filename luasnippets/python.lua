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

  -- ══════════════════════════════════════════════════
  -- FASTAPI
  -- ══════════════════════════════════════════════════

  -- FastAPI route with HTTP method choice
  s("route", fmt([[
@router.{}("{}")
async def {}({}):
    """{}"""
    {}
]], {
    c(1, {
      t("get"),
      t("post"),
      t("put"),
      t("delete"),
      t("patch"),
    }),
    i(2, "/path"),
    i(3, "endpoint_name"),
    i(4, ""),
    i(5, "Endpoint description"),
    i(0, "return {}"),
  })),

  -- Pydantic model
  s("pydantic", fmt([[
class {}(BaseModel):
    """{}"""
    {}: {}

    @field_validator("{}")
    @classmethod
    def validate_{}(cls, v):
        {}
        return v
]], {
    i(1, "ModelName"),
    i(2, "Model description"),
    i(3, "field_name"),
    i(4, "str"),
    rep(3),
    rep(3),
    i(0, "# validation logic"),
  })),

  -- FastAPI dependency
  s("depend", fmt([[
async def {}({}) -> {}:
    """{}"""
    {}
]], {
    i(1, "get_dependency"),
    i(2, ""),
    i(3, "Any"),
    i(4, "Dependency description"),
    i(0, "return value"),
  })),
}
