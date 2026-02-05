# KEYMAP.md

Custom keymap reference for this Neovim configuration. Only lists keymaps defined in this config — LazyVim defaults are documented at <https://lazyvim.github.io/keymaps>.

## Global Keymaps (`lua/config/keymaps.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>xS` | n | Trouble Symbols |
| `<leader>ns` | n | Noice Snacks |
| `<leader>gH` | n | Dashboard (Snacks) |
| `<leader>gp` | n | Projects (Snacks picker) |
| `<leader>gr` | n | Open Pull Requests (Snacks github picker) |
| `<leader>gR` | n | All Pull Requests (Snacks github picker) |

## Which-key Groups (`lua/config/keymaps.lua`)

| Prefix | Group |
|--------|-------|
| `<leader>a` | ai |
| `<leader>ac` | claude code |
| `<leader>g` | git |
| `<leader>k` | sidekick |
| `<leader>L` | latex |
| `<leader>o` | opencode |
| `<leader>T` | todos |

## AI / LLM

### Claude Code (`lua/plugins/claudecode.nvim.lua`)

Remapped from LazyVim's default `<leader>a*` to `<leader>ac*` to share the `<leader>a` namespace with CodeCompanion.

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>acc` | n, v | Toggle Claude |
| `<leader>acf` | n, v | Focus Claude |
| `<leader>acr` | n, v | Resume Claude |
| `<leader>acC` | n, v | Continue Claude |
| `<leader>acb` | n, v | Add current buffer |
| `<leader>acs` | v | Send selection to Claude |
| `<leader>acs` | (file tree) | Add file (NvimTree/neo-tree/oil) |
| `<leader>aca` | n, v | Accept diff |
| `<leader>acd` | n, v | Deny diff |

### CodeCompanion (`lua/plugins/codecompanion.nvim.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>at` | n, v | Chat Toggle |
| `<leader>aa` | n, v | Actions |
| `<leader>ai` | n, v | Inline Assist |
| `<leader>ad` | v | Add to Chat |

**Inside CodeCompanion chat buffer:**

| Key | Mode | Description |
|-----|------|-------------|
| `<CR>` | n | Send message |
| `<C-s>` | i | Send message |
| `q` | n | Close chat |
| `<C-q>` | n | Stop generation |

### Sidekick (`lua/plugins/sidekick.nvim.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>kn` | n | Next edit suggestion (NES jump/apply) |
| `<C-S-Space>` | n | Accept NES suggestion |
| `<leader>kc` | n, v | CLI toggle |
| `<leader>kt` | n | Select tool |
| `<leader>ks` | v | Send selection |
| `<leader>kp` | n, v | Prompts menu |
| `<leader>kf` | n, v | Focus CLI window |
| `<leader>ka` | n, v | Claude CLI toggle |

### OpenCode (`lua/plugins/opencode.nvim.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ot` | n | Toggle OpenCode |
| `<leader>oa` | n, v | Ask OpenCode |
| `<leader>oA` | n, v | Ask about current file |
| `<leader>on` | n | New session |
| `<leader>oe` | n | Explain code near cursor |
| `<leader>or` | n | Review file |
| `<leader>of` | n | Fix errors (diagnostics) |
| `<leader>oo` | v | Optimize selection |
| `<leader>od` | v | Document selection |

## Navigation & Search

### Window Picker (`lua/plugins/window-picker.nvim.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>w` | n | Pick window |

### Leap (`lua/plugins/leap.nvim.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `s` | n, x, o | Leap (2-char jump) |
| `S` | n | Leap from window |
| `f` | n, x, o | Enhanced f (1-char with labels) |
| `F` | n, x, o | Enhanced F (backward) |
| `t` | n, x, o | Enhanced t (before char) |
| `T` | n, x, o | Enhanced T (backward, before) |

### Namu — LSP Symbols (`lua/plugins/namu.nvim.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ss` | n | Jump to LSP symbol |
| `<leader>sS` | n | LSP Symbols — Workspace |

### Telescope (`lua/plugins/telescope.nvim.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>fp` | n | Find Plugin File |
| `<leader>xl` | n | Location List (Telescope) |

### Snippet Browser (`lua/plugins/snippet-browser.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>sL` | n | Search Snippets (LuaSnip via Telescope) |

## Git

### Blame (`lua/plugins/blame.nvim.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>gb` | n | Git Blame (window) |
| `<leader>gB` | n | Git Blame (virtual text) |

**Inside Blame buffer:**

| Key | Description |
|-----|-------------|
| `K` | Show commit info |
| `<Tab>` | Push to stack |
| `<S-Tab>` | Pop from stack |
| `<CR>` | Show commit |
| `q` / `<Esc>` | Close |

### Dashboard & Projects (`lua/config/keymaps.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>gH` | n | Dashboard (Snacks) |
| `<leader>gp` | n | Projects (Snacks picker) |

### GitHub (`lua/config/keymaps.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>gr` | n | Open Pull Requests (Snacks github picker) |
| `<leader>gR` | n | All Pull Requests (Snacks github picker) |

### Neogit (`lua/plugins/neogit.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>gn` | n | Neogit |

## Editing

### Multicursors (`lua/plugins/multicursors.nvim.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>m` | n, v | Create selection (word/visual) |

### Image Paste (`lua/plugins/img-clip.nvim.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>p` | n | Paste image from clipboard |

## LaTeX

### Nabla (`lua/plugins/nabla.nvim.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>Lp` | n | Preview LaTeX equation (popup) |
| `<leader>Lv` | n | Toggle inline virtual text |

## Todos — Checkmate (`lua/plugins/checkmate.nvim.lua`)

Active in markdown files matching `files = { "TODOS.md" }`.

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>Tt` | n, v | Toggle todo item |
| `<leader>Tc` | n, v | Check (done) |
| `<leader>Tu` | n, v | Uncheck |
| `<leader>T=` | n, v | Cycle next state |
| `<leader>T-` | n, v | Cycle previous state |
| `<leader>Tn` | n, v | Create todo item |
| `<leader>Tr` | n, v | Remove todo marker |
| `<leader>TR` | n, v | Remove all metadata |
| `<leader>Ta` | n | Archive completed |
| `<leader>TF` | n | Todo picker |
| `<leader>Tv` | n | Update metadata value |
| `<leader>T]` | n | Jump to next metadata tag |
| `<leader>T[` | n | Jump to previous metadata tag |
| `<leader>Tp` | n | Set @priority |
| `<leader>Ts` | n | Set @started |
| `<leader>Td` | n | Set @done |

### Scratch Todo (`lua/plugins/snacks.nvim.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>T.` | n | Toggle Scratch Todo |

## Neovim Tips (`lua/plugins/neovim-tips.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>nto` | n | Browse tips |
| `<leader>ntr` | n | Random tip |
| `<leader>nte` | n | Edit your tips |
| `<leader>nta` | n | Add a tip |
| `<leader>ntp` | n | Open tips PDF |
