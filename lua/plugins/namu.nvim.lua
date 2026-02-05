-- Plugin: bassamsdata/namu.nvim
-- LSP symbol navigation (replaces LazyVim's default <leader>ss Goto Symbol)

return {
  "bassamsdata/namu.nvim",
  opts = {
    global = {},
    namu_symbols = {
      options = {},
    },
  },
  keys = {
    { "<leader>ss", "<cmd>Namu symbols<cr>", desc = "Jump to LSP symbol", silent = true },
    { "<leader>sS", "<cmd>Namu workspace<cr>", desc = "LSP Symbols - Workspace", silent = true },
  },
}