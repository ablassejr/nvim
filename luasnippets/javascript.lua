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

  -- ══════════════════════════════════════════════════
  -- EXPRESS / NODE.JS
  -- ══════════════════════════════════════════════════

  -- Express route
  s("route", fmt([[
router.{}('{}', async (req, res{}) => {{
  try {{
    {}
    res.json({{ {} }})
  }} catch (error) {{
    {}
  }}
}})
]], {
    c(1, {
      t("get"),
      t("post"),
      t("put"),
      t("delete"),
      t("patch"),
    }),
    i(2, "/path"),
    c(3, {
      t(""),
      t(", next"),
    }),
    i(4, "// logic"),
    i(5, "data"),
    i(0, "next(error)"),
  })),

  -- Express middleware
  s("middleware", fmt([[
const {} = ({}) => (req, res, next) => {{
  try {{
    {}
    next()
  }} catch (error) {{
    next(error)
  }}
}}
]], {
    i(1, "middlewareName"),
    i(2, ""),
    i(0, "// middleware logic"),
  })),

  -- Express error handler
  s("errorh", fmt([[
app.use((err, req, res, next) => {{
  console.error(err.stack)
  res.status({}).json({{
    error: {{
      message: err.message,
      {}
    }}
  }})
}})
]], {
    i(1, "500"),
    i(0, "// additional error info"),
  })),

  -- ══════════════════════════════════════════════════
  -- TESTING (Jest/Vitest)
  -- ══════════════════════════════════════════════════

  -- Describe block
  s("desc", fmt([[
describe('{}', () => {{
  {}
}})
]], {
    i(1, "test suite"),
    i(0, "// tests"),
  })),

  -- Test case
  s("test", fmt([[
{}('{}', {}() => {{
  {}
}})
]], {
    c(1, {
      t("test"),
      t("it"),
    }),
    i(2, "should do something"),
    c(3, {
      t(""),
      t("async "),
    }),
    i(0, "expect(result).toBe(expected)"),
  })),

  -- Mock function
  s("mock", fmt([[
const {} = jest.fn(({}) => {})
]], {
    i(1, "mockFn"),
    i(2, ""),
    i(0, "returnValue"),
  })),

  -- ══════════════════════════════════════════════════
  -- DOCUMENTATION (JSDoc)
  -- ══════════════════════════════════════════════════

  -- JSDoc function comment
  s("jsdoc", fmt([[
/**
 * {}
 * @param {{{}}} {} - {}
 * @returns {{{}}} {}
 */
]], {
    i(1, "Function description"),
    i(2, "string"),
    i(3, "paramName"),
    i(4, "Parameter description"),
    i(5, "void"),
    i(0, "Return value description"),
  })),

  -- JSDoc type definition
  s("typedef", fmt([[
/**
 * @typedef {{Object}} {}
 * @property {{{}}} {} - {}
 */
]], {
    i(1, "TypeName"),
    i(2, "string"),
    i(3, "propertyName"),
    i(0, "Property description"),
  })),

  -- ══════════════════════════════════════════════════
  -- MODERN ES6+
  -- ══════════════════════════════════════════════════

  -- Import statement
  s("imp", fmt([[
import {} from '{}'
]], {
    c(1, {
      sn(nil, { t("{ "), i(1, "named"), t(" }") }),
      i(nil, "Default"),
      sn(nil, { t("* as "), i(1, "name") }),
    }),
    i(0, "module"),
  })),

  -- Export statement
  s("exp", fmt([[
export {}{}
]], {
    c(1, {
      t("default "),
      t(""),
      t("const "),
    }),
    i(0, "value"),
  })),

  -- Destructuring assignment
  s("dest", fmt([[
const {{ {} }} = {}
]], {
    i(1, "prop1, prop2"),
    i(0, "object"),
  })),

  -- Template literal
  s("tpl", fmt([[
`{}`
]], {
    i(0, "${expression}"),
  })),

  -- Optional chaining
  s("opt", fmt([[
{}?.{}
]], {
    i(1, "object"),
    i(0, "property"),
  })),

  -- Nullish coalescing
  s("null", fmt([[
{} ?? {}
]], {
    i(1, "value"),
    i(0, "defaultValue"),
  })),
}
