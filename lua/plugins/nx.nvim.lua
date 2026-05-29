return {
  "yardnsm/nx-console.nvim",
  submodules = false,
  dependencies = {
    "nvim-lua/plenary.nvim",

    -- Optional: choose your preferred picker
    "nvim-telescope/telescope.nvim", -- or "ibhagwan/fzf-lua" or "folke/snacks.nvim"

    -- Optional: for projects tree view
    "nvim-neo-tree/neo-tree.nvim",
  },

  opts = {
    -- Your configuration here (see Configuration section)
  },

  keys = {
    {
      "<leader>np",
      function()
        require("nx-console").pickers.projects()
      end,
      desc = "Nx Projects",
    },
    {
      "<leader>nt",
      function()
        require("nx-console").pickers.targets()
      end,
      desc = "Nx Targets",
    },
    {
      "<leader>nT",
      function()
        require("nx-console").pickers.targets_current()
      end,
      desc = "Nx Targets (current file)",
    },
    {
      "<leader>ng",
      function()
        require("nx-console").pickers.generators()
      end,
      desc = "Nx Generators",
    },
  },
}
