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

  -- ══════════════════════════════════════════════════
  -- BEAMER
  -- ══════════════════════════════════════════════════

  -- Frame
  s("frame", fmt([[
\begin{{frame}}{{{}}}{{{}}
    {}
\end{{frame}}
]], {
    i(1, "Frame Title"),
    i(2, ""),
    i(0, "% content"),
  })),

  -- Block
  s("block", fmt([[
\begin{{block}}{{{}}
    {}
\end{{block}}
]], {
    i(1, "Block Title"),
    i(0, "% content"),
  })),

  -- Columns
  s("cols", fmt([[
\begin{{columns}}
    \begin{{column}}{{{}\\textwidth}}
        {}
    \end{{column}}
    \begin{{column}}{{{}\\textwidth}}
        {}
    \end{{column}}
\end{{columns}}
]], {
    i(1, "0.5"),
    i(2, "% left column"),
    i(3, "0.5"),
    i(0, "% right column"),
  })),

  -- Pause
  s("pause", t("\\pause")),

  -- ══════════════════════════════════════════════════
  -- TIKZ
  -- ══════════════════════════════════════════════════

  -- TikZ picture
  s("tikz", fmt([[
\begin{{tikzpicture}}[{}]
    {}
\end{{tikzpicture}}
]], {
    i(1, "scale=1"),
    i(0, "% TikZ commands"),
  })),

  -- Node
  s("node", fmt("\\node[{}] ({}) at ({}) {{{}}};", {
    i(1, ""),
    i(2, "name"),
    i(3, "0,0"),
    i(0, "text"),
  })),

  -- Draw
  s("draw", fmt("\\draw[{}] ({}) -- ({});", {
    i(1, ""),
    i(2, "0,0"),
    i(0, "1,1"),
  })),

  -- Fill
  s("fill", fmt("\\fill[{}] ({}) rectangle ({});", {
    i(1, "color"),
    i(2, "0,0"),
    i(0, "1,1"),
  })),

  -- ══════════════════════════════════════════════════
  -- COMMON PACKAGES
  -- ══════════════════════════════════════════════════

  -- Graphics
  s("fig", fmt([[
\begin{{figure}}[{}]
    \centering
    \includegraphics[width={}\\textwidth]{{{}}}
    \caption{{{}}}
    \label{{fig:{}}}
\end{{figure}}
]], {
    i(1, "htbp"),
    i(2, "0.8"),
    i(3, "path/to/image"),
    i(4, "Caption"),
    i(0, "label"),
  })),

  -- Table
  s("tab", fmt([[
\begin{{table}}[{}]
    \centering
    \begin{{tabular}}{{{}}}
        \hline
        {} \\
        \hline
        {} \\
        \hline
    \end{{tabular}}
    \caption{{{}}}
    \label{{tab:{}}}
\end{{table}}
]], {
    i(1, "htbp"),
    i(2, "l|c|r"),
    i(3, "Header1 & Header2 & Header3"),
    i(4, "Data1 & Data2 & Data3"),
    i(5, "Caption"),
    i(0, "label"),
  })),

  -- Listings (code)
  s("code", fmt([[
\begin{{lstlisting}}[language={}, caption={{{}}}]
{}
\end{{lstlisting}}
]], {
    i(1, "Python"),
    i(2, "Code caption"),
    i(0, "# code here"),
  })),

  -- Hyperlink
  s("href", fmt("\\href{{{}}}{{{}}}", {
    i(1, "url"),
    i(0, "link text"),
  })),

  -- Bibliography entry
  s("bibitem", fmt("\\bibitem{{{}}} {}", {
    i(1, "key"),
    i(0, "Author. Title. Year."),
  })),
}
