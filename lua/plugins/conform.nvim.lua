-- Plugin: stevearc/conform.nvim
-- Added by store.nvim on 2025-12-29 12:40:39
return {
  "stevearc/conform.nvim",
  dependencies = {
    "zapling/mason-conform.nvim",
  },
  opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
      },
  },
}
