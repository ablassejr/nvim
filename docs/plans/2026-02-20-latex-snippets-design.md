# LaTeX Snippet Library Expansion — Design Document

**Date**: 2026-02-20
**Status**: Approved
**Scope**: Expand `luasnippets/tex.lua` from 27 → ~120 snippets

---

## Goal

Build a comprehensive LuaSnip snippet library for LaTeX covering all major
document types: academic papers, presentations (Beamer), technical reports,
and math-heavy documents.

---

## Architecture Decision

**Single expanded file** (`luasnippets/tex.lua`). Consistent with `python.lua`
and `cpp.lua` patterns. No new loader infrastructure required. Sections
delimited by `═══` comment banners. A comment-block table of contents is
placed at the top of the file for navigation.

Companion update: `luasnippets/README.md` updated to reflect all new triggers.

---

## Sections & Snippet Inventory

### 1. Document Structure & Preamble (~12 snippets)

| Trigger    | Description                                      |
|------------|--------------------------------------------------|
| `doc`      | Full document skeleton (class + packages + body) |
| `pkg`      | `\usepackage{}`                                  |
| `class`    | `\documentclass[opts]{class}` with choice node   |
| `title`    | `\title{}`                                       |
| `author`   | `\author{}`                                      |
| `date`     | `\date{}`                                        |
| `maketitle`| `\maketitle`                                     |
| `toc`      | `\tableofcontents`                               |
| `newcmd`   | `\newcommand{\name}[args]{def}`                  |
| `renewcmd` | `\renewcommand{\name}[args]{def}`                |
| `newenv`   | `\newenvironment{name}{begin}{end}`              |
| `abstract` | abstract environment                             |

### 2. Core Structures — Expanded (~8 snippets added)

Existing: `beg`, `item`, `itemd`, `sec`, `ssec`, `sssec`, `lab`, `ref`, `cite`

| Trigger    | Description                     |
|------------|---------------------------------|
| `par`      | `\paragraph{}`                  |
| `noind`    | `\noindent`                     |
| `vsp`      | `\vspace{}`                     |
| `hsp`      | `\hspace{}`                     |
| `newpage`  | `\newpage`                      |
| `appendix` | `\appendix` + section           |
| `minipage` | minipage environment            |
| `center`   | center environment              |

### 3. Math — Symbols & Operators (~18 snippets, new section)

| Trigger    | Description                            |
|------------|----------------------------------------|
| `lim`      | `\lim_{x \to}`                         |
| `prod`     | `\prod_{i}^{n}`                        |
| `vec`      | `\vec{}`                               |
| `hat`      | `\hat{}`                               |
| `bar`      | `\bar{}`                               |
| `tilde`    | `\tilde{}`                             |
| `norm`     | `\left\lVert \right\rVert`             |
| `abs`      | `\left\lvert \right\rvert`             |
| `set`      | `\left\{ \right\}`                     |
| `sqrt`     | `\sqrt{}`                              |
| `partial`  | `\partial`                             |
| `nabla`    | `\nabla`                               |
| `inf`      | `\inf`                                 |
| `sup`      | `\sup`                                 |
| `forall`   | `\forall`                              |
| `exists`   | `\exists`                              |
| `text`     | `\text{}` (text in math mode)          |
| `cases`    | cases environment                      |

### 4. Math — Environments (~6 snippets, expand existing)

Existing: `mm`, `dm`, `eq`, `align`, `frac`, `sum`, `int`, `mat`, `gr`

| Trigger    | Description                     |
|------------|---------------------------------|
| `gather`   | gather environment              |
| `multline` | multline environment            |
| `binom`    | `\binom{n}{k}`                  |
| `det`      | `\det`                          |
| `trace`    | `\operatorname{tr}`             |
| `opr`      | `\operatorname{}`               |

### 5. Theorems & Proofs (~9 snippets, new section)

| Trigger | Description              |
|---------|--------------------------|
| `thm`   | theorem environment      |
| `lem`   | lemma environment        |
| `prop`  | proposition environment  |
| `cor`   | corollary environment    |
| `defn`  | definition environment   |
| `rem`   | remark environment       |
| `ex`    | example environment      |
| `pf`    | proof environment        |
| `qed`   | `\qed` / `\hfill\square` |

### 6. Beamer — Expanded (~8 snippets added)

Existing: `frame`, `block`, `cols`, `pause`

