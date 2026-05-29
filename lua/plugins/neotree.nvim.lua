return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons", -- optional, but recommended
  },
  lazy = false, -- neo-tree will lazily load itself
  ---@module 'neo-tree'
  ---@type neotree.Config
  opts = {
    position = "current",
    sources = { "filesystem", "buffers", "git_status", "nx-console" },
    ["nx-console"] = {
      auto_refresh_on_workspace_change = true,
    },
  },
}
