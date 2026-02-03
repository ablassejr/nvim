-- Ensure global (workspace) LSP diagnostics are enabled
-- Extends nvim-lspconfig options which LazyVim uses to call vim.diagnostic.config()

return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    },
  },
}
