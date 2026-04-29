-- ltex-plus needs Java 21+; point it at mise-managed Java 25

local java_home = vim.fn.expand("~/.local/share/mise/installs/java/25.0.2")

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ltex_plus = {
        cmd_env = {
          JAVA_HOME = java_home,
          PATH = java_home .. "/bin:" .. vim.env.PATH,
        },
      },
    },
  },
}
