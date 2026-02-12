# LuaSnip Snippet System Design

**Date:** 2026-02-12
**Status:** Approved
**Author:** Claude Code

## Overview

Complete redesign of the Neovim snippet system, migrating from a hybrid Snipmate/LuaSnip approach to a pure LuaSnip implementation. This design focuses on comprehensive coverage across four languages (Python, JavaScript, C++, LaTeX) with intelligent features leveraging LuaSnip's advanced capabilities.

## Goals

1. **Comprehensive Coverage** - Mix of common patterns, framework-specific snippets, documentation templates, and project scaffolding
2. **Research-Driven Quality** - Snippets based on modern best practices from web search and context7 documentation
3. **Intelligent Expansion** - Leverage choice nodes, dynamic nodes, and function nodes for context-aware insertion
4. **Single Format** - Pure LuaSnip for easier maintenance and maximum flexibility

## Architecture

### File Structure

```
~/.config/nvim/
├── luasnippets/
│   ├── all.lua           # Global snippets (unchanged)
│   ├── python.lua        # Python snippets (replaced)
│   ├── javascript.lua    # JavaScript snippets (replaced)
│   ├── cpp.lua           # C++ snippets (new)
│   ├── tex.lua           # LaTeX snippets (replaced)
│   └── README.md         # Documentation (updated)
└── snippets/             # DELETED - entire directory removed
```

### Internal Organization

Each `.lua` file organized with clear comment sections:

```lua
-- ══════════════════════════════════════════════════
-- CATEGORY NAME
-- ══════════════════════════════════════════════════

-- Individual snippets with descriptive comments
```

Categories per language:
- **Core Language** - basic syntax, control flow, functions
- **Framework-Specific** - FastAPI, React, Express, STL, etc.
- **Documentation** - docstrings, JSDoc, Doxygen, LaTeX comments
- **Common Patterns** - error handling, async patterns, idioms
- **Advanced Features** - generics, decorators, templates, modern language features

### Loading Behavior

- LuaSnip auto-loads all `.lua` files from `luasnippets/`
- No configuration changes needed in `blink.cmp.lua`
- Snippets available immediately on filetype detection

## Advanced Features Strategy

### 1. Choice Nodes (Ctrl-L/H to cycle)

Used for variants of the same pattern:

```lua
-- Example: HTTP method selection in FastAPI
c(1, {
  t("get"),
  t("post"),
  t("put"),
  t("delete"),
})
```

### 2. Dynamic Nodes

Context-aware insertion based on user input:

```lua
-- Example: Auto-add async/await based on function type
-- If user chooses "async", automatically insert "await" patterns
```

### 3. Function Nodes

Auto-generate content:

```lua
-- Dates: os.date("%Y-%m-%d")
-- Filenames: vim.fn.expand("%:t:r")
-- Smart defaults: infer class name from filename
-- Repeat with transforms: uppercase, camelCase, snake_case
```

### 4. Format Strings (fmt)

Clean, readable syntax using placeholders:

```lua
fmt([[
function {}({}) {{
  {}
}}
]], { i(1), i(2), i(0) })
```

### 5. Smart Defaults

- Common variable names pre-filled (but editable)
- Type hints with popular types in choice nodes
- Framework imports auto-included where needed

### Complexity Principle

- **Simple snippets stay simple** - basic loops, conditionals use minimal features
- **Complex patterns get full treatment** - API routes, class definitions, test suites leverage all advanced features

## Language-Specific Coverage

### Python (`python.lua`)

**Priority Frameworks:** FastAPI, pytest

**Categories:**
1. **Core Patterns** - functions, classes, decorators, comprehensions, context managers
2. **FastAPI** - routes (all HTTP methods), dependencies, middleware, Pydantic models, background tasks
3. **Testing** - pytest fixtures, parametrize, async tests, mocking
4. **Type Hints** - generics, protocols, TypedDict, common types with choice nodes
5. **Documentation** - Google/NumPy/Sphinx style docstrings
6. **Async Patterns** - async/await, asyncio patterns, async context managers

**Estimated Count:** 60-80 snippets

### JavaScript (`javascript.lua`)

**Priority Frameworks:** React, Express, Node.js

**Categories:**
1. **Core Patterns** - functions (arrow/regular with choice), classes, promises, destructuring
2. **React** - components (functional/class), hooks (useState, useEffect, custom), props/types
3. **Express/Node.js** - routes, middleware, error handlers, async patterns
4. **Modern ES6+** - modules, template literals, spread/rest, optional chaining
5. **Documentation** - JSDoc with types, inline comments
6. **Testing** - Jest/Vitest patterns, describe/test blocks, mocking

**Estimated Count:** 50-70 snippets

### C++ (`cpp.lua`)

**Approach:** Research-driven, modern C++ focus

