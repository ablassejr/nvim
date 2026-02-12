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
}
