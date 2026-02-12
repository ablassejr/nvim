-- JavaScript/TypeScript LuaSnip Snippets
-- Comprehensive coverage: modern ES6+, React, Express, testing

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
  -- ══════════════════════════════════════════════════
  -- CORE PATTERNS
  -- ══════════════════════════════════════════════════

  -- Function with arrow/regular choice
  s("fn", fmt([[
{} {}({}) {{
  {}
}}
]], {
    c(1, {
      t("function"),
      t("async function"),
      t("const"),
    }),
    i(2, "functionName"),
    i(3, ""),
    i(0, "// body"),
  })),

  -- Arrow function
  s("af", fmt([[
const {} = ({}) => {{
  {}
}}
]], {
    i(1, "functionName"),
    i(2, ""),
    i(0, "// body"),
  })),

  -- Async arrow function
  s("aaf", fmt([[
const {} = async ({}) => {{
  {}
}}
]], {
    i(1, "functionName"),
    i(2, ""),
    i(0, "// body"),
  })),

  -- Class definition
  s("cls", fmt([[
class {} {}{{
  constructor({}) {{
    {}
  }}

  {}
}}
]], {
    i(1, "ClassName"),
    c(2, {
      t(""),
      sn(nil, { t("extends "), i(1, "ParentClass"), t(" ") }),
    }),
    i(3, ""),
    i(4, "// initialization"),
    i(0, "// methods"),
  })),

  -- Promise
  s("promise", fmt([[
new Promise((resolve, reject) => {{
  {}
}})
]], {
    i(0, "// async operation"),
  })),

  -- Try-catch
  s("try", fmt([[
try {{
  {}
}} catch (error) {{
  {}
}}
]], {
    i(1, "// code"),
    i(0, "console.error(error)"),
  })),
}
