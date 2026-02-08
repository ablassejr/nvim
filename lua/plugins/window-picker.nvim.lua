return {
  "s1n7ax/nvim-window-picker",
  version = "2.*",
  config = function()
    require("window-picker").setup({
      -- Type of hint display (statusline-winbar, floating-big-letter, or floating-letter)
      hint = "statusline-winbar",
      -- Characters used for window selection (home row optimized)
      selection_chars = "FJDKSLA;CMRUEIWOQP",
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
      "<leader>wp",
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
