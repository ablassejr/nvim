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

  -- ══════════════════════════════════════════════════
  -- TESTING (pytest)
  -- ══════════════════════════════════════════════════

  -- Pytest parametrize
  s("param", fmt([[
@pytest.mark.parametrize("{}", [
    {},
])
def test_{}({}):
    {}
]], {
    i(1, "arg1, arg2, expected"),
    i(2, "(1, 2, 3),"),
    i(3, "function_name"),
    rep(1),
    i(0, "assert result == expected"),
  })),

  -- Pytest fixture
  s("fixture", fmt([[
@pytest.fixture
def {}({}):
    """{}"""
    {}
]], {
    i(1, "fixture_name"),
    i(2, ""),
    i(3, "Fixture description"),
    i(0, "return value"),
  })),

  -- Async test
  s("atest", fmt([[
@pytest.mark.asyncio
async def test_{}({}):
    """{}"""
    {}
]], {
    i(1, "async_function"),
    i(2, ""),
    i(3, "Test description"),
    i(0, "assert True"),
  })),

  -- ══════════════════════════════════════════════════
  -- TYPE HINTS
  -- ══════════════════════════════════════════════════

  -- Type hint with common types
  s("hint", fmt([[{}: {}]], {
    i(1, "variable"),
    c(2, {
      t("str"),
      t("int"),
      t("float"),
      t("bool"),
      t("list[str]"),
      t("dict[str, Any]"),
      t("Optional[str]"),
      sn(nil, { t("list["), i(1, "T"), t("]") }),
      i(nil, "Any"),
    }),
  })),

  -- Protocol definition
  s("protocol", fmt([[
class {}(Protocol):
    """{}"""

    def {}(self, {}) -> {}:
        {}
]], {
    i(1, "ProtocolName"),
    i(2, "Protocol description"),
    i(3, "method_name"),
    i(4, ""),
    i(5, "None"),
    i(0, "..."),
  })),

  -- ══════════════════════════════════════════════════
  -- DOCUMENTATION
  -- ══════════════════════════════════════════════════

  -- Google-style docstring
  s("doc", fmt([[
"""{}

Args:
    {}: {}

Returns:
    {}: {}

Raises:
    {}: {}
"""
]], {
    i(1, "Function description"),
    i(2, "param_name"),
    i(3, "Parameter description"),
    i(4, "type"),
    i(5, "Return value description"),
    i(6, "ExceptionType"),
    i(0, "Exception description"),
  })),

  -- Simple docstring
  s('"""', fmt([["""{}"""]], { i(1, "Description") })),

  -- ══════════════════════════════════════════════════
  -- ASYNC PATTERNS
  -- ══════════════════════════════════════════════════

  -- Async context manager
  s("acm", fmt([[
async with {}({}) as {}:
    {}
]], {
    i(1, "context_manager"),
    i(2, ""),
    i(3, "var"),
    i(0, "pass"),
  })),

  -- Async comprehension
  s("afor", fmt([[
[{} async for {} in {}]
]], {
    i(1, "item"),
    rep(1),
    i(0, "async_iterable"),
  })),

  -- Context manager class
  s("ctx", fmt([[
class {}:
    """{}"""

    def __enter__(self):
        {}
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        {}
        return False
]], {
    i(1, "ContextManager"),
    i(2, "Context manager description"),
    i(3, "# setup"),
    i(0, "# cleanup"),
  })),
}
