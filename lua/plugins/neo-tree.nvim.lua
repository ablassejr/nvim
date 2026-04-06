-- Plugin: nvim-neo-tree/neo-tree.nvim
-- Overrides on top of LazyVim's editor.neo-tree extra

return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    { "<leader>e", false },
    { "<leader>E", false },
    {
      "<leader>E",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
      end,
      desc = "Explorer NeoTree (cwd)",
    },
  },
  opts = {
    close_if_last_window = true,
    enable_git_status = true,
    enable_diagnostics = true,
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = true,
        hide_gitignored = true,
        hide_hidden = true,
        hide_by_name = { "node_modules/", "__pycache__/" },
        never_show = { ".DS_Store" },
      },
    },
    window = {
      width = 35,
    },
  },
}
