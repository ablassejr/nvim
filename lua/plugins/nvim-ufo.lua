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
    provider_selector = function(_, filetype, buftype)
      if buftype == "nofile" or buftype == "terminal" then
        return ""
      end
      local ok = pcall(vim.treesitter.get_parser, 0, filetype)
      if ok then
        return { "lsp", "treesitter" }
      end
      return { "lsp", "indent" }
    end,
  },
  init = function()
    vim.o.foldmethod = "expr"
    vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  end,
}
