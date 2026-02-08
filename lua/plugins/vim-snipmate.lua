-- Plugin: vim-snipmate — lightweight snippet engine
-- Reads .snippets files from ~/.config/nvim/snippets/<filetype>.snippets

return {
  {
    "garbas/vim-snipmate",
    dependencies = {
      "honza/vim-snippets", -- community snippet collection
      "tomtom/tlib_vim",
      "MarcWeber/vim-addon-mw-utils",
    },
    event = "InsertEnter",
    -- init runs BEFORE the plugin loads, so g:snipMate is set before
    -- plugin/snipMate.vim reads it and adds its own keys (get_snippets, etc.)
    init = function()
      vim.g.snippets_dir = vim.fn.stdpath("config") .. "/snippets"
      vim.g.snipMate = {
        snippet_version = 1,
      }
    end,
    config = function()
      -- Tab: expand snippet or jump to next placeholder
      vim.keymap.set("i", "<Tab>", "<Plug>snipMateNextOrTrigger", { noremap = false })
      vim.keymap.set("s", "<Tab>", "<Plug>snipMateNextOrTrigger", { noremap = false })

      -- Shift+Tab: jump to previous placeholder
      vim.keymap.set("i", "<S-Tab>", "<Plug>snipMatePrevOrTrigger", { noremap = false })
      vim.keymap.set("s", "<S-Tab>", "<Plug>snipMatePrevOrTrigger", { noremap = false })
    end,
  },
}
