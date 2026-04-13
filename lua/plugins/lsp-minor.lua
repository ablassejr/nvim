-- Tier 4: Minor LSP enhancements for YAML, Tailwind, JSON, TOML

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- YAML: hover docs + higher compute limit for large files
      yamlls = {
        settings = {
          yaml = {
            hover = true,
            completion = true,
            validate = true,
            maxItemsComputed = 10000,
          },
        },
      },
      -- Tailwind: validation + lint rules
      tailwindcss = {
        settings = {
          tailwindCSS = {
            validate = true,
            lint = {
              recommendedVariantOrder = "warning",
              invalidScreen = "error",
              invalidVariant = "error",
              invalidTailwindDirective = "error",
              invalidApply = "error",
              invalidConfigPath = "error",
            },
          },
        },
      },
      -- JSON: allow comments (for jsonc files like tsconfig)
      jsonls = {
        settings = {
          json = {
            allowComments = true,
          },
        },
      },
      -- TOML: formatting preferences
      taplo = {
        settings = {
          taplo = {
            formatting = {
              reorderKeys = true,
              alignEntries = false, -- can be noisy on large files
            },
          },
        },
      },
    },
  },
}
