# LaTeX Snippet Library Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Expand `luasnippets/tex.lua` from 27 snippets to ~120 snippets covering document structure, math, theorems, Beamer, TikZ, floats, bibliography, and utilities.

**Architecture:** Single-file expansion of the existing `luasnippets/tex.lua`. New sections appended before the closing `}` on the last line. Each task adds one thematic section and commits independently. README updated in the final task.

**Tech Stack:** LuaSnip (`s`, `t`, `i`, `f`, `c`, `sn`, `fmt`, `fmta`, `rep`), Neovim headless validation.

---

## Validation Command (use after each task)

```bash
nvim --headless "+Lazy! sync" +qa 2>&1 | head -20
```

Expected output: silent or only plugin update messages (no Lua errors).

---

### Task 1: Document Structure & Preamble

**Files:**
- Modify: `luasnippets/tex.lua` — insert before closing `}` on last line

**Step 1: Open the file and locate insertion point**

The file ends with:
```lua
  -- Bibliography entry
  s("bibitem", fmt("\\bibitem{{{}}} {}", {
    i(1, "key"),
    i(0, "Author. Title. Year."),
  })),
}
```

Insert the following block between the last snippet and the closing `}`.

**Step 2: Insert Document Structure section**

```lua
  -- ══════════════════════════════════════════════════
  -- DOCUMENT STRUCTURE & PREAMBLE
  -- ══════════════════════════════════════════════════

  -- Full document skeleton
  s("doc", fmt([[
\documentclass[{}]{{{}}}

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
```

**Step 3: Validate**

```bash
nvim --headless "+Lazy! sync" +qa 2>&1 | head -20
```

Expected: no Lua errors.

**Step 4: Commit**

```bash
git add luasnippets/tex.lua
git commit -m "feat: add LaTeX document structure & preamble snippets"
```

---

### Task 2: Core Structures — Extensions

**Files:**
- Modify: `luasnippets/tex.lua`

**Step 1: Insert Core Structures Extensions section**

```lua
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
```

**Step 2: Validate**

```bash
nvim --headless "+Lazy! sync" +qa 2>&1 | head -20
```

**Step 3: Commit**

```bash
git add luasnippets/tex.lua
git commit -m "feat: add LaTeX core structure extension snippets"
```

---

### Task 3: Math — Symbols & Operators

**Files:**
- Modify: `luasnippets/tex.lua`

**Step 1: Insert Math Symbols section**

```lua
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
```

**Step 2: Validate**

```bash
nvim --headless "+Lazy! sync" +qa 2>&1 | head -20
```

**Step 3: Commit**

```bash
git add luasnippets/tex.lua
git commit -m "feat: add LaTeX math symbol snippets"
```

---

### Task 4: Math — Environments (Extensions)

**Files:**
- Modify: `luasnippets/tex.lua`

**Step 1: Insert Math Environments section**

```lua
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
```

**Step 2: Validate**

```bash
nvim --headless "+Lazy! sync" +qa 2>&1 | head -20
```

**Step 3: Commit**

```bash
git add luasnippets/tex.lua
git commit -m "feat: add LaTeX math environment extension snippets"
```

---

### Task 5: Theorems & Proofs

**Files:**
- Modify: `luasnippets/tex.lua`

**Step 1: Insert Theorems & Proofs section**

Note: theorem environments assume `\newtheorem` declarations in preamble (e.g., from `amsthm`).

```lua
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
```

**Step 2: Validate**

```bash
nvim --headless "+Lazy! sync" +qa 2>&1 | head -20
```

**Step 3: Commit**

```bash
git add luasnippets/tex.lua
git commit -m "feat: add LaTeX theorem and proof snippets"
```

---

### Task 6: Beamer — Extensions

**Files:**
- Modify: `luasnippets/tex.lua`

**Step 1: Insert Beamer Extensions section**

```lua
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
```

**Step 2: Validate**

