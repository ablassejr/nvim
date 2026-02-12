# LuaSnip Custom Snippets

This directory contains Lua-based snippets that showcase LuaSnip's advanced features.

## File Structure

- `all.lua` - Global snippets available in all filetypes
- `<filetype>.lua` - Filetype-specific snippets (e.g., `python.lua`, `javascript.lua`)

## Creating Snippets

### Basic Snippet

```lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("trigger", {
    t("Hello "),
    i(1, "World"),
    t("!"),
  }),
}
```

### Using fmt() for Cleaner Syntax

```lua
local fmt = require("luasnip.extras.fmt").fmt

s("fn", fmt([[
function {}({}) {{
  {}
}}
]], {
  i(1, "name"),
  i(2, "args"),
  i(0, "// body"),
}))
```

### Advanced Node Types

#### Choice Node (Cycle with Ctrl-L/H)

```lua
local c = ls.choice_node
local sn = ls.snippet_node

s("var", fmt([[{} {} = {}]], {
  c(1, {
    t("const"),
    t("let"),
    t("var"),
  }),
  i(2, "name"),
  i(0, "value"),
}))
```

#### Function Node (Dynamic Content)

```lua
local f = ls.function_node

s("date", f(function()
  return os.date("%Y-%m-%d")
end))

-- Using insert node value
s("upper", fmt([[{} = {}]], {
  i(1, "text"),
  f(function(args)
    return args[1][1]:upper()
  end, {1}), -- {1} refers to insert node 1
}))
```

#### Dynamic Node (Changes Structure Based on Input)

```lua
local d = ls.dynamic_node

s("if", {
  t("if ("), i(1, "condition"), t(") {"),
  t({"", "  "}), i(2, "// body"),
  d(3, function(args)
    -- Add else block if user wants it
    if #args[1] > 0 then
      return sn(nil, {
        t({"", "} else {", "  "}),
        i(1, "// else"),
      })
    else
      return sn(nil, {t("")})
    end
  end, {2}),
  t({"", "}"})
})
```

#### Repeat Node (Duplicate Insert Node Content)

```lua
local rep = require("luasnip.extras").rep

s("log", fmt([[console.log("{}: ", {})]], {
  rep(1),  -- Repeats the value from insert node 1
  i(1, "variable"),
}))
```

## Keybindings

- `Tab` - Expand snippet or jump to next tabstop
- `Shift-Tab` - Jump to previous tabstop
- `Ctrl-L` - Cycle choice node forward
- `Ctrl-H` - Cycle choice node backward

## Tips

1. **Organize by filetype**: Create separate files for each language
2. **Use fmt()**: Much cleaner than manually constructing nodes
3. **Leverage function nodes**: Generate dates, filenames, git info dynamically
4. **Choice nodes for variants**: Great for offering multiple implementations
5. **Keep snipmate snippets**: They still work! LuaSnip loads both formats

## Resources

- [LuaSnip GitHub](https://github.com/L3MON4D3/LuaSnip)
- [LuaSnip Wiki](https://github.com/L3MON4D3/LuaSnip/wiki)
- Your snipmate snippets: `~/.config/nvim/snippets/`
