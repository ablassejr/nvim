return {
  "saghen/blink.cmp",
  -- optional: provides snippets for the snippet source
  dependencies = {
    "rafamadriz/friendly-snippets",
    -- blink.cmp extension plugins
    "mikavilpas/blink-ripgrep.nvim", -- Ripgrep search integration
    "Kaiser-Yang/blink-cmp-git", -- Git completions (issues, PRs, users, commits)
    -- Database completion (loaded for SQL filetypes)
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" } },
    -- codecompanion.nvim configured in its own file; blink source registered below
  },

  -- use a release tag to download pre-built binaries
  version = "1.*",
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- Use default snippet engine (native vim.snippet, no LuaSnip dependency)
    snippets = { preset = "default" },

    -- See :h blink-cmp-config-keymap for defining your own keymap
    -- Base: 'default' preset (C-n/C-p nav, C-e hide, C-k signature)
    keymap = {
      preset = "default",

      -- All other keys use the "default" preset behavior.
      -- LazyVim's blink extra auto-injects ai_accept (Copilot native) into <Tab>.
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
    },

    completion = {
      documentation = { auto_show = true },
      ghost_text = { enabled = false },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { "copilot", "lsp", "path", "snippets", "buffer", "ripgrep", "dadbod", "git" },
      per_filetype = {
        codecompanion = { "codecompanion" },
      },
      providers = {
        codecompanion = {
          name = "CodeCompanion",
          module = "codecompanion.providers.completion.blink",
          enabled = true,
        },
        lsp = {
          name = "LSP",
          module = "blink.cmp.sources.lsp",
          enabled = true,
          kind = "LSP",
          score_offset = 1000,
        },

        -- Copilot source configuration
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100, -- Prioritize copilot suggestions
          async = true,
        },
        -- Buffer source (built-in) — completes words from all open buffers
        buffer = {
          name = "Buffer",
          module = "blink.cmp.sources.buffer",
          enabled = true,
          score_offset = 700, -- Just under snippets (750)
          opts = {
            -- Complete from all open buffers, not just the current one
            get_bufnrs = vim.api.nvim_list_bufs,
          },
          -- Filter out plain dictionary words (short common English words)
          transform_items = function(_, items)
            return vim.tbl_filter(function(item)
              return item.insertText:find("[A-Z_]") -- keep camelCase, snake_case, PascalCase
                or #item.insertText > 6 -- keep longer identifiers
                or item.insertText:match("^%u") -- keep capitalized words (types, classes)
              end, items)
          end,
        },
        -- Ripgrep source configuration
        ripgrep = {
          module = "blink-ripgrep",
          name = "Ripgrep",
          enabled = true,
          -- Options documented at: https://github.com/mikavilpas/blink-ripgrep.nvim
        },
        -- Database completion source
        dadbod = {
          name = "Dadbod",
          module = "vim_dadbod_completion.blink",
          enabled = true,
          score_offset = 500,
        },
        snippets = {
          name = "Snippets",
          module = "blink.cmp.sources.snippets",
          kind = "Snippet",
          enabled = true,
          score_offset = 1100,
        },
        -- Git source — issues (#), PRs, users (@), commit types (:)
        git = {
          name = "Git",
          module = "blink-cmp-git",
          enabled = true,
          score_offset = 50,
        },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      -- fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    -- opts_extend = { "sources.default" },

    -- Cmdline mode: disable completion in search (/ and ?) but keep it for commands (:)
    cmdline = {
      sources = function()
        local type = vim.fn.getcmdtype()
        if type == "/" or type == "?" then return {} end
        return { "cmdline", "buffer" }
      end,
    },
  },
}
