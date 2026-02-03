-- Plugin: stevearc/conform.nvim
-- Added by store.nvim on 2025-12-29 12:40:39
return {
  "stevearc/conform.nvim",
  opts = {
      mason_reg = require("mason-registry"),
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" }, -- Mason-conform will auto-install these via Mason}
      },
  },
}
