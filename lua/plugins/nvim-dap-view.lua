-- Plugin: igorlfs/nvim-dap-view
-- Installed via store.nvim

return {
  "igorlfs/nvim-dap-view",
  lazy = true,
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  -- Keep view plugin unloaded until a DAP view command/key is used.
  cmd = {
    "DapViewOpen",
    "DapViewClose",
    "DapViewToggle",
    "DapViewWatch",
    "DapViewEval",
  },
  keys = {
    { "<leader>du", "<cmd>DapViewToggle<cr>", desc = "DAP View Toggle" },
  },
  ---@module 'dap-view'
  ---@type dapview.Config
  opts = {},
}
