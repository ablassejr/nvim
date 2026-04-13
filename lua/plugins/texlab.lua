-- Enhanced texlab: chktex linting + inlay hints for label refs

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      texlab = {
        settings = {
          texlab = {
            chktex = {
              onOpenAndSave = true,
              onEdit = false,
            },
            inlayHints = {
              labelDefinitions = true,
              labelReferences = true,
            },
          },
        },
      },
    },
  },
}
