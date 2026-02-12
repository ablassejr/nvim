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

  -- ══════════════════════════════════════════════════
  -- REACT
  -- ══════════════════════════════════════════════════

  -- React functional component
  s("rfc", fmt([[
export default function {}({}) {{
  {}

  return (
    <{}>
      {}
    </{}>
  )
}}
]], {
    i(1, "ComponentName"),
    i(2, ""),
    i(3, "// hooks and logic"),
    i(4, "div"),
    i(0, "// content"),
    rep(4),
  })),

  -- React functional component with props
  s("rfcp", fmt([[
interface {}Props {{
  {}
}}

export default function {}({{ {} }}: {}Props) {{
  {}

  return (
    <{}>
      {}
    </{}>
  )
}}
]], {
    i(1, "Component"),
    i(2, "prop: string"),
    rep(1),
    i(3, "prop"),
    rep(1),
    i(4, "// hooks"),
    i(5, "div"),
    i(0, "{prop}"),
    rep(5),
  })),

  -- useState hook
  s("us", fmt([[
const [{}, set{}] = useState{}({})
]], {
    i(1, "state"),
    f(function(args)
      local name = args[1][1]
      return name:sub(1,1):upper() .. name:sub(2)
    end, {1}),
    c(2, {
      t(""),
      sn(nil, { t("<"), i(1, "Type"), t(">") }),
    }),
    i(0, "initialValue"),
  })),

  -- useEffect hook
  s("ue", fmt([[
useEffect(() => {{
  {}

  return () => {{
    {}
  }}
}}, [{}])
]], {
    i(1, "// effect"),
    i(2, "// cleanup"),
    i(0, "// dependencies"),
  })),

  -- Custom hook
  s("hook", fmt([[
function use{}({}) {{
  {}

  return {}
}}
]], {
    i(1, "CustomHook"),
    i(2, ""),
    i(3, "// hook logic"),
    i(0, "value"),
  })),
}
