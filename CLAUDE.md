# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A LazyVim-based Neovim configuration. LazyVim sits on top of lazy.nvim (plugin manager) and provides curated defaults, extras, and a plugin discovery system. Custom plugins override or extend LazyVim's defaults.

## Commands

- **Launch**: `nvim` (uses this config at `~/.config/nvim`)
- **Plugin sync**: `:Lazy sync` inside Neovim
- **Plugin health**: `:Lazy check` then `:checkhealth`
- **Headless sanity check**: `nvim --headless "+Lazy! sync" +qa`
- **Install LSP/tools**: `:Mason` UI
- **Format Lua**: `stylua .` (2-space indent, 120-col, spaces — see `stylua.toml`)

## Architecture

### Bootstrap Flow

`init.lua` → `require("config.lazy")` → lazy.nvim clones itself if missing → loads specs in order:

1. Mason + conform (hardcoded in lazy.lua spec)
2. LazyVim plugins (`import = "lazyvim.plugins"`)
3. Custom plugins (`import = "plugins"` — auto-discovers `lua/plugins/*.lua`)

Custom plugins default to `lazy = false` (eager). LazyVim plugins are lazy-loaded.

### Core Config (`lua/config/`)

| File           | Role                                                                           | Loaded                   |
| -------------- | ------------------------------------------------------------------------------ | ------------------------ |
| `lazy.lua`     | Bootstrap lazy.nvim, define spec sources, performance settings                 | Immediately via init.lua |
| `options.lua`  | `vim.opt` settings (colorcolumn, clipboard, listchars, etc.)                   | VeryLazy                 |
| `keymaps.lua`  | Global keymaps + which-key group registrations                                 | VeryLazy                 |
| `autocmds.lua` | Custom autocommands                                                            | VeryLazy                 |
| `auth.lua`     | Credential helper module — NOT auto-loaded, `require("config.auth")` on demand | On require               |

### Plugin Specs (`lua/plugins/`)

Each `.lua` file returns a lazy.nvim plugin table and is auto-discovered. Files are kebab-cased and named after the plugin (e.g., `blink.cmp.lua`, `sidekick.nvim.lua`).

### Snippet System (`snippets/`)

vim-snipmate-based. Snippet files live in `snippets/<filetype>.snippets` using UltiSnips-compatible format (snippet_version=1). Tab expands/jumps forward, Shift-Tab jumps backward. Community snippets from `honza/vim-snippets` are also available. Languages with custom snippets: Python, C++, C, JavaScript, Bash/Shell.

### Credential Management (`lua/config/auth.lua`)

All credentials are environment-variable driven. Key env vars:

- `CLAUDE_CODE_OAUTH_TOKEN` — Claude subscription (preferred for codecompanion)
- `ANTHROPIC_API_KEY`, `OPENAI_API_KEY`, `OPENROUTER_API_KEY` — API keys
- `GITHUB_PERSONAL_ACCESS_TOKEN` — neogit, mcphub
- `DATABASE_URL`, `DBUI_URL` — dadbod database plugins

Plugins gracefully degrade when credentials are missing. Never hardcode tokens.

### Key Plugin Groups

**AI/LLM**: codecompanion.nvim (Copilot adapter), sidekick.nvim (inline edits), mcphub.nvim (MCP), opencode.nvim

**Completion**: blink.cmp with sources: copilot (score_offset=100, prioritized), LSP, ripgrep, dadbod, snippets. Tab accepts ghost text; M-Tab accepts menu item.

**File Explorer**: neo-tree.nvim (`<leader>e` toggle, `<leader>E` reveal)

**Navigation**: telescope.nvim (fzf-native), snacks.nvim (picker, dashboard), leap.nvim

**Which-key namespaces** (registered in `keymaps.lua`):

- `<leader>a` = ai (shared namespace — Claude Code under `<leader>ac`, CodeCompanion under `<leader>a{t,a,i,d}`)
- `<leader>k` = sidekick
- `<leader>L` = latex
- `<leader>o` = opencode
- `<leader>T` = todos

### Custom Keymaps

All custom keymaps are documented in [`KEYMAP.md`](KEYMAP.md). Global keymaps live in `lua/config/keymaps.lua`; plugin-scoped keymaps are defined in their respective `lua/plugins/*.lua` spec files via `keys = { ... }` tables.

### LazyVim Extras

Enabled in `lazyvim.json`. Notable: ai.claudecode, ai.copilot-native, dap.core, dap.nlua, editor.telescope, editor.snacks_picker, editor.leap, editor.overseer, lsp.none-ls, and language extras for Python, TypeScript, C/C++, Java, Dart, .NET, Docker, SQL, TeX, and more.

## Style

- Lua: 2-space indentation, 120-column soft limit, spaces not tabs (enforced by stylua)
- Plugin spec filenames: kebab-case, named after the plugin
- Keymaps and autocmds belong in `lua/config/`; avoid defining them in plugin specs unless scoped to that plugin
- Prefer `local` bindings, minimal globals, small composable `opts` for overrides
- Commit related files together; include `lazy-lock.json` when plugin versions change
- Short, imperative commit messages with optional prefix (e.g., `fix: disable lazy checker notify`)

## Testing

No automated test suite. Validate by:

1. Run the headless sync: `nvim --headless "+Lazy! sync" +qa`
2. Open Neovim and exercise affected plugins/keymaps
3. Check `:checkhealth` for relevant providers

## Known Patterns

- `snacks.nvim` input uses `buftype = "nofile"` override to fix backspace issues with prompt buffers
- `plugin/after/transparency.lua` applies transparent background styling after plugins load
- The `thoughts/` directory contains design docs and plans (sidekick integration)
- SSH detection in `options.lua` controls clipboard behavior (`unnamedplus` only on local)
