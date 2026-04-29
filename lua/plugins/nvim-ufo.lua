-- LSP-powered semantic folding with fold preview

return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  event = "VeryLazy",
  keys = {
    { "zR", function() require("ufo").openAllFolds() end, desc = "Open all folds" },
    { "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
    { "zK", function() require("ufo").peekFoldedLinesUnderCursor() end, desc = "Peek fold" },
  },
  opts = {
    provider_selector = function(_, _, buftype)
      if buftype == "nofile" or buftype == "terminal" then
        return ""
      end
      return { "lsp", "indent" }
    end,
  },
  init = function()
    vim.o.foldmethod = "expr"
    vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  end,
  config = function(_, opts)
    -- Module-name collision workaround: lewis6991/async.nvim (pulled by the
    -- refactoring extra) and kevinhwang91/promise-async both ship lua/async.lua
    -- at the rtp top level. Whichever lazy-loads first wins package.loaded.async,
    -- and the loser's consumer errors ("attempt to call a table value" spam on
    -- every BufWinEnter from nui popups, splits, and blink.cmp completion menus).
    -- Fix: prime the cache with promise-async's modules, eagerly load every ufo
    -- submodule so their `local async/promise = require(...)` upvalues close over
    -- the correct reference, then release the cache for async.nvim to reclaim.
    local data = vim.fn.stdpath("data")
    local saved_async, saved_promise = package.loaded.async, package.loaded.promise
    package.loaded.async = loadfile(data .. "/lazy/promise-async/lua/async.lua")()
    package.loaded.promise = loadfile(data .. "/lazy/promise-async/lua/promise.lua")()

    for _, mod in ipairs({
      "ufo.utils",
      "ufo.bufmanager",
      "ufo.provider.lsp.fastfailure",
      "ufo.provider.lsp.coc",
      "ufo.provider.lsp.nvim",
      "ufo.provider.lsp",
      "ufo.provider",
      "ufo.fold",
      "ufo.preview",
    }) do
      pcall(require, mod)
    end

    require("ufo").setup(opts)

    package.loaded.async = saved_async
    package.loaded.promise = saved_promise
  end,
}
