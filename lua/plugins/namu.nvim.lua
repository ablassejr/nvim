-- Plugin: bassamsdata/namu.nvim
-- LSP symbol navigation (replaces LazyVim's default <leader>ss Goto Symbol)

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            { "<leader>ss", "<cmd>Namu symbols<cr>", desc = "Namu Symbols" },
            { "<leader>sS", "<cmd>Namu workspace<cr>", desc = "Namu Workspace Symbols" },
          },
        },
      },
    },
  },
  {
    "bassamsdata/namu.nvim",
    cmd = "Namu",
    opts = {
      global = {},
      namu_symbols = {
        options = {},
      },
    },
  },
}