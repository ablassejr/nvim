return {
  -- leap.nvim moved from GitHub to Codeberg; override LazyVim extra URL
  -- and replace deprecated add_default_mappings() with modern <Plug> mappings
  {
    "ggandor/leap.nvim",
    url = "https://codeberg.org/andyg/leap.nvim",
    keys = {
      { "s", "<Plug>(leap)", mode = { "n", "x", "o" }, desc = "Leap" },
      { "S", "<Plug>(leap-from-window)", mode = { "n" }, desc = "Leap from Window" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end

      -- Enhanced f/F/t/T: 1-char search with clever-f traversal (replaces flit.nvim)
      -- Based on official README recipe: autojump in n/o modes, labels in visual mode
      local clever = require("leap.user").with_traversal_keys
      local clever_f = clever("f", "F")
      local clever_t = clever("t", "T")

      local function as_ft(key_specific_args)
        local common_args = {
          inputlen = 1,
          inclusive = true,
          opts = {
            labels = "", -- force autojump to first match
            safe_labels = vim.fn.mode(1):match("[no]") and "" or nil, -- labels only in visual mode
          },
        }
        return vim.tbl_deep_extend("keep", common_args, key_specific_args)
      end

      for key, key_specific_args in pairs({
        f = { opts = clever_f },
        F = { backward = true, opts = clever_f },
        t = { offset = -1, opts = clever_t },
        T = { backward = true, offset = 1, opts = clever_t },
      }) do
        vim.keymap.set({ "n", "x", "o" }, key, function()
          leap.leap(as_ft(key_specific_args))
        end)
      end
    end,
  },

  -- flit.nvim is deprecated; its f/t functionality is now built into leap.nvim
  { "ggandor/flit.nvim", enabled = false },
}
