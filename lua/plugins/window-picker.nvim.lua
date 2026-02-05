return {
  "s1n7ax/nvim-window-picker",
  version = "2.*",
  config = function()
    require("window-picker").setup({
      -- Window picker hint characters (shown above each window)
      hint = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
      -- Filter for windows to consider
      filter_rules = {
        autoignore_current = true,
        autoignore_buftype = { "nofile", "quickfix", "terminal" },
        autoignore_filetype = { "NvimTree", "neo-tree", "notify" },
        bo = {
          filetype = { "notify", "Trouble", "qf", "spectre_panel" },
          buftype = { "terminal", "quickfix" },
        },
      },
    })
  end,
  keys = {
    {
      "<leader>w",
      function()
        local picked_window_id = require("window-picker").pick_window()
        if picked_window_id then
          vim.api.nvim_set_current_win(picked_window_id)
        end
      end,
      desc = "Pick window",
    },
  },
}
