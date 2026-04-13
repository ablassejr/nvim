-- Enhanced TypeScript: variable type hints + import preferences

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      vtsls = {
        settings = {
          typescript = {
            inlayHints = {
              variableTypes = { enabled = true },
            },
            preferences = {
              importModuleSpecifier = "relative",
              quoteStyle = "auto",
            },
          },
          javascript = {
            inlayHints = {
              variableTypes = { enabled = true },
            },
            preferences = {
              importModuleSpecifier = "relative",
              quoteStyle = "auto",
            },
          },
        },
      },
    },
  },
}
