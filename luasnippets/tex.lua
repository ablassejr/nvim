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
local fmta = require("luasnip.extras.fmt").fmta
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
\begin{{frame}}{{{}}}
    {}
\end{{frame}}
]], {
    i(1, "Frame Title"),
    i(0, "% content"),
  })),

  -- Block
  s("block", fmta([[
\begin{block}{<>}
    <>
\end{block}
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

  -- ══════════════════════════════════════════════════
  -- DOCUMENT STRUCTURE & PREAMBLE
  -- ══════════════════════════════════════════════════

  -- Full document skeleton
  s("doc", fmt([[\documentclass[{}]{{{}}}

% Packages
\usepackage[utf8]{{inputenc}}
\usepackage[T1]{{fontenc}}
\usepackage{{amsmath, amssymb, amsthm}}
\usepackage{{hyperref}}

\title{{{}}}
\author{{{}}}
\date{{{}}}

\begin{{document}}

\maketitle

{}

\end{{document}}
]], {
    c(1, { t("12pt"), t("11pt"), t("10pt") }),
    c(2, { t("article"), t("report"), t("book"), t("beamer"), i(nil, "class") }),
    i(3, "Title"),
    i(4, "Author"),
    c(5, { t("\\today"), i(nil, "date") }),
    i(0),
  })),

  -- usepackage (with optional options via choice node)
  s("pkg", c(1, {
    sn(nil, { t("\\usepackage{"), i(1, "package"), t("}") }),
    sn(nil, { t("\\usepackage["), i(1, "options"), t("]{"), i(2, "package"), t("}") }),
  })),

  -- documentclass
  s("class", fmt("\\documentclass[{}]{{{}}}", {
    c(1, { t("12pt,a4paper"), t("11pt,a4paper"), t("11pt,letterpaper"), i(nil, "options") }),
    c(2, { t("article"), t("report"), t("book"), t("beamer"), i(nil, "class") }),
  })),

  -- title / author / date
  s("title", fmt("\\title{{{}}}", { i(0, "Title") })),
  s("author", fmt("\\author{{{}}}", { i(0, "Author") })),
  s("date", c(1, {
    sn(nil, { t("\\date{\\today}") }),
    sn(nil, { t("\\date{"), i(1, "date"), t("}") }),
  })),

  -- standalone commands
  s("maketitle", t("\\maketitle")),
  s("toc", t("\\tableofcontents")),

  -- newcommand / renewcommand
  s("newcmd", fmt("\\newcommand{{\\{}}}[{}]{{{}}}", {
    i(1, "name"),
    i(2, "0"),
    i(0, "definition"),
  })),
  s("renewcmd", fmt("\\renewcommand{{\\{}}}[{}]{{{}}}", {
    i(1, "name"),
    i(2, "0"),
    i(0, "definition"),
  })),

  -- newenvironment
  s("newenv", fmt([[\newenvironment{{{}}}
  {{{}}}
  {{{}}}
]], {
    i(1, "name"),
    i(2, "begin-code"),
    i(0, "end-code"),
  })),

  -- abstract environment
  s("abstract", fmt([[\begin{{abstract}}
  {}
\end{{abstract}}
]], { i(0) })),

  -- ══════════════════════════════════════════════════
  -- CORE STRUCTURES — EXTENSIONS
  -- ══════════════════════════════════════════════════

  -- Paragraph heading
  s("par", fmt("\\paragraph{{{}}}", { i(0) })),

  -- No indent
  s("noind", t("\\noindent")),

  -- Vertical / horizontal space
  s("vsp", fmt("\\vspace{{{}}}", {
    c(1, { t("1em"), t("1cm"), t("\\baselineskip"), i(nil, "length") }),
  })),
  s("hsp", fmt("\\hspace{{{}}}", {
    c(1, { t("1em"), t("1cm"), i(nil, "length") }),
  })),

  -- New page
  s("newpage", t("\\newpage")),

  -- Appendix with first section
  s("appendix", fmt([[\appendix
\section{{{}}}
{}
]], { i(1, "Appendix Title"), i(0) })),

  -- Minipage
  s("minipage", fmt([[\begin{{minipage}}{{{}\\textwidth}}
  {}
\end{{minipage}}
]], { i(1, "0.5"), i(0) })),

  -- Center environment
  s("center", fmt([[\begin{{center}}
  {}
\end{{center}}
]], { i(0) })),

  -- ══════════════════════════════════════════════════
  -- MATH — SYMBOLS & OPERATORS
  -- ══════════════════════════════════════════════════

  -- Limit
  s("lim", fmt("\\lim_{{{}}} {}", { i(1, "x \\to \\infty"), i(0) })),

  -- Product
  s("prod", fmt("\\prod_{{{}}}^{{{}}}", {
    i(1, "i=1"),
    i(0, "n"),
  })),

  -- Accents
  s("vec", fmt("\\vec{{{}}}", { i(0) })),
  s("hat", fmt("\\hat{{{}}}", { i(0) })),
  s("bar", fmt("\\bar{{{}}}", { i(0) })),
  s("tilde", fmt("\\tilde{{{}}}", { i(0) })),

  -- Delimiters
  s("norm", fmt("\\left\\lVert {} \\right\\rVert", { i(0) })),
  s("abs", fmt("\\left\\lvert {} \\right\\rvert", { i(0) })),
  s("set", fmt("\\left\\{{ {} \\right\\}}", { i(0) })),

  -- Square root (optional nth root via choice)
  s("sqrt", c(1, {
    sn(nil, { t("\\sqrt{"), i(1), t("}") }),
    sn(nil, { t("\\sqrt["), i(1, "n"), t("]{"), i(2), t("}") }),
  })),

  -- Calculus
  s("partial", fmt("\\partial_{{{}}}", { i(0) })),
  s("nabla", t("\\nabla")),

  -- Bounds
  s("inf", fmt("\\inf_{{{}}} {}", { i(1, "x"), i(0) })),
  s("sup", fmt("\\sup_{{{}}} {}", { i(1, "x"), i(0) })),

  -- Logic
  s("forall", t("\\forall")),
  s("exists", t("\\exists")),

  -- Text in math mode
  s("text", fmt("\\text{{{}}}", { i(0) })),

  -- Cases environment
  s("cases", fmt([[\begin{{cases}}
  {} & {} \\
  {} & {}
\end{{cases}}
]], {
    i(1, "f(x)"),
    i(2, "\\text{if } x > 0"),
    i(3, "0"),
    i(0, "\\text{otherwise}"),
  })),

  -- ══════════════════════════════════════════════════
  -- MATH — ENVIRONMENTS (EXTENSIONS)
  -- ══════════════════════════════════════════════════

  -- Gather (multiple equations, centered, aligned at &)
  s("gather", fmt([[\begin{{gather}}
  {} \\
  {}
  \label{{eq:{}}}
\end{{gather}}
]], { i(1, "equation1"), i(2, "equation2"), i(0, "label") })),

  -- Multline (single long equation split across lines)
  s("multline", fmt([[\begin{{multline}}
  {} \\
  {} \\
  {}
\end{{multline}}
]], { i(1, "line1"), i(2, "line2"), i(0, "line3") })),

  -- Binomial coefficient
  s("binom", fmt("\\binom{{{}}}{{{}}}", {
    i(1, "n"),
    i(0, "k"),
  })),

  -- Determinant operator
  s("det", t("\\det")),

  -- Trace operator
  s("trace", t("\\operatorname{tr}")),

  -- Custom math operator
  s("opr", fmt("\\operatorname{{{}}}", { i(0) })),

  -- ══════════════════════════════════════════════════
  -- THEOREMS & PROOFS
  -- ══════════════════════════════════════════════════
  -- Requires \newtheorem{theorem}{Theorem} etc. in preamble (amsthm)

  s("thm", fmt([[\begin{{theorem}}[{}]
  \label{{thm:{}}}
  {}
\end{{theorem}}
]], { i(1, "name"), i(2, "label"), i(0) })),

  s("lem", fmt([[\begin{{lemma}}[{}]
  \label{{lem:{}}}
  {}
\end{{lemma}}
]], { i(1, "name"), i(2, "label"), i(0) })),

  s("prop", fmt([[\begin{{proposition}}[{}]
  \label{{prop:{}}}
  {}
\end{{proposition}}
]], { i(1, "name"), i(2, "label"), i(0) })),

  s("cor", fmt([[\begin{{corollary}}[{}]
  \label{{cor:{}}}
  {}
\end{{corollary}}
]], { i(1, "name"), i(2, "label"), i(0) })),

  s("defn", fmt([[\begin{{definition}}[{}]
  \label{{def:{}}}
  {}
\end{{definition}}
]], { i(1, "name"), i(2, "label"), i(0) })),

  s("rem", fmt([[\begin{{remark}}
  {}
\end{{remark}}
]], { i(0) })),

  s("ex", fmt([[\begin{{example}}
  {}
\end{{example}}
]], { i(0) })),

  s("pf", fmt([[\begin{{proof}}
  {}
\end{{proof}}
]], { i(0) })),

  -- QED symbol (use inside or outside proof env)
  s("qed", t("\\qed")),

  -- ══════════════════════════════════════════════════
  -- BEAMER — EXTENSIONS
  -- ══════════════════════════════════════════════════

  -- Alert text
  s("alert", fmt("\\alert{{{}}}", { i(0) })),

  -- Overlay specs
  s("only", fmt("\\only<{}>{{{}}}", { i(1, "1"), i(0) })),
  s("uncover", fmt("\\uncover<{}>{{{}}}", { i(1, "1-"), i(0) })),

  -- Speaker notes
  s("nota", fmt("\\note{{{}}}", { i(0) })),

  -- Title page frame
  s("titleframe", t([[\begin{frame}
  \titlepage
\end{frame}]])),

  -- Thank-you / closing frame
  s("thankframe", fmt([[\begin{{frame}}
  \centering
  \Huge {}
\end{{frame}}
]], { i(0, "Thank you!") })),

  -- Agenda / outline frame using tableofcontents
  s("agendaframe", fmt([[\begin{{frame}}{{{}}}
  \tableofcontents[{}]
\end{{frame}}
]], {
    i(1, "Outline"),
    c(2, { t(""), t("currentsection"), t("hideallsubsections") }),
  })),

  -- Theme selection (use Ctrl-L to cycle theme type)
  s("theme", c(1, {
    sn(nil, { t("\\usetheme{"), i(1, "Madrid"), t("}") }),
    sn(nil, { t("\\usecolortheme{"), i(1, "beaver"), t("}") }),
    sn(nil, { t("\\usefonttheme{"), i(1, "serif"), t("}") }),
  })),
}
