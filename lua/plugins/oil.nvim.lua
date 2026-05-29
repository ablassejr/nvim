-- Plugin: stevearc/oil.nvim
-- File-system editor that lets you browse and edit directories like buffers.

return {
  "stevearc/oil.nvim",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>e", "<cmd>Oil<cr>", desc = "Open Oil (parent directory)" },
  },
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = true,
    },
    win_options = {
      signcolumn = "yes:2",
    },
    keymaps = {
      ["q"] = { "actions.close", mode = "n" },
    },
  },
}
