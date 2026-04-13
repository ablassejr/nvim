-- Enhanced Dart LSP: snippets + completion budget

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      dartls = {
        settings = {
          dart = {
            enableSnippets = true,
            completeFunctionCalls = true,
          },
        },
      },
    },
  },
}
