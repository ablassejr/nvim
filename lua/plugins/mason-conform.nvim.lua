return {
  "zapling/mason-conform.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
  opts = {
    ignore_install = { "prettier" }, -- if already installed system-wide
  },
}
