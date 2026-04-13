local java_home = vim.fn.expand("~/.local/share/mise/installs/java/25.0.2")

return {
  {
    "mfussenegger/nvim-jdtls",
    opts = {
      jdtls = {
        cmd_env = { JAVA_HOME = java_home, PATH = java_home .. "/bin:" .. vim.env.PATH },
        settings = {
          java = {
            codeGeneration = {
              generateComments = true,
              hashCodeEquals = { useInstanceof = true },
              toString = { codeStyle = "STRING_BUILDER" },
            },
            completion = {
              importOrder = { "#", "java", "javax", "org", "com" },
            },
            saveActions = {
              organizeImports = true,
            },
            sources = {
              organizeImports = {
                starThreshold = 5,
                staticStarThreshold = 3,
              },
            },
          },
        },
      },
    },
  },
}
