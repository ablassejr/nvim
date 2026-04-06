-- Plugin: akinsho/toggleterm.nvim
-- Replaces snacks terminal with a dedicated floating terminal

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<C-/>", desc = "Toggle Terminal" },
  },
  opts = {
    open_mapping = [[<C-/>]],
    direction = "float",
    float_opts = {
      border = "curved",
    },
    start_in_insert = true,
    close_on_exit = true,
  },
}
