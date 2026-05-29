-- Starlark-family language servers.
--   starpls  (Bazel team)  -> bzl, star, starlark, bazel
--   tilt_ls  (Tilt team)   -> tiltfile   (`tilt lsp start`)
-- Tiltfiles go to tilt_ls because it knows Tilt builtins (docker_build,
-- k8s_yaml, local_resource, ...); starpls only handles generic Starlark.

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        starpls = {
          filetypes = { "bzl", "star", "starlark", "bazel" },
          settings = {
            starpls = {
              bazel = {
                enableBzlmod = true,
              },
            },
          },
        },
        tilt_ls = {
          root_markers = { "Tiltfile", ".git" },
        },
      },
    },
  },
}