```bash
nvim --headless "+Lazy! sync" +qa 2>&1 | head -20
```

**Step 3: Commit**

```bash
git add luasnippets/tex.lua
git commit -m "feat: add Beamer extension snippets"
```

---

### Task 7: TikZ — Extensions

**Files:**
- Modify: `luasnippets/tex.lua`

**Step 1: Insert TikZ Extensions section**

```lua
  -- ══════════════════════════════════════════════════
  -- TIKZ — EXTENSIONS
  -- ══════════════════════════════════════════════════

  -- Arrow path
  s("arrow", fmt("\\draw[->, {}] ({}) -- ({});", {
    c(1, { t("thick"), t("very thick"), t("thin"), i(nil, "style") }),
    i(2, "0,0"),
    i(0, "1,0"),
  })),

  -- Shapes
  s("circle", fmt("\\draw[{}] ({}) circle ({});", {
    i(1, ""),
    i(2, "0,0"),
    i(0, "1cm"),
  })),
  s("rect", fmt("\\draw[{}] ({}) rectangle ({});", {
    i(1, ""),
    i(2, "0,0"),
    i(0, "2,1"),
  })),

  -- Grid
  s("grid", fmt("\\draw[step={}, {}] ({}) grid ({});", {
    i(1, "1"),
    c(2, { t("gray, very thin"), t("gray!50"), i(nil, "style") }),
    i(3, "0,0"),
    i(0, "4,4"),
  })),

  -- Clip scope
  s("clip", fmt([[\begin{{scope}}
  \clip ({}) rectangle ({});
  {}
\end{{scope}}
]], { i(1, "0,0"), i(2, "4,4"), i(0) })),

  -- Foreach loop
  s("foreach", fmt("\\foreach \\{} in {{{}}} {{{}}}", {
    i(1, "x"),
    i(2, "1,...,5"),
    i(0),
  })),

  -- Scope with options
  s("scope", fmt([[\begin{{scope}}[{}]
  {}
\end{{scope}}
]], { i(1, "xshift=2cm"), i(0) })),

  -- Coordinate definition
  s("coord", fmt("\\coordinate ({}) at ({});", {
    i(1, "name"),
    i(0, "0,0"),
  })),

  -- pgfplots axis (requires pgfplots package)
  s("axis", fmt([[\begin{{tikzpicture}}
\begin{{axis}}[
  xlabel={{{}}},
  ylabel={{{}}},
  {}
]
  {}
\end{{axis}}
\end{{tikzpicture}}
]], {
    i(1, "$x$"),
    i(2, "$y$"),
    i(3, "grid=major"),
    i(0, "% \\addplot commands here"),
  })),

  -- Flowchart node box
  s("flowbox", fmt("\\node[rectangle, draw, {}] ({}) at ({}) {{{}}};", {
    c(1, { t("rounded corners"), t("fill=blue!20, rounded corners"), i(nil, "style") }),
    i(2, "name"),
    i(3, "0,0"),
    i(0, "text"),
  })),
```

**Step 2: Validate**

```bash
nvim --headless "+Lazy! sync" +qa 2>&1 | head -20
```

**Step 3: Commit**

```bash
git add luasnippets/tex.lua
git commit -m "feat: add TikZ extension snippets"
```

---

### Task 8: Figures, Tables & Floats — Extensions

**Files:**
- Modify: `luasnippets/tex.lua`

**Step 1: Insert Floats Extensions section**

