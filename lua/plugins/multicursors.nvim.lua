-- Plugin: smoka7/multicursors.nvim
-- Installed via store.nvim

return {
  "smoka7/multicursors.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvimtools/hydra.nvim",
  },
  opts = {},
  cmd = {
    "MCstart",
    "MCvisual",
    "MCclear",
    "MCpattern",
    "MCvisualPattern",
    "MCunderCursor",
  },
  keys = {
    {
      mode = { "v" },
      "<Leader>m",
      "<cmd>MCvisualPattern<cr>",
      desc = "Start Multicursor",
    },
    {
      mode = { "n" },
      "<Leader>m",
      "<cmd>MCunderCursor<cr>",
      desc = "Create a selection for selected text or word under the cursor",
    },
    {
      mode = { "n" },
      "<Leader>Ms",
      "<cmd>MCstart<cr>",
      desc = "Start Multicursor with a pattern",
    },
    {
      mode = { "n" },
      "<Leader>Mc",
      "<cmd>MCclear<cr>",
      desc = "Clear Multicursor selections",
    },
    {
      mode = { "n" },
      "<Leader>Mp",
      "<cmd>MCpattern<cr>",
      desc = "Start Multicursor with a pattern",
    },
  },
}
