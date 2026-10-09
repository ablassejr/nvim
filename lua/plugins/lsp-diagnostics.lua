-- Global LSP behavior: diagnostics, codelens, inlay hints
-- Extends nvim-lspconfig options which LazyVim uses to configure all servers

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ["*"] = {
        -- Bound graceful shutdown for any remaining slow-closing server.
        exit_timeout = 500,
      },
      -- Mason auto-enables every installed LSP by default. Keep LTeX disabled
      -- even if its package is restored later; it should not attach to commit
      -- messages or other short-lived editor buffers.
      ltex_plus = {
        enabled = false,
      },
    },
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
