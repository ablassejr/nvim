return {
  "MagicDuck/grug-far.nvim",
  config = function()
    require("grug-far").setup({
      debounceMs = 500,
      minSearchChars = 2,
      maxSearchMatches = 2000,
      maxLineLength = 1000,
      engines = {
        ripgrep = {
          showReplaceDiff = true,
        },
      },
      keymaps = {
        replace = { n = "<localleader>r" },
        qflist = { n = "<localleader>q" },
        syncLocations = { n = "<localleader>s" },
        syncLine = { n = "<localleader>l" },
        close = { n = "<localleader>c" },
        historyOpen = { n = "<localleader>t" },
        historyAdd = { n = "<localleader>a" },
        refresh = { n = "<localleader>f" },
        openLocation = { n = "<localleader>o" },
        openNextLocation = { n = "<down>" },
        openPrevLocation = { n = "<up>" },
        gotoLocation = { n = "<enter>" },
        pickHistoryEntry = { n = "<enter>" },
        abort = { n = "<localleader>b" },
        help = { n = "g?" },
        toggleShowCommand = { n = "<localleader>w" },
        swapEngine = { n = "<localleader>e" },
        previewLocation = { n = "<localleader>i" },
        swapReplacementInterpreter = { n = "<localleader>x" },
        applyNext = { n = "<localleader>j" },
        applyPrev = { n = "<localleader>k" },
        syncNext = { n = "<localleader>n" },
        syncPrev = { n = "<localleader>p" },
        syncFile = { n = "<localleader>v" },
        nextInput = { n = "<tab>" },
        prevInput = { n = "<s-tab>" },
      },
    })
  end,
  keys = {
    {
      "<leader>sr",
      function()
        require("grug-far").open()
      end,
      desc = "Search and Replace (grug-far)",
    },
    {
      "<leader>sR",
      function()
        require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
      end,
      desc = "Search and Replace (current file)",
    },
    {
      "<leader>sr",
      function()
        require("grug-far").with_visual_selection()
      end,
      mode = "v",
      desc = "Search and Replace (selection)",
    },
    {
      "<leader>sR",
      function()
        require("grug-far").with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })
      end,
      mode = "v",
      desc = "Search and Replace (selection, current file)",
    },
    {
      "<leader>sw",
      function()
        require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
      end,
      desc = "Search Word Under Cursor (grug-far)",
    },
  },
}
