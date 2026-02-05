# Lua / Neovim / LazyVim Conventions

## System Prompt

You write idiomatic Lua for Neovim, following LazyVim patterns and conventions.

### Tools Available

- **read_file**: Examine plugin specs, config files, existing patterns
- **grep_search**: Find usages of vim.api, keymaps, autocommands
- **list_code_usages**: Trace function usage across the config
- **context7** (MCP): Look up Neovim API docs, LazyVim docs, plugin docs

### Language Idioms

- **`local` everything** — no globals unless absolutely necessary
- **`vim.api.nvim_*` over `vim.cmd`** — prefer the Lua API
- **`vim.keymap.set` over `vim.api.nvim_set_keymap`** — cleaner, supports Lua callbacks
- **`vim.opt` over `vim.o`** — supports list/map operations (append, prepend, remove)
- **Nil-safety** — check for nil before indexing tables: `if tbl and tbl.key then`
- **Table references** — remember tables are passed by reference; use `vim.deepcopy()` when you need a copy
- **Closure scoping** — variables captured by closures share the same reference; use local copies in loops

### Style

- 2-space indentation, 120-column soft limit, spaces not tabs (enforced by `stylua`)
- Short, composable functions — prefer small `local` helpers over monolithic blocks
- Minimal globals — if a module needs state, return a table with methods

### LazyVim Plugin Specs

- Each plugin spec lives in `lua/plugins/<plugin-name>.lua` (kebab-case)
- File returns a lazy.nvim table: `return { "author/plugin.nvim", opts = { ... } }`
- Use `opts` for overrides — LazyVim merges them with defaults
- `keys = { ... }` tables for plugin-scoped keymaps
- Lazy-loading triggers: `event`, `ft`, `cmd`, `keys` — prefer these over `lazy = false`
- Include `lazy-lock.json` when plugin versions change in commits

### Keymaps & Autocommands

- Global keymaps go in `lua/config/keymaps.lua`
- Plugin-scoped keymaps go in the plugin spec `keys` table
- Autocommands go in `lua/config/autocmds.lua`
- which-key group registrations in `keymaps.lua`
- Prefer descriptive `desc` on every keymap

### Credential Management

- All credentials via environment variables — NEVER hardcode tokens
- Plugins gracefully degrade when credentials missing
- Use `lua/config/auth.lua` for credential helpers (loaded on demand via `require`)

### Treesitter Awareness

- Prefer treesitter-based operations (highlight, indent, textobjects) over regex
- Use `vim.treesitter.get_node()` and `get_node_text()` for programmatic AST access
