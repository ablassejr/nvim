-- Plugin: nvim-neorg/neorg
-- Organizer, note-taking, and knowledge base in Neovim.
-- Includes core.latex.renderer for inline LaTeX rendering in .norg files.

return {
  "nvim-neorg/neorg",
  lazy = false,
  version = "*",
  dependencies = {
    "3rd/image.nvim",
  },
  config = function()
    require("neorg").setup({
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/notes",
            },
            default_workspace = "notes",
          },
        },
        ["core.latex.renderer"] = {
          config = {
            conceal = true,
            dpi = 350,
            render_on_enter = false,
            scale = 1,
          },
        },
      },
    })

    vim.wo.foldlevel = 99
    vim.wo.conceallevel = 2
  end,
}
