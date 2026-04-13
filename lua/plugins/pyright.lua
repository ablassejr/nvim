-- Enhanced Python LSP: pyright type checking + ruff analysis depth

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            pyright = {
              disableOrganizeImports = true, -- ruff handles this
            },
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoImportCompletions = true,
                diagnosticMode = "workspace",
              },
            },
          },
        },
        ruff = {
          init_options = {
            settings = {
              organizeImports = true,
              fixAll = true,
            },
          },
        },
      },
    },
  },
}
