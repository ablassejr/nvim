return {
  "saghen/blink.cmp",
  -- optional: provides snippets for the snippet source
  dependencies = {
    "rafamadriz/friendly-snippets",
    -- blink.cmp extension plugins
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
    -- Use LuaSnip preset — prevents LazyVim from overriding expand with
    -- vim.snippet.expand(), whose parser lacks tabstop transform support
    snippets = { preset = "luasnip" },

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
      default = { "copilot", "lsp", "path", "snippets", "dadbod", "git" },
      per_filetype = {
        codecompanion = { "codecompanion" },
        -- Input boxes: only LSP completions
        snacks_picker_input = { "lsp" },
        snacks_input = { "lsp" },
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
          score_offset = 1200,
          transform_items = function(_, items)
            return vim.tbl_filter(function(item)
              if item.kind == 15 then
                if item.insertText and type(item.insertText) == "string" then
                  if item.insertText:match("%${%d+/") then
                    return false
                  end
                end
                if item.textEdit and item.textEdit.newText then
                  if item.textEdit.newText:match("%${%d+/") then
                    return false
                  end
                end
              end
              return true
            end, items)
          end,
        },

        -- Copilot source configuration
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = -100, -- Deprioritize copilot suggestions below other sources
          async = true,
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
          score_offset = 0,
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
        return { "cmdline" }
      end,
    },
  },
}
