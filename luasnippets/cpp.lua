-- C++ LuaSnip Snippets
-- Comprehensive coverage: modern C++17/20/23, STL, smart pointers, best practices

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
  -- ══════════════════════════════════════════════════
  -- CORE PATTERNS
  -- ══════════════════════════════════════════════════

  -- Function
  s("fn", fmt([[
{} {}({}) {{
    {}
}}
]], {
    i(1, "void"),
    i(2, "functionName"),
    i(3, ""),
    i(0, "// body"),
  })),

  -- Class definition
  s("cls", fmt([[
class {} {{
public:
    {}();
    ~{}();

    {}

private:
    {}
}};
]], {
    i(1, "ClassName"),
    rep(1),
    rep(1),
    i(2, "// public methods"),
    i(0, "// private members"),
  })),

  -- Struct
  s("struct", fmt([[
struct {} {{
    {}
}};
]], {
    i(1, "StructName"),
    i(0, "// members"),
  })),

  -- Namespace
  s("ns", fmt([[
namespace {} {{
    {}
}} // namespace {}
]], {
    i(1, "name"),
    i(0, "// content"),
    rep(1),
  })),

  -- Header guard (pragma once preferred)
  s("guard", fmt([[
#pragma once

{}
]], {
    i(0, "// header content"),
  })),

  -- Include
  s("inc", fmt([[
#include <{}>
]], {
    i(0, "iostream"),
  })),

  -- Include quotes
  s("incs", fmt([[
#include "{}"
]], {
    i(0, "header.h"),
  })),

  -- For loop
  s("for", fmt([[
for ({}; {} < {}; ++{}) {{
    {}
}}
]], {
    c(1, {
      sn(nil, { t("int "), i(1, "i"), t(" = 0") }),
      sn(nil, { t("size_t "), i(1, "i"), t(" = 0") }),
    }),
    f(function(args)
      local init = args[1][1]
      return init:match("(%w+)%s*=") or "i"
    end, {1}),
    i(2, "n"),
    f(function(args)
      local init = args[1][1]
      return init:match("(%w+)%s*=") or "i"
    end, {1}),
    i(0, "// body"),
  })),

  -- Range-based for loop
  s("forr", fmt([[
for ({}& {} : {}) {{
    {}
}}
]], {
    c(1, {
      t("auto"),
      t("const auto"),
    }),
    i(2, "item"),
    i(3, "container"),
    i(0, "// body"),
  })),

  -- If statement
  s("if", fmt([[
if ({}) {{
    {}
}}
]], {
    i(1, "condition"),
    i(0, "// body"),
  })),

  -- If-else
  s("ife", fmt([[
if ({}) {{
    {}
}} else {{
    {}
}}
]], {
    i(1, "condition"),
    i(2, "// if body"),
    i(0, "// else body"),
  })),

  -- ══════════════════════════════════════════════════
  -- MODERN C++ (C++17/20/23)
  -- ══════════════════════════════════════════════════

  -- Unique pointer
  s("uptr", fmt([[
auto {} = std::make_unique<{}>({}); ]], {
    i(1, "ptr"),
    i(2, "Type"),
    i(0, ""),
  })),

  -- Shared pointer
  s("sptr", fmt([[
auto {} = std::make_shared<{}>({}); ]], {
    i(1, "ptr"),
    i(2, "Type"),
    i(0, ""),
  })),

  -- Lambda
  s("lam", fmt([[
[{}]({}){} {{
    {}
}}
]], {
    i(1, "="),
    i(2, ""),
    c(3, {
      t(""),
      t(" -> auto"),
      sn(nil, { t(" -> "), i(1, "Type") }),
    }),
    i(0, "// body"),
  })),

  -- Auto variable
  s("auto", fmt([[
auto {} = {};
]], {
    i(1, "var"),
    i(0, "value"),
  })),

  -- Constexpr function
  s("constexpr", fmt([[
constexpr {} {}({}) {{
    return {};
}}
]], {
    i(1, "auto"),
    i(2, "functionName"),
    i(3, ""),
    i(0, "value"),
  })),

  -- Structured binding
  s("bind", fmt([[
auto [{}, {}] = {};
]], {
    i(1, "first"),
    i(2, "second"),
    i(0, "pair"),
  })),

  -- Template function
  s("tem", fmt([[
template <typename {}>
{} {}({}) {{
    {}
}}
]], {
    i(1, "T"),
    i(2, "auto"),
    i(3, "functionName"),
    i(4, "T value"),
    i(0, "return value;"),
  })),

  -- ══════════════════════════════════════════════════
  -- STL CONTAINERS & ALGORITHMS
  -- ══════════════════════════════════════════════════

  -- Vector
  s("vec", fmt([[
std::vector<{}> {};
]], {
    i(1, "int"),
    i(0, "vec"),
  })),

  -- Map
  s("map", fmt([[
std::map<{}, {}> {};
]], {
    i(1, "Key"),
    i(2, "Value"),
    i(0, "map"),
  })),

  -- Unordered map
  s("umap", fmt([[
std::unordered_map<{}, {}> {};
]], {
    i(1, "Key"),
    i(2, "Value"),
    i(0, "map"),
  })),

  -- String
  s("str", fmt([[
std::string {} = "{}";
]], {
    i(1, "str"),
    i(0, ""),
  })),

  -- Pair
  s("pair", fmt([[
std::pair<{}, {}> {};
]], {
    i(1, "First"),
    i(2, "Second"),
    i(0, "pair"),
  })),

  -- Algorithm for_each
  s("foreach", fmt([[
std::for_each({}.begin(), {}.end(), []({}& {}) {{
    {}
}});
]], {
    i(1, "container"),
    rep(1),
    i(2, "auto"),
    i(3, "item"),
    i(0, "// process item"),
  })),

  -- Algorithm transform
  s("transform", fmt([[
std::transform({}.begin(), {}.end(), {}.begin(), [](const auto& {}) {{
    return {};
}});
]], {
    i(1, "input"),
    rep(1),
    i(2, "output"),
    i(3, "item"),
    i(0, "transformed"),
  })),

  -- ══════════════════════════════════════════════════
  -- DOCUMENTATION (Doxygen)
  -- ══════════════════════════════════════════════════

  -- Doxygen function comment
  s("doc", fmt([[
/**
 * @brief {}
 * @param {} {}
 * @return {}
 */
]], {
    i(1, "Function description"),
    i(2, "paramName"),
    i(3, "Parameter description"),
    i(0, "Return value description"),
  })),

  -- Doxygen class comment
  s("docclass", fmt([[
/**
 * @class {}
 * @brief {}
 */
]], {
    i(1, "ClassName"),
    i(0, "Class description"),
  })),

  -- TODO comment
  s("todo", fmt([[
// TODO: {}
]], {
    i(0, "Description"),
  })),

  -- ══════════════════════════════════════════════════
  -- BEST PRACTICES
  -- ══════════════════════════════════════════════════

  -- RAII wrapper class
  s("raii", fmt([[
class {} {{
public:
    explicit {}({}* resource) : resource_(resource) {{}}
    ~{}() {{ delete resource_; }}

    // Delete copy
    {}(const {}&) = delete;
    {}& operator=(const {}&) = delete;

    // Allow move
    {}({}&&) noexcept = default;
    {}& operator=({}&&) noexcept = default;

    {}* get() {{ return resource_; }}

private:
    {}* resource_;
}};
]], {
    i(1, "ResourceWrapper"),
    rep(1),
    i(2, "Resource"),
    rep(1),
    rep(1),
    rep(1),
    rep(1),
    rep(1),
    rep(1),
    rep(1),
    rep(1),
    rep(1),
    rep(2),
    rep(2),
  })),

  -- Main function
  s("main", fmt([[
int main(int argc, char* argv[]) {{
    {}
    return 0;
}}
]], {
    i(0, "// program logic"),
  })),

  -- Try-catch
  s("try", fmt([[
try {{
    {}
}} catch (const {}& e) {{
    {}
}}
]], {
    i(1, "// code"),
    i(2, "std::exception"),
    i(0, "std::cerr << e.what() << '\\n';"),
  })),

  -- Enum class
  s("enum", fmt([[
enum class {} {{
    {}
}};
]], {
    i(1, "EnumName"),
    i(0, "Value1, Value2"),
  })),
}
