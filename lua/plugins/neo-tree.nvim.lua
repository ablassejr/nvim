-- Plugin: nvim-neo-tree/neo-tree.nvim
-- Dedicated file explorer tree (replaces snacks.nvim explorer)

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  lazy = false, -- neo-tree lazy-loads itself
  keys = {
    { "<leader>e", "<Cmd>Neotree toggle<CR>", desc = "Explorer (Neo-tree)" },
    { "<leader>E", "<Cmd>Neotree reveal<CR>", desc = "Explorer reveal file" },
  },
  ---@module "neo-tree"
  ---@type neotree.Config?
  opts = {
    close_if_last_window = true,
    enable_git_status = true,
    enable_diagnostics = true,
    filesystem = {
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = true, -- show filtered items greyed out instead of hiding them
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false,
        hide_by_name = {},
        never_show = { ".DS_Store" },
      },
    },
    window = {
      width = 35,
      mappings = {
        ["<space>"] = "none", -- don't conflict with leader
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true,
        expander_collapsed = "",
        expander_expanded = "",
      },
    },
  },
}
