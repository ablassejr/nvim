-- Snyk LS prompts for auth and performs shutdown flushing even when not configured.
-- Keep the Mason package installed, but do not auto-attach it to every supported filetype.
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      snyk_ls = {
        enabled = false,
      },
    },
  },
}
