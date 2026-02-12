-- Plugin: NeogitOrg/neogit
-- Installed via store.nvim

return {
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration
    -- Only one of these is needed.
    "nvim-telescope/telescope.nvim", -- optional
    -- "ibhagwan/fzf-lua", -- optional
    -- "nvim-mini/mini.pick", -- optional
    "folke/snacks.nvim", -- optional
  },
  cmd = "Neogit",
  keys = {
    {
      "<leader>gn",
      "<cmd>Neogit<cr>",
      desc = "Neogit",
    },
  },
  disable_hint = true,
  disable_signs = false,
  disable_context_highlighting = false,
  prompt_force_push = true,
  disable_insert_on_commit = "auto",
  filewatcher = {
    enabled = true,
    interval = 1000,
  },
  commit_view = {
    kind = "vsplit",
  },
  log_view = {
    kind = "tab",
  },
  remember_settings = true,
  use_per_project_settings = true,
  highlight = {
    italic = true,
    bold = true,
    underline = true,
  },
}
