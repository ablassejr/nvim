-- Interactive winbar breadcrumbs with LSP + treesitter backends

return {
  "Bekaboo/dropbar.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>;", function() require("dropbar.api").pick() end, desc = "Dropbar Pick" },
  },
  opts = {},
}