```lua
  -- ══════════════════════════════════════════════════
  -- FIGURES, TABLES & FLOATS — EXTENSIONS
  -- ══════════════════════════════════════════════════

  -- Subfigure layout (requires subcaption package)
  s("subfig", fmt([[\begin{{figure}}[{}]
  \centering
  \begin{{subfigure}}[b]{{{}\\textwidth}}
    \centering
    \includegraphics[width=\\textwidth]{{{}}}
    \caption{{{}}}
    \label{{fig:{}}}
  \end{{subfigure}}
  \hfill
  \begin{{subfigure}}[b]{{{}\\textwidth}}
    \centering
    \includegraphics[width=\\textwidth]{{{}}}
    \caption{{{}}}
    \label{{fig:{}}}
  \end{{subfigure}}
  \caption{{{}}}
  \label{{fig:{}}}
\end{{figure}}
]], {
    i(1, "htbp"),
    i(2, "0.45"), i(3, "image1"), i(4, "Left caption"), i(5, "left"),
    i(6, "0.45"), i(7, "image2"), i(8, "Right caption"), i(9, "right"),
    i(10, "Overall caption"), i(0, "main"),
  })),

  -- Wrapfigure (requires wrapfig package)
  s("wrapfig", fmt([[\begin{{wrapfigure}}{{{}}}{{{}\\textwidth}}
  \centering
  \includegraphics[width=\\textwidth]{{{}}}
  \caption{{{}}}
  \label{{fig:{}}}
\end{{wrapfigure}}
]], {
    c(1, { t("r"), t("l"), t("R"), t("L") }),
    i(2, "0.4"),
    i(3, "image"),
    i(4, "Caption"),
    i(0, "label"),
  })),

  -- Longtable (requires longtable + booktabs)
  s("longtab", fmt([[\begin{{longtable}}{{{}}}
  \caption{{{}}} \label{{tab:{}}} \\
  \toprule
  {} \\
  \midrule
  \endfirsthead
  \multicolumn{{{}}}{{c}}{{\tablename\ \thetable\ -- continued}} \\
  \toprule
  {} \\
  \midrule
  \endhead
  \bottomrule
  \endlastfoot
  {}
\end{{longtable}}
]], {
    i(1, "l|c|r"),
    i(2, "Caption"), i(3, "label"),
    i(4, "Col1 & Col2 & Col3"),
    i(5, "3"),
    i(6, "Col1 & Col2 & Col3"),
    i(0, "data & data & data \\\\"),
  })),

  -- Booktabs-style table (requires booktabs package)
  s("booktab", fmt([[\begin{{table}}[{}]
  \centering
  \begin{{tabular}}{{{}}}
    \toprule
    {} \\
    \midrule
    {} \\
    \bottomrule
  \end{{tabular}}
  \caption{{{}}}
  \label{{tab:{}}}
\end{{table}}
]], {
    i(1, "htbp"),
    i(2, "lcc"),
    i(3, "Header1 & Header2 & Header3"),
    i(4, "Data1 & Data2 & Data3"),
    i(5, "Caption"),
    i(0, "label"),
  })),

  -- Multirow (requires multirow package)
  s("mrow", fmt("\\multirow{{{}}}{{{}}}{{{}}}", {
    i(1, "2"),
    c(2, { t("*"), i(nil, "width") }),
    i(0, "content"),
  })),

  -- Multicolumn
  s("mcol", fmt("\\multicolumn{{{}}}{{{}}}{{{}}}", {
    i(1, "2"),
    c(2, { t("c"), t("l"), t("r") }),
    i(0, "content"),
  })),

  -- Sidewaysfigure (requires rotating package)
  s("sideways", fmt([[\begin{{sidewaysfigure}}
  \centering
  \includegraphics[width={}\\textheight]{{{}}}
  \caption{{{}}}
  \label{{fig:{}}}
\end{{sidewaysfigure}}
]], {
    i(1, "0.8"),
    i(2, "image"),
    i(3, "Caption"),
    i(0, "label"),
  })),

  -- Minted code block (requires minted package + --shell-escape compile flag)
  s("minted", fmt([[\begin{{minted}}[linenos, frame=lines, {}]{{{}}}
{}
\end{{minted}}
]], {
    i(1, "fontsize=\\small"),
    c(2, { t("python"), t("cpp"), t("bash"), t("latex"), i(nil, "lang") }),
    i(0, "% code here"),
  })),
```

