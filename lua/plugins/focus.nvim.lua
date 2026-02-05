-- Plugin: nvim-focus/focus.nvim
-- Golden-ratio window resizing with visual focus cues and directional splits.

return {
  "nvim-focus/focus.nvim",
  version = "*",
  lazy = false,
  cmd = {
    "FocusToggle",
    "FocusEnable",
    "FocusDisable",
    "FocusSplitNicely",
    "FocusSplitLeft",
    "FocusSplitDown",
    "FocusSplitUp",
    "FocusSplitRight",
    "FocusEqualise",
    "FocusMaximise",
    "FocusMaxOrEqual",
    "FocusSplitCycle",
  },
  keys = {
    { "<leader>wh", "<cmd>FocusSplitLeft<cr>", desc = "Split left" },
    { "<leader>wj", "<cmd>FocusSplitDown<cr>", desc = "Split down" },
    { "<leader>wk", "<cmd>FocusSplitUp<cr>", desc = "Split up" },
    { "<leader>wl", "<cmd>FocusSplitRight<cr>", desc = "Split right" },
    { "<leader>wn", "<cmd>FocusSplitNicely<cr>", desc = "Split nicely (golden)" },
    { "<leader>we", "<cmd>FocusEqualise<cr>", desc = "Equalise splits" },
    { "<leader>wm", "<cmd>FocusMaxOrEqual<cr>", desc = "Maximize / equalise toggle" },
    { "<leader>wt", "<cmd>FocusToggle<cr>", desc = "Toggle focus resizing" },
  },
  opts = {
    autoresize = {
      enable = true,
      width = 120,
      height = 0,
      minwidth = 20,
      minheight = 5,
      height_quickfix = 10,
    },
    split = {
      bufnew = false,
      tmux = false,
    },
    ui = {
      number = false,
      relativenumber = false,
      hybridnumber = false,
      absolutenumber_unfocussed = false,
      cursorline = true,
      cursorcolumn = false,
      colorcolumn = { enable = false },
      signcolumn = true,
      winhighlight = true,
    },
  },
  config = function(_, opts)
    require("focus").setup(opts)

    -- Disable focus resizing only for file explorer windows.
    -- focus.nvim uses vim.b.focus_disable (per-buffer) set via autocmd.
    local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })

    vim.api.nvim_create_autocmd("FileType", {
      group = augroup,
      pattern = { "neo-tree", "snacks_explorer" },
      callback = function()
        vim.b.focus_disable = true
      end,
      desc = "Disable focus autoresize for file explorer",
    })
  end,
}
