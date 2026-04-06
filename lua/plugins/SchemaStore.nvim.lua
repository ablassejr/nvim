-- Extend yamlls with custom schemas beyond SchemaStore defaults
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      yamlls = {
        settings = {
          yaml = {
            schemas = {
              ["https://raw.githubusercontent.com/nexlabstudio/maestro-workbench/refs/heads/dev/schema/schema.v0.json"] = {
                "Maestro/**/*.yaml",
                "maestro/**/*.yaml",
              },
            },
          },
        },
      },
    },
  },
}
