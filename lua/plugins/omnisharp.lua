-- Enhanced Omnisharp: inlay hints, decompilation, source link

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      omnisharp = {
        enable_decompilation_support = true,
        enable_editorconfig_support = true,
        inlayHintsOptions = {
          enableForParameters = true,
          forLiteralParameters = true,
          forIndexerParameters = true,
          forObjectCreationParameters = true,
          forOtherParameters = true,
          suppressForParametersThatDifferOnlyBySuffix = false,
          suppressForParametersThatMatchMethodIntent = false,
          suppressForParametersThatMatchArgumentName = false,
          enableForTypes = true,
          forImplicitVariableTypes = true,
          forLambdaParameterTypes = true,
          forImplicitObjectCreation = true,
        },
      },
    },
  },
}
