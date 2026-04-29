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

Custom groups registered in addition to LazyVim defaults (`<leader>b`, `<leader>c`, `<leader>d`, `<leader>f`, `<leader>g`, `<leader>s`, `<leader>u`, `<leader>w`, `<leader>x`, etc.).

| Prefix | Group |
|--------|-------|
| `<leader>ac` | claude code |
| `<leader>k` | sidekick |
| `<leader>L` | latex |
| `<leader>M` | multicursors |
| `<leader>nt` | neovim tips |
| `<leader>o` | overseer |
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
| `<leader>acs` | (file tree) | Add file (NvimTree/oil) |
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
| `<Tab>` | n | Next edit suggestion (NES jump/apply) |
| `<C-]>` | n | Accept NES suggestion |
| `<leader>kc` | n, v | CLI toggle |
| `<leader>kt` | n | Select tool |
| `<leader>ks` | v | Send selection |
| `<leader>kp` | n, v | Prompts menu |
| `<leader>kf` | n, v | Focus CLI window |
| `<leader>ka` | n, v | Claude CLI toggle |

## Navigation & Search

### Leap (`lua/plugins/leap.nvim.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `s` | n, x, o | Leap (2-char jump) |
| `S` | n | Leap from window |
| `f` | n, x, o | Enhanced f (1-char with clever-f traversal) |
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

### Window Picker (`lua/plugins/window-picker.nvim.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>wp` | n | Pick window |

### Treesitter Incremental Selection (`lua/plugins/nvim-treesitter.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<CR>` | n, x | Increment selection |
| `<BS>` | x | Decrement selection |

### NvimLaunch (`lua/plugins/nvimlaunch.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>l` | n | NvimLaunch (overrides LazyVim's `:Lazy`) |

### PDF Reader (`lua/plugins/pdfreader.nvim.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>Fp` | n | PDF Reader: Open recent |

## Windows & Splits

### Focus.nvim (`lua/plugins/focus.nvim.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>wh` | n | Split left |
| `<leader>wj` | n | Split down |
| `<leader>wk` | n | Split up |
| `<leader>wl` | n | Split right |
| `<leader>wn` | n | Split nicely (golden ratio) |
| `<leader>we` | n | Equalise splits |
| `<leader>wm` | n | Maximize / equalise toggle |
| `<leader>wt` | n | Toggle focus resizing |

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
| `<leader>m` | n | Create selection for word under cursor |
| `<leader>m` | v | Start multicursor from visual selection |
| `<leader>Ms` | n | Start multicursor with a pattern |
| `<leader>Mc` | n | Clear multicursor selections |
| `<leader>Mp` | n | Multicursor pattern search |

### Image Paste (`lua/plugins/img-clip.nvim.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>p` | n | Paste image from clipboard |

## Snippets (`lua/plugins/luasnip.lua`)

Keymaps set inside LuaSnip's `config()` function (active in insert/select mode).

| Key | Mode | Description |
|-----|------|-------------|
| `<Tab>` | i, s | Expand snippet or jump forward |
| `<S-Tab>` | i, s | Jump backward |
| `<C-l>` | i, s | Cycle choice node forward |
| `<C-h>` | i, s | Cycle choice node backward |

## LaTeX

### Nabla (`lua/plugins/nabla.nvim.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>Lp` | n | Preview LaTeX equation (popup) |
| `<leader>Lv` | n | Toggle inline virtual text |

## Debugging & Testing

### DAP (`lua/plugins/nvim-dap.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<F5>` | n | Continue |
| `<F10>` | n | Step Over |
| `<F11>` | n | Step Into |
| `<S-F11>` | n | Step Out |
| `<leader>db` | n | Toggle Breakpoint |
| `<leader>dq` | n | Terminate |

### DAP View (`lua/plugins/nvim-dap-view.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>du` | n | Toggle DAP View |

### Neotest (`lua/plugins/neotest-jest.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>tt` | n | Run File |
| `<leader>tT` | n | Run All Test Files |
| `<leader>tr` | n | Run Nearest |
| `<leader>td` | n | Debug Nearest |

## Task Runner

### Overseer (`lua/config/keymaps.lua`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>oo` | n | Toggle Task List |
| `<leader>or` | n | Run Task |
| `<leader>oa` | n | Task Action |
| `<leader>oq` | n | Quick Action |
| `<leader>os` | n | Shell |

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