| Trigger      | Description                              |
|--------------|------------------------------------------|
| `alert`      | `\alert{}`                               |
| `only`       | `\only<>{}`                              |
| `uncover`    | `\uncover<>{}`                           |
| `nota`       | `\note{}`                                |
| `titleframe` | title frame with `\titlepage`            |
| `thankframe` | thank-you closing frame                  |
| `agendaframe`| agenda/outline frame using `\tableofcontents` |
| `theme`      | `\usetheme{}` with choice node           |

### 7. TikZ — Expanded (~10 snippets added)

Existing: `tikz`, `node`, `draw`, `fill`

| Trigger    | Description                            |
|------------|----------------------------------------|
| `arrow`    | `\draw[->, thick]`                     |
| `circle`   | `\draw circle`                         |
| `rect`     | `\draw rectangle`                      |
| `grid`     | `\draw[step=] grid`                    |
| `clip`     | `\begin{scope}\clip ... \end{scope}`   |
| `foreach`  | `\foreach \x in {...}`                 |
| `scope`    | scope environment with options         |
| `coord`    | `\coordinate (name) at (x,y);`         |
| `axis`     | pgfplots axis environment stub         |
| `flowbox`  | rectangular flowchart node with label  |

### 8. Figures, Tables & Floats — Expanded (~8 snippets added)

Existing: `fig`, `tab`, `code`

| Trigger    | Description                                      |
|------------|--------------------------------------------------|
| `subfig`   | subfigure inside figure environment              |
| `wrapfig`  | wrapfigure environment                           |
| `longtab`  | longtable environment                            |
| `booktab`  | table with `\toprule`/`\midrule`/`\bottomrule`   |
| `mrow`     | `\multirow{}{}{}`                                |
| `mcol`     | `\multicolumn{}{}{}`                             |
| `sideways` | sidewaysfigure environment                       |
| `minted`   | minted code block (alt to listings)              |

### 9. Bibliography & Cross-references — Expanded (~8 snippets added)

Existing: `cite`, `ref`, `lab`

| Trigger        | Description                          |
|----------------|--------------------------------------|
| `eqref`        | `\eqref{}`                           |
| `autoref`      | `\autoref{}`                         |
| `cref`         | `\cref{}`                            |
| `citeauthor`   | `\citeauthor{}`                      |
| `citeyear`     | `\citeyear{}`                        |
| `printbib`     | `\printbibliography`                 |
| `biblio`       | thebibliography environment          |
| `footcite`     | `\footcite{}`                        |

### 10. Common Packages & Utilities (~10 snippets, new section)

Existing: `href`, `bibitem`

| Trigger  | Description                          |
|----------|--------------------------------------|
| `todo`   | `\todo{}`                            |
| `note`   | `\marginpar{}`                       |
| `verb`   | verbatim environment                 |
| `url`    | `\url{}`                             |
| `email`  | `\href{mailto:...}{...}`             |
| `SI`     | `\SI{}{unit}` (siunitx)              |
| `num`    | `\num{}` (siunitx)                   |
| `deg`    | `\ang{}` (siunitx)                   |
| `comment`| comment environment                  |
| `lipsum` | `\lipsum[1]` placeholder             |

---

## Summary Counts

| Section                        | Existing | New | Total |
|-------------------------------|----------|-----|-------|
| Document Structure & Preamble  | 0        | 12  | 12    |
| Core Structures                | 9        | 8   | 17    |
| Math — Symbols & Operators     | 0        | 18  | 18    |
| Math — Environments            | 9        | 6   | 15    |
| Theorems & Proofs              | 0        | 9   | 9     |
| Beamer                         | 4        | 8   | 12    |
| TikZ                           | 4        | 10  | 14    |
| Figures, Tables & Floats       | 3        | 8   | 11    |
| Bibliography & Cross-refs      | 3        | 8   | 11    |
| Common Packages & Utilities    | 2        | 10  | 12    |
| **Total**                      | **34**   | **97** | **131** |

---

## Implementation Notes

- All snippets use `fmt()` with `{}` delimiters or `fmta()` with `<>` delimiters — consistent with existing file
- Choice nodes (`c()`) for variants (e.g., document class, matrix type, Beamer theme)
- Function nodes (`f()`) for mirrored content (e.g., `\end{env}` mirrors `\begin{env}`)
- `rep()` for repeated insert node values
- Theorem environments assume `\newtheorem` definitions in preamble (noted in snippet comments)
- pgfplots axis snippet requires `pgfplots` package (noted inline)

---

## Files Modified

1. `luasnippets/tex.lua` — primary implementation
2. `luasnippets/README.md` — updated trigger reference tables
