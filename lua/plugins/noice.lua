-- Plugin: folke/noice.nvim
-- Highly experimental UI for messages, cmdline and popupmenu
-- Disabling notify module to allow nvim-notify to handle notifications

return {
  "folke/noice.nvim",
  opts = {
    notify = {
      -- Disable noice's notification handling so nvim-notify can take over
      enabled = false,
    },
  },
}