**Step 2: Validate**

```bash
nvim --headless "+Lazy! sync" +qa 2>&1 | head -20
```

**Step 3: Commit**

```bash
git add luasnippets/tex.lua
git commit -m "feat: add LaTeX float and table extension snippets"
```

---

### Task 9: Bibliography & Cross-references — Extensions

**Files:**
- Modify: `luasnippets/tex.lua`

**Step 1: Insert Bibliography Extensions section**

```lua
  -- ══════════════════════════════════════════════════
  -- BIBLIOGRAPHY & CROSS-REFERENCES — EXTENSIONS
  -- ══════════════════════════════════════════════════

  -- Equation reference (parenthesized)
  s("eqref", fmt("\\eqref{{{}}}", { i(0) })),

  -- Hyperref autoref (uses type prefix automatically)
  s("autoref", fmt("\\autoref{{{}}}", { i(0) })),

  -- Cleveref (requires cleveref package, load after hyperref)
  s("cref", fmt("\\cref{{{}}}", { i(0) })),

  -- biblatex author/year citations
  s("citeauthor", fmt("\\citeauthor{{{}}}", { i(0) })),
  s("citeyear", fmt("\\citeyear{{{}}}", { i(0) })),

  -- Print bibliography (biblatex style, with optional title override)
  s("printbib", c(1, {
    sn(nil, { t("\\printbibliography") }),
    sn(nil, { t("\\printbibliography[title={"), i(1, "References"), t("}]") }),
  })),

  -- Legacy thebibliography environment
  s("biblio", fmt([[\begin{{thebibliography}}{{{}}}
  \bibitem{{{}}} {}
\end{{thebibliography}}
]], {
    i(1, "99"),
    i(2, "key"),
    i(0, "Author. Title. Year."),
  })),

  -- Foot citation (biblatex)
  s("footcite", fmt("\\footcite{{{}}}", { i(0) })),
```

**Step 2: Validate**

```bash
nvim --headless "+Lazy! sync" +qa 2>&1 | head -20
```

**Step 3: Commit**

```bash
git add luasnippets/tex.lua
git commit -m "feat: add LaTeX bibliography and cross-reference snippets"
```

---

### Task 10: Common Packages & Utilities

**Files:**
- Modify: `luasnippets/tex.lua`

**Step 1: Insert Utilities section**

```lua
  -- ══════════════════════════════════════════════════
  -- COMMON PACKAGES & UTILITIES
  -- ══════════════════════════════════════════════════

  -- TODO marker (requires todonotes package)
  s("todo", fmt("\\todo{{{}}}", { i(0) })),

  -- Margin note
  s("note", fmt("\\marginpar{{{}}}", { i(0) })),

  -- Verbatim environment
  s("verb", fmt([[\begin{{verbatim}}
{}
\end{{verbatim}}
]], { i(0) })),

  -- URL (requires hyperref or url package)
  s("url", fmt("\\url{{{}}}", { i(0) })),

  -- Email hyperlink
  s("email", fmt("\\href{{mailto:{}}}{{{}}}", {
    i(1, "user@example.com"),
    i(0, "user@example.com"),
  })),

  -- SI unit value (requires siunitx package)
  s("SI", fmt("\\SI{{{}}}{{{}}}", {
    i(1, "1.0"),
    c(2, { t("\\meter"), t("\\kilogram"), t("\\second"), t("\\kelvin"), t("\\joule"), i(nil, "unit") }),
  })),

  -- Number (siunitx formatting)
  s("num", fmt("\\num{{{}}}", { i(0) })),

  -- Angle (siunitx)
  s("deg", fmt("\\ang{{{}}}", { i(0) })),

  -- Comment environment (requires comment package)
  s("comment", fmt([[\begin{{comment}}
{}
\end{{comment}}
]], { i(0) })),

  -- Lipsum placeholder text
  s("lipsum", fmt("\\lipsum[{}]", {
    c(1, { t("1"), t("1-3"), t("1-5"), i(nil, "n") }),
  })),
```