**Categories:**
1. **Core Patterns** - functions, classes, templates, namespaces, control flow
2. **Modern C++** - smart pointers, lambdas, auto/decltype, constexpr, structured bindings
3. **STL** - containers, algorithms, iterators with modern patterns
4. **Memory Management** - RAII patterns, move semantics
5. **Documentation** - Doxygen comments
6. **Best Practices** - rule of 5, const correctness, modern idioms

**Estimated Count:** 50-70 snippets

### LaTeX (`tex.lua`)

**Approach:** Research-driven, expand existing smart environment snippet

**Categories:**
1. **Core Structures** - environments (keep smart \item insertion), sections, references
2. **Math** - equations, align, common symbols, matrices, theorems
3. **Beamer** - frames, blocks, overlays, themes
4. **TikZ** - common shapes, paths, plots
5. **Documentation** - comments, labels, bibliography patterns
6. **Common Packages** - graphicx, hyperref, listings usage

**Estimated Count:** 40-60 snippets

## Implementation Plan

### Phase 1: Research

**Web Search Sources:**
- "best LuaSnip snippets for [language]"
- "[framework] common patterns and boilerplate"
- Modern best practices (2024-2026)
- Community snippet collections (GitHub, Reddit r/neovim)

**Context7 Sources:**
- FastAPI official documentation
- React documentation
- Express.js documentation
- C++ reference (cppreference.com patterns)
- LaTeX package documentation (CTAN)

### Phase 2: Clean Slate

**Delete:**
- Entire `snippets/` directory (all Snipmate `.snippets` files)
- Existing `luasnippets/python.lua`
- Existing `luasnippets/javascript.lua`
- Existing `luasnippets/tex.lua`

**Keep:**
- `luasnippets/all.lua` (global snippets)
- `luasnippets/README.md` (will be updated)

### Phase 3: Creation

**Build Order:**
1. **Core patterns first** - establish foundation for each language
2. **Framework-specific** - add FastAPI, React, Express patterns
3. **Documentation** - docstrings, JSDoc, Doxygen
4. **Advanced features** - complex patterns using dynamic/choice nodes

**Consistency:**
- Use same comment structure across all files
- Follow same naming conventions for triggers
- Document each snippet with description
- Group related snippets together

### Phase 4: Documentation

**Update `luasnippets/README.md`:**
- Trigger reference table for each language
- Examples of advanced features in action
- Migration notes (Snipmate trigger changes if any)
- Keybinding reminder (Tab, Shift-Tab, Ctrl-L, Ctrl-H)

### Phase 5: Validation

**Testing Checklist:**
- [ ] All snippets expand without Lua errors
- [ ] Choice nodes cycle correctly with Ctrl-L/H
- [ ] Dynamic nodes generate appropriate content
- [ ] Function nodes produce expected output
- [ ] No trigger conflicts within same filetype
- [ ] Snippets work in all four languages

**Quality Checks:**
- [ ] Triggers are intuitive and memorable
- [ ] Smart defaults are sensible
- [ ] Documentation is accurate
- [ ] Code follows language best practices

## Deliverables

1. **Four comprehensive LuaSnip files:**
   - `python.lua` (60-80 snippets)
   - `javascript.lua` (50-70 snippets)
   - `cpp.lua` (50-70 snippets)
   - `tex.lua` (40-60 snippets)

2. **Updated documentation:**
   - `README.md` with complete trigger reference

3. **Clean repository:**
   - No Snipmate remnants
   - Organized file structure
   - Clear commit history

4. **Git commit:**
   - Descriptive message documenting the migration
   - All changes in single atomic commit

## Success Criteria

1. **Completeness** - All four languages have comprehensive snippet coverage
2. **Quality** - Snippets reflect modern best practices and common patterns
3. **Usability** - Triggers are intuitive, expansion is smooth
4. **Maintainability** - Single format, well-organized, easy to extend
5. **Documentation** - Clear reference for all available snippets

## Future Enhancements

*Not in scope for initial implementation:*

- Additional language support (TypeScript, Rust, Go)
- Project-specific snippet collections
- Snippet performance profiling
- Auto-snippet from templates
- Integration with snippet sharing platforms

## Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| Research yields insufficient patterns | Low coverage | Supplement with GPT-4 generated patterns based on documentation |
| Trigger conflicts between snippets | User confusion | Careful trigger naming, testing, conflict detection |
| Performance degradation with many snippets | Slower completion | Profile with LuaSnip lazy loading if needed |
| User muscle memory from old triggers | Temporary friction | Document trigger changes in README |

## Conclusion

This design establishes a modern, comprehensive, and maintainable snippet system leveraging LuaSnip's full capabilities. By consolidating to a single format and using research-driven best practices, we create a powerful productivity tool that grows with the user's needs.
