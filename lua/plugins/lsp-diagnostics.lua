-- Global LSP behavior: diagnostics, codelens, inlay hints
-- Extends nvim-lspconfig options which LazyVim uses to configure all servers

return {
  "neovim/nvim-lspconfig",
  opts = {
    codelens = {
      enabled = true,
    },
    inlay_hints = {
      enabled = true,
    },
    diagnostics = {
      virtual_text = false, -- tiny-inline-diagnostic.nvim handles display
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