**Step 2: Validate**

```bash
nvim --headless "+Lazy! sync" +qa 2>&1 | head -20
```

**Step 3: Commit**

```bash
git add luasnippets/tex.lua
git commit -m "feat: add LaTeX utility snippets (siunitx, todonotes, verbatim, etc.)"
```

---

### Task 11: Update README

**Files:**
- Modify: `luasnippets/README.md`

**Step 1: Replace the LaTeX Snippets section**

The README currently documents 27 snippets across 5 subsections. Replace the entire `## LaTeX Snippets` section with the expanded version covering all 10 sections and ~120 triggers.

New content to replace from `## LaTeX Snippets` to the next `##` heading:

```markdown
## LaTeX Snippets (`tex.lua`)

### Document Structure & Preamble
| Trigger | Description |
|---------|-------------|
| `doc` | Full document skeleton with class, packages, title, body |
| `pkg` | `\usepackage{}` (choice: with/without options) |
| `class` | `\documentclass[opts]{class}` with choice nodes |
| `title` | `\title{}` |
| `author` | `\author{}` |
| `date` | `\date{\today}` or custom date |
| `maketitle` | `\maketitle` |
| `toc` | `\tableofcontents` |
| `newcmd` | `\newcommand{\name}[args]{def}` |
| `renewcmd` | `\renewcommand{\name}[args]{def}` |
| `newenv` | `\newenvironment{name}{begin}{end}` |
| `abstract` | abstract environment |

### Core Structures
| Trigger | Description |
|---------|-------------|
| `beg` | Environment with smart `\item` insertion |
| `item` | `\item` |
| `itemd` | `\item[label]` |
| `sec` / `ssec` / `sssec` | Section levels |
| `lab` / `ref` / `cite` | Labels and references |
| `par` | `\paragraph{}` |
| `noind` | `\noindent` |
| `vsp` / `hsp` | Vertical / horizontal space with choices |
| `newpage` | `\newpage` |
| `appendix` | `\appendix` + first section |
| `minipage` | minipage environment |
| `center` | center environment |

### Math — Symbols & Operators
| Trigger | Description |
|---------|-------------|
| `mm` | Inline math `$...$` |
| `dm` | Display math `\[...\]` |
| `lim` | `\lim_{x \to \infty}` |
| `prod` | `\prod_{i}^{n}` |
| `vec` | `\vec{}` |
| `hat` | `\hat{}` |
| `bar` | `\bar{}` |
| `tilde` | `\tilde{}` |
| `norm` | `\left\lVert \right\rVert` |
| `abs` | `\left\lvert \right\rvert` |
| `set` | `\left\{ \right\}` |
| `sqrt` | `\sqrt{}` or `\sqrt[n]{}` |
| `partial` | `\partial_{}` |
| `nabla` | `\nabla` |
| `inf` / `sup` | Infimum / supremum |
| `forall` / `exists` | Quantifiers |
| `text` | `\text{}` |
| `cases` | cases environment |

### Math — Environments
| Trigger | Description |
|---------|-------------|
| `eq` | equation with label |
| `align` | align environment |
| `frac` | `\frac{num}{den}` |
| `sum` | `\sum_{i}^{n}` |
| `int` | `\int_{a}^{b}` |
| `mat` | Matrix (pmatrix/bmatrix/etc.) |
| `gr` | Greek letter choice node |
| `gather` | gather environment |
| `multline` | multline environment |
| `binom` | `\binom{n}{k}` |
| `det` | `\det` |
| `trace` | `\operatorname{tr}` |
| `opr` | `\operatorname{}` |

### Theorems & Proofs
| Trigger | Description |
|---------|-------------|
| `thm` | theorem environment with label |
| `lem` | lemma environment with label |
| `prop` | proposition environment with label |
| `cor` | corollary environment with label |
| `defn` | definition environment with label |
| `rem` | remark environment |
| `ex` | example environment |
| `pf` | proof environment |
| `qed` | `\qed` |

### Beamer
| Trigger | Description |
|---------|-------------|
| `frame` | Beamer frame |
| `block` | Beamer block |
| `cols` | Two-column layout |
| `pause` | `\pause` |
| `alert` | `\alert{}` |
| `only` / `uncover` | Overlay specs |
| `nota` | `\note{}` |
| `titleframe` | Title page frame |
| `thankframe` | Closing thank-you frame |
| `agendaframe` | Outline frame with `\tableofcontents` |
| `theme` | `\usetheme{}` / `\usecolortheme{}` / `\usefonttheme{}` |

### TikZ
| Trigger | Description |
|---------|-------------|
| `tikz` | tikzpicture environment |
| `node` | `\node[...] (name) at (x,y) {text};` |
| `draw` | `\draw[...] -- ;` |
| `fill` | `\fill[...] rectangle;` |
| `arrow` | `\draw[->] -- ;` |
| `circle` | `\draw circle` |
| `rect` | `\draw rectangle` |
| `grid` | `\draw grid` |
| `clip` | Clip scope |
| `foreach` | `\foreach \x in {...}` |
| `scope` | scope environment |
| `coord` | `\coordinate` |
| `axis` | pgfplots axis environment |
| `flowbox` | Flowchart rectangle node |

### Figures, Tables & Floats
| Trigger | Description |
|---------|-------------|
| `fig` | figure with includegraphics |
| `tab` | table with tabular |
| `code` | listings code block |
| `subfig` | Two-subfigure layout |
| `wrapfig` | wrapfigure environment |
| `longtab` | longtable environment |
| `booktab` | booktabs-style table |
| `mrow` | `\multirow{}{}{}` |
| `mcol` | `\multicolumn{}{}{}` |
| `sideways` | sidewaysfigure environment |
| `minted` | minted code block |

### Bibliography & Cross-references
| Trigger | Description |
|---------|-------------|
| `lab` / `ref` / `cite` | Core references |
| `eqref` | `\eqref{}` |
| `autoref` | `\autoref{}` |
| `cref` | `\cref{}` (cleveref) |
| `citeauthor` / `citeyear` | biblatex author/year |
| `printbib` | `\printbibliography` |
| `biblio` | thebibliography environment |
| `footcite` | `\footcite{}` |
| `href` | `\href{url}{text}` |
| `bibitem` | `\bibitem{key}` |

### Common Packages & Utilities
| Trigger | Description |
|---------|-------------|
| `todo` | `\todo{}` (todonotes) |
| `note` | `\marginpar{}` |
| `verb` | verbatim environment |
| `url` | `\url{}` |
| `email` | `\href{mailto:...}{...}` |
| `SI` | `\SI{value}{unit}` (siunitx) |
| `num` | `\num{}` (siunitx) |
| `deg` | `\ang{}` (siunitx) |
| `comment` | comment environment |
| `lipsum` | `\lipsum[n]` placeholder |
```

**Step 2: Validate**

```bash
nvim --headless "+Lazy! sync" +qa 2>&1 | head -20
```

**Step 3: Commit**

```bash
git add luasnippets/README.md
git commit -m "docs: update LaTeX snippet README with all 120+ triggers"
```

---

## Final Verification

After all tasks complete, do a manual spot-check in Neovim:

1. Open a `.tex` buffer: `nvim test.tex`
2. Type `doc` and press Tab → should expand to full document skeleton
3. Type `thm` and Tab → theorem environment with label
4. Type `booktab` and Tab → booktabs table
5. Type `axis` and Tab → pgfplots axis stub
6. Verify choice nodes work: type `beg` + Tab, then `Ctrl-L` to cycle environment types
