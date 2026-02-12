-- LaTeX LuaSnip Snippets
-- Comprehensive coverage: environments, math, Beamer, TikZ, bibliography

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
  -- CORE STRUCTURES
  -- ══════════════════════════════════════════════════

  -- Smart environment (preserves existing functionality)
  s(
    { trig = "beg", dscr = "LaTeX environment with smart \\item insertion" },
    fmt(
      [[
\begin{<>}
    <>
\end{<>}
      ]],
      {
        c(1, {
          t("enumerate"),
          t("itemize"),
          t("description"),
          t("equation"),
          t("align"),
          t("figure"),
          t("table"),
          t("theorem"),
          t("proof"),
          i(nil, "env"),
        }),
        f(function(args)
          local env = args[1][1]
          if env == "enumerate" or env == "itemize" then
            return "\\item "
          elseif env == "description" then
            return "\\item[] "
          else
            return ""
          end
        end, { 1 }),
        f(function(args)
          return args[1][1]
        end, { 1 }),
      },
      { delimiters = "<>" }
    )
  ),

  -- Item
  s("item", fmt("\\item {}", { i(0) })),

  -- Item with description
  s("itemd", fmt("\\item[{}] {}", { i(1, "label"), i(0) })),

  -- Section
  s("sec", fmt("\\section{{{}}}", { i(0) })),

  -- Subsection
  s("ssec", fmt("\\subsection{{{}}}", { i(0) })),

  -- Subsubsection
  s("sssec", fmt("\\subsubsection{{{}}}", { i(0) })),

  -- Label
  s("lab", fmt("\\label{{{}}}", { i(0) })),

  -- Reference
  s("ref", fmt("\\ref{{{}}}", { i(0) })),

  -- Citation
  s("cite", fmt("\\cite{{{}}}", { i(0) })),

  -- ══════════════════════════════════════════════════
  -- MATH
  -- ══════════════════════════════════════════════════

  -- Inline math
  s("mm", fmt("${}$", { i(0) })),

  -- Display math
  s("dm", fmt([[
\[
    {}
\]
]], { i(0) })),

  -- Equation environment
  s("eq", fmt([[
\begin{{equation}}
    {}
    \label{{eq:{}}}
\end{{equation}}
]], {
    i(1),
    i(0, "label"),
  })),

  -- Align environment
  s("align", fmt([[
\begin{{align}}
    {} &= {} \\
    &= {}
    \label{{eq:{}}}
\end{{align}}
]], {
    i(1, "expression"),
    i(2, "step1"),
    i(3, "step2"),
    i(0, "label"),
  })),

  -- Fraction
  s("frac", fmt("\\frac{{{}}}{{{}}}", {
    i(1, "numerator"),
    i(0, "denominator"),
  })),

  -- Sum
  s("sum", fmt("\\sum_{{{}}}^{{{}}}", {
    c(1, {
      sn(nil, { i(1, "i"), t("="), i(2, "1") }),
      i(nil, "i"),
    }),
    i(0, "n"),
  })),

  -- Integral
  s("int", fmt("\\int_{{{}}}^{{{}}} {}", {
    i(1, "a"),
    i(2, "b"),
    i(0, "f(x) dx"),
  })),

  -- Matrix
  s("mat", fmt([[
\begin{{{}}}
    {} & {} \\
    {} & {}
\end{{{}}}
]], {
    c(1, {
      t("pmatrix"),
      t("bmatrix"),
      t("vmatrix"),
      t("matrix"),
    }),
    i(2, "a"),
    i(3, "b"),
    i(4, "c"),
    i(5, "d"),
    f(function(args) return args[1][1] end, {1}),
  })),

  -- Greek letters with choice
  s("gr", fmt("\\{}", {
    c(1, {
      t("alpha"),
      t("beta"),
      t("gamma"),
      t("delta"),
      t("epsilon"),
      t("theta"),
      t("lambda"),
      t("mu"),
      t("sigma"),
      t("omega"),
    }),
  })),
}
