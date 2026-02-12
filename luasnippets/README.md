# LuaSnip Snippets

Comprehensive LuaSnip snippet collection for Python, JavaScript, C++, and LaTeX.

## Quick Reference

**Keybindings:**
- `Tab` - Expand snippet or jump to next tabstop
- `Shift-Tab` - Jump to previous tabstop
- `Ctrl-L` - Cycle choice node forward
- `Ctrl-H` - Cycle choice node backward

## Python Snippets (`python.lua`)

### Core Patterns
| Trigger | Description |
|---------|-------------|
| `def` | Function with type hints |
| `fn` | Function with sync/async choice |
| `cls` | Class definition |

### FastAPI
| Trigger | Description |
|---------|-------------|
| `route` | API route with HTTP method choice |
| `pydantic` | Pydantic model with validator |
| `depend` | FastAPI dependency |

### Testing (pytest)
| Trigger | Description |
|---------|-------------|
| `param` | Pytest parametrize decorator |
| `fixture` | Pytest fixture |
| `atest` | Async test |

### Type Hints
| Trigger | Description |
|---------|-------------|
| `hint` | Type annotation with common types |
| `protocol` | Protocol class definition |

### Documentation
| Trigger | Description |
|---------|-------------|
| `doc` | Google-style docstring |
| `"""` | Simple docstring |

### Async Patterns
| Trigger | Description |
|---------|-------------|
| `acm` | Async context manager |
| `afor` | Async comprehension |
| `ctx` | Context manager class |

## JavaScript Snippets (`javascript.lua`)

### Core Patterns
| Trigger | Description |
|---------|-------------|
| `fn` | Function with type choice (regular/async/const) |
| `af` | Arrow function |
| `aaf` | Async arrow function |
| `cls` | Class with optional extends |
| `promise` | Promise constructor |
| `try` | Try-catch block |

### React
| Trigger | Description |
|---------|-------------|
| `rfc` | Functional component |
| `rfcp` | Functional component with TypeScript props |
| `us` | useState hook (auto-capitalizes setter) |
| `ue` | useEffect with cleanup |
| `hook` | Custom hook |

### Express/Node.js
| Trigger | Description |
|---------|-------------|
| `route` | Express route with HTTP method choice |
| `middleware` | Express middleware factory |
| `errorh` | Express error handler |

### Testing (Jest/Vitest)
| Trigger | Description |
|---------|-------------|
| `desc` | Describe block |
| `test` | Test case (test/it with async option) |
| `mock` | Jest mock function |

### Documentation (JSDoc)
| Trigger | Description |
|---------|-------------|
| `jsdoc` | JSDoc function comment |
| `typedef` | JSDoc type definition |

### Modern ES6+
| Trigger | Description |
|---------|-------------|
| `imp` | Import (named/default/namespace) |
| `exp` | Export (default/named/const) |
| `dest` | Destructuring assignment |
| `tpl` | Template literal |
| `opt` | Optional chaining |
| `null` | Nullish coalescing |

## C++ Snippets (`cpp.lua`)

### Core Patterns
| Trigger | Description |
|---------|-------------|
| `fn` | Function definition |
| `cls` | Class with constructor/destructor |
| `struct` | Struct definition |
| `ns` | Namespace with closing comment |
| `guard` | Pragma once header guard |
| `inc` | Include angle brackets |
| `incs` | Include quotes |
| `for` | Traditional for loop |
| `forr` | Range-based for loop |
| `if` / `ife` | If / if-else statements |

### Modern C++ (C++17/20/23)
| Trigger | Description |
|---------|-------------|
| `uptr` | make_unique |
| `sptr` | make_shared |
| `lam` | Lambda with capture/return type |
| `auto` | Auto variable |
| `constexpr` | Constexpr function |
| `bind` | Structured binding |
| `tem` | Template function |

### STL
| Trigger | Description |
|---------|-------------|
| `vec` | std::vector |
| `map` | std::map |
| `umap` | std::unordered_map |
| `str` | std::string |
| `pair` | std::pair |
| `foreach` | std::for_each with lambda |
| `transform` | std::transform with lambda |

