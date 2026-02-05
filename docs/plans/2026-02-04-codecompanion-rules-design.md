# CodeCompanion Rules Starter Pack — Design Document

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Create 18 CodeCompanion rule files that translate Claude Code superpowers skills and personal coding methodology into reusable, tool-aware instruction presets for CodeCompanion chat sessions.

**Architecture:** Markdown rule files using `codecompanion` parser format, organized by category (general, language, task, architecture, writing, git). Each rule references both CodeCompanion built-in tools and MCP servers where relevant. A `default` preset auto-loads project instruction files; all others load on-demand via `/rules`.

**Tech Stack:** CodeCompanion.nvim rules system, MCPHub MCP servers, codecompanion parser format.

---

## File Layout

```
~/.config/nvim/rules/
├── coding.md                    # General coding standards
├── lang/
│   ├── lua.md                   # Lua/Neovim/LazyVim
│   ├── python.md                # Modern Python 3.10+
│   ├── typescript.md            # Strict TypeScript
│   ├── cpp.md                   # Modern C++ (17/20)
│   └── latex.md                 # LaTeX best practices
├── tasks/
│   ├── debug.md                 # Systematic debugging (from superpowers)
│   ├── testing.md               # TDD + anti-patterns (from superpowers)
│   ├── review.md                # Code review + spec compliance (from superpowers)
│   ├── refactor.md              # Refactoring discipline
│   ├── verify.md                # Verification before completion (from superpowers)
│   └── planning.md              # Implementation planning (from superpowers)
├── architecture/
│   ├── design.md                # Design brainstorming (from superpowers)
│   ├── api-design.md            # REST/GraphQL conventions
│   └── database.md              # Schema & query patterns
├── writing/
│   ├── documentation.md         # Technical writing
│   └── changelog.md             # Changelog style
└── git/
    ├── commits.md               # Conventional commits
    └── pull-requests.md         # PR descriptions
```

## Preset Configuration

Added to `codecompanion.nvim.lua` `opts`:

```lua
rules = {
  default = {
    description = "Project instruction files (CLAUDE.md, .cursorrules, etc.)",
    files = {
      "CLAUDE.md", "CLAUDE.local.md", "AGENTS.md",
      ".cursorrules", ".clinerules", ".windsurfrules",
      ".github/copilot-instructions.md",
      "~/.claude/CLAUDE.md",
    },
    parser = "claude",
    is_preset = true,
  },
  coding = {
    description = "General coding standards and principles",
    files = { vim.fn.stdpath("config") .. "/rules/coding.md" },
    parser = "codecompanion",
  },
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
  debug = {
    description = "Systematic debugging methodology",
    files = { vim.fn.stdpath("config") .. "/rules/tasks/debug.md" },
    parser = "codecompanion",
  },
  testing = {
    description = "Test-driven development + anti-patterns",
    files = { vim.fn.stdpath("config") .. "/rules/tasks/testing.md" },
    parser = "codecompanion",
  },
  review = {
    description = "Code review + spec compliance",
    files = { vim.fn.stdpath("config") .. "/rules/tasks/review.md" },
    parser = "codecompanion",
  },
  refactor = {
    description = "Refactoring discipline",
    files = { vim.fn.stdpath("config") .. "/rules/tasks/refactor.md" },
    parser = "codecompanion",
  },
  verify = {
    description = "Verification before completion",
    files = { vim.fn.stdpath("config") .. "/rules/tasks/verify.md" },
    parser = "codecompanion",
  },
  planning = {
    description = "Structured implementation planning",
    files = { vim.fn.stdpath("config") .. "/rules/tasks/planning.md" },
    parser = "codecompanion",
  },
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
  opts = {
    chat = {
      autoload = "default",
      enabled = true,
      default_params = "diff",
    },
    show_presets = true,
  },
},
```

## Tool Specification Per Rule

Each rule references the tools the LLM should use. Tools come from two sources:
1. **CodeCompanion built-in tools** (from `full_stack_dev` group): `cmd_runner`, `read_file`, `create_file`, `delete_file`, `file_search`, `grep_search`, `insert_edit_into_file`, `list_code_usages`, `get_changed_files`
2. **MCP servers** (via MCPHub extension): `context7`, `github`, `sequentialthinking`, `fetch`, `e2b`, `postgres`

### Tool mapping per rule:

| Rule | Built-in Tools | MCP Tools |
|------|---------------|-----------|
| `coding.md` | read_file, grep_search, file_search | context7 (docs lookup) |
| `lang/*.md` | read_file, grep_search, list_code_usages | context7 (language docs) |
| `tasks/debug.md` | cmd_runner, read_file, grep_search, file_search | sequentialthinking |
| `tasks/testing.md` | cmd_runner, read_file, create_file, insert_edit_into_file | e2b (sandbox testing) |
| `tasks/review.md` | read_file, grep_search, get_changed_files, list_code_usages | github (PR context) |
| `tasks/refactor.md` | read_file, insert_edit_into_file, grep_search, list_code_usages | — |
| `tasks/verify.md` | cmd_runner, read_file | — |
| `tasks/planning.md` | read_file, file_search, grep_search | context7, github |
| `architecture/design.md` | read_file, file_search | context7, sequentialthinking, fetch |
| `architecture/api-design.md` | read_file, grep_search | context7, fetch |
| `architecture/database.md` | read_file, grep_search | postgres, context7 |
| `writing/documentation.md` | read_file, file_search | fetch |
| `writing/changelog.md` | get_changed_files, read_file | github |
| `git/commits.md` | get_changed_files, cmd_runner | github |
| `git/pull-requests.md` | get_changed_files, cmd_runner | github |

## MCPHub Parity Updates

Add to `~/.config/mcphub/servers.json`:

1. **e2b** — sandbox code execution for testing rules
2. **claude-context** — semantic codebase search (present in Claude Code but missing from MCPHub)

## Superpowers Translation Fidelity

Rules translated from superpowers skills preserve:
- **Iron Laws** — the non-negotiable core principle at the top
- **Phases/Processes** — the step-by-step methodology
- **Red Flags** — the "STOP and reconsider" triggers
- **Rationalizations Table** — the excuse/reality pairs
- **Gate Functions** — the decision checkpoints
- **Quick Reference Tables** — the at-a-glance summaries

Adapted for CodeCompanion context:
- References to "your human partner" become "the user"
- References to other superpowers skills become references to other rule presets (e.g., "load the `testing` rule preset")
- Skill invocation syntax removed (CodeCompanion doesn't have skills)
- Tool references added (which CodeCompanion/MCP tools to use at each phase)
