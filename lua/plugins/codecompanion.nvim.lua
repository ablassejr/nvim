-- Plugin: olimorris/codecompanion.nvim
-- AI chat + inline assist with Anthropic Claude via Copilot adapter

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  event = "VeryLazy",
  keys = {
    { "<leader>at", "<cmd>CodeCompanionChat Toggle<CR>", desc = "Chat Toggle", mode = { "n", "v" } },
    { "<leader>aa", "<cmd>CodeCompanionActions<CR>", desc = "Actions", mode = { "n", "v" } },
    { "<leader>ai", "<cmd>CodeCompanion<CR>", desc = "Inline Assist", mode = { "n", "v" } },
    { "<leader>ad", "<cmd>CodeCompanionChat Add<CR>", desc = "Add to Chat", mode = "v" },
  },
  opts = {
    -- Interaction adapters: Copilot routes through your GitHub subscription
    interactions = {
      chat = {
        adapter = {
          name = "copilot",
          model = "gpt-5.1-codex-max",
        },
        roles = {
          llm = function(adapter)
            return "CodeCompanion (" .. adapter.formatted_name .. ")"
          end,
          user = "Me",
        },
        keymaps = {
          send = {
            modes = { n = "<CR>", i = "<C-s>" },
          },
          close = {
            modes = { n = "q" },
          },
          stop = {
            modes = { n = "<C-q>" },
          },
        },
        -- Agentic tool groups for autonomous coding
        tools = {
          groups = {
            full_stack_dev = {
              description = "Full Stack Developer - Can run code, edit code and modify files",
              prompt = "I'm giving you access to the ${tools} to help you perform coding tasks",
              tools = {
                "cmd_runner",
                "create_file",
                "delete_file",
                "file_search",
                "get_changed_files",
                "grep_search",
                "insert_edit_into_file",
                "list_code_usages",
                "read_file",
              },
              opts = {
                collapse_tools = true,
              },
            },
          },
          -- Safety: require approval before running commands
          cmd_runner = {
            opts = {
              require_approval_before = true,
            },
          },
          insert_edit_into_file = {
            opts = {
              require_confirmation_after = true,
            },
          },
          opts = {
            auto_submit_errors = true,
            auto_submit_success = true,
            default_tools = { "full_stack_dev" },
          },
        },
      },
      inline = {
        adapter = {
          name = "copilot",
          model = "claude-haiku-4.5",
        },
      },
      cmd = {
        adapter = {
          name = "copilot",
          model = "claude-haiku-4.5",
        },
      },
    },
    -- Display settings
    display = {
      action_palette = {
        provider = "snacks",
      },
      chat = {
        show_header_separator = true,
        window = {
          opts = {
            breakindent = true,
            linebreak = true,
            wrap = true,
            cursorline = true,
            number = false,
            relativenumber = false,
            signcolumn = "no",
          },
        },
      },
      diff = {
        show_dim = true,
        show_keymap_hints = true,
      },
    },
    -- Extensions
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_vars = true,
          make_slash_commands = true,
          show_result_in_chat = true,
        },
      },
    },
    -- Rules: persistent instruction presets loaded into chat sessions
    -- Default auto-loads on every chat; others load on-demand via /rules
    rules = {
      -- Auto-discovers project instruction files (CLAUDE.md, .cursorrules, etc.)
      default = {
        description = "Project instruction files",
        files = {
          "CLAUDE.md",
          "CLAUDE.local.md",
          "AGENTS.md",
          ".cursorrules",
          ".clinerules",
          ".windsurfrules",
          ".github/copilot-instructions.md",
          "~/.claude/CLAUDE.md",
        },
        parser = "claude",
        is_preset = true,
      },
      -- General coding standards (first principles, source-grounded, challenge assumptions)
      coding = {
        description = "General coding standards and principles",
        files = { vim.fn.stdpath("config") .. "/rules/coding.md" },
        parser = "codecompanion",
      },
      -- Language-specific rules
      lang_lua = {
        description = "Lua/Neovim/LazyVim conventions",
        files = { vim.fn.stdpath("config") .. "/rules/lang/lua.md" },
        parser = "codecompanion",
      },
      lang_python = {
        description = "Modern Python (3.10+) conventions",
        files = { vim.fn.stdpath("config") .. "/rules/lang/python.md" },
        parser = "codecompanion",
      },
      lang_typescript = {
        description = "Strict TypeScript conventions",
        files = { vim.fn.stdpath("config") .. "/rules/lang/typescript.md" },
        parser = "codecompanion",
      },
      lang_cpp = {
        description = "Modern C++ (17/20) conventions",
        files = { vim.fn.stdpath("config") .. "/rules/lang/cpp.md" },
        parser = "codecompanion",
      },
      lang_latex = {
        description = "LaTeX best practices",
        files = { vim.fn.stdpath("config") .. "/rules/lang/latex.md" },
        parser = "codecompanion",
      },
      -- Task-specific rules (translated from superpowers skills)
      debug = {
        description = "Systematic debugging (4 phases, root cause first)",
        files = { vim.fn.stdpath("config") .. "/rules/tasks/debug.md" },
        parser = "codecompanion",
      },
      testing = {
        description = "TDD: red-green-refactor + anti-patterns",
        files = { vim.fn.stdpath("config") .. "/rules/tasks/testing.md" },
        parser = "codecompanion",
      },
      review = {
        description = "Code review + spec compliance verification",
        files = { vim.fn.stdpath("config") .. "/rules/tasks/review.md" },
        parser = "codecompanion",
      },
      refactor = {
        description = "Refactoring discipline (preserve behavior)",
        files = { vim.fn.stdpath("config") .. "/rules/tasks/refactor.md" },
        parser = "codecompanion",
      },
      verify = {
        description = "Verification before completion (evidence first)",
        files = { vim.fn.stdpath("config") .. "/rules/tasks/verify.md" },
        parser = "codecompanion",
      },
      planning = {
        description = "Structured implementation planning",
        files = { vim.fn.stdpath("config") .. "/rules/tasks/planning.md" },
        parser = "codecompanion",
      },
      research = {
        description = "Research & discovery (source-grounded, multi-source)",
        files = { vim.fn.stdpath("config") .. "/rules/tasks/research.md" },
        parser = "codecompanion",
      },
      -- Architecture rules
      design = {
        description = "Design brainstorming methodology",
        files = { vim.fn.stdpath("config") .. "/rules/architecture/design.md" },
        parser = "codecompanion",
      },
      api_design = {
        description = "REST/GraphQL API conventions",
        files = { vim.fn.stdpath("config") .. "/rules/architecture/api-design.md" },
        parser = "codecompanion",
      },
      database = {
        description = "Database schema and query patterns",
        files = { vim.fn.stdpath("config") .. "/rules/architecture/database.md" },
        parser = "codecompanion",
      },
      -- Writing rules
      documentation = {
        description = "Technical writing standards",
        files = { vim.fn.stdpath("config") .. "/rules/writing/documentation.md" },
        parser = "codecompanion",
      },
      changelog = {
        description = "Changelog and release notes style",
        files = { vim.fn.stdpath("config") .. "/rules/writing/changelog.md" },
        parser = "codecompanion",
      },
      -- Git rules
      commits = {
        description = "Conventional commit messages",
        files = { vim.fn.stdpath("config") .. "/rules/git/commits.md" },
        parser = "codecompanion",
      },
      pull_requests = {
        description = "PR descriptions and review etiquette",
        files = { vim.fn.stdpath("config") .. "/rules/git/pull-requests.md" },
        parser = "codecompanion",
      },
      -- Rules system options
      opts = {
        chat = {
          autoload = "default",
          enabled = true,
          default_params = "diff",
        },
        show_presets = true,
      },
    },
  },
}