### Documentation (Doxygen)
| Trigger | Description |
|---------|-------------|
| `doc` | Doxygen function comment |
| `docclass` | Doxygen class comment |
| `todo` | TODO comment |

### Best Practices
| Trigger | Description |
|---------|-------------|
| `raii` | RAII wrapper (rule of 5) |
| `main` | Main function |
| `try` | Try-catch block |
| `enum` | Enum class |

## LaTeX Snippets (`tex.lua`)

### Core Structures
| Trigger | Description |
|---------|-------------|
| `beg` | Environment with smart \\item insertion |
| `item` | List item |
| `itemd` | Description item |
| `sec` / `ssec` / `sssec` | Sections |
| `lab` / `ref` / `cite` | Labels and references |

### Math
| Trigger | Description |
|---------|-------------|
| `mm` | Inline math |
| `dm` | Display math |
| `eq` | Equation with label |
| `align` | Align environment |
| `frac` | Fraction |
| `sum` | Summation |
| `int` | Integral |
| `mat` | Matrix (pmatrix/bmatrix/etc.) |
| `gr` | Greek letters |

### Beamer
| Trigger | Description |
|---------|-------------|
| `frame` | Beamer frame |
| `block` | Beamer block |
| `cols` | Two-column layout |
| `pause` | Pause command |

### TikZ
| Trigger | Description |
|---------|-------------|
| `tikz` | TikZ picture environment |
| `node` | TikZ node |
| `draw` | TikZ draw path |
| `fill` | TikZ fill shape |

### Common Packages
| Trigger | Description |
|---------|-------------|
| `fig` | Figure with includegraphics |
| `tab` | Table with tabular |
| `code` | Listings code block |
| `href` | Hyperlink |
| `bibitem` | Bibliography entry |

## Advanced Features

### Choice Nodes

Snippets with multiple variants use choice nodes. Cycle through options with `Ctrl-L` (forward) and `Ctrl-H` (backward).

**Example:** Type `fn` in JavaScript, then `Ctrl-L` to cycle between `function`, `async function`, and `const`.

### Dynamic Content

Some snippets generate dynamic content:

**Python `us` (useState):**
```javascript
const [count, setCount] = useState(0)
                ^^^^^^^^ - automatically capitalized from "count"
```

**C++ `for` loop:**
```cpp
for (int i = 0; i < n; ++i) {
         ^         ^     ^ - auto-detected from initialization
}
```

### Smart Defaults

Snippets include sensible defaults that you can tab through and modify:

- Function names: `functionName` (obvious placeholder)
- Types: Common types in choice nodes (`str`, `int`, `auto`, etc.)
- Comments: Placeholder descriptions

## Migration from Snipmate

If you previously used Snipmate snippets, note these trigger changes:

| Old (Snipmate) | New (LuaSnip) | Language |
|----------------|---------------|----------|
| `inc` | `inc` | C++ (same) |
| `for` | `for` / `forr` | C++ (added range-based variant) |
| Most triggers | **Same triggers preserved** | All |

The migration preserves most trigger names for muscle memory.

## Creating Custom Snippets

Add snippets to the appropriate language file following this pattern:

```lua
s("trigger", fmt([[
Your snippet template with {} placeholders
]], {
  i(1, "first tabstop"),
  i(2, "second tabstop"),
  i(0, "final position"),
})),
```

**Tips:**
1. Use `fmt()` for readable multi-line snippets
2. Add choice nodes (`c()`) for variants
3. Use function nodes (`f()`) for dynamic content
4. Group related snippets under category comments
5. Test with `:LuaSnipEdit` command

## Resources

- [LuaSnip Documentation](https://github.com/L3MON4D3/LuaSnip)
- [LuaSnip Wiki](https://github.com/L3MON4D3/LuaSnip/wiki)
- [Friendly Snippets](https://github.com/rafamadriz/friendly-snippets) (additional collection)
