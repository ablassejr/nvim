-- VSCode-style peek for definitions, references, implementations

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            { "gd", "<cmd>Glance definitions<CR>", desc = "Glance Definitions" },
            { "gy", "<cmd>Glance type_definitions<CR>", desc = "Glance Type Definitions" },
            { "gr", "<cmd>Glance references<CR>", desc = "Glance References", nowait = true },
            { "gR", "<cmd>Glance implementations<CR>", desc = "Glance Implementations" },
          },
        },
      },
    },
  },
  {
    "dnlhc/glance.nvim",
    cmd = "Glance",
    config = function()
    local glance = require("glance")
    local actions = glance.actions

    glance.setup({
      height = 22,
      border = {
        enable = true,
        top_char = "─",
        bottom_char = "─",
      },
      list = {
        position = "right",
        width = 0.35,
      },
      preview_win_opts = {
        cursorline = true,
        number = true,
        wrap = false,
        colorcolumn = "",
      },
      theme = {
        enable = true,
        mode = "darken",
      },
      folds = {
        fold_closed = "",
        fold_open = "",
        folded = false,
      },
      indent_lines = {
        enable = true,
        icon = "│",
      },
      winbar = {
        enable = true,
      },
      use_trouble_qf = true,
      mappings = {
        list = {
          ["<C-v>"] = actions.jump_vsplit,
          ["<C-x>"] = actions.jump_split,
          ["<C-t>"] = actions.jump_tab,
        },
      },
    })
  end,
  },
}
