-- Auto-stop inactive LSP clients to reclaim RAM
-- Critical for configs with 17+ language servers

return {
  "zeioth/garbage-day.nvim",
  event = "LspAttach",
  opts = {
    grace_period = 900,
    excluded_lsp_clients = {
      "jdtls",
      "metals",
      "copilot",
    },
  },
}
