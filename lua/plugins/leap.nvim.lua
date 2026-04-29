return {
  -- Replace LazyVim extra's deprecated add_default_mappings() with modern <Plug> mappings
  {
    url = "https://codeberg.org/andyg/leap.nvim.git",
    keys = {
      { "s", "<Plug>(leap)", mode = { "n", "x", "o" }, desc = "Leap" },
      { "S", "<Plug>(leap-from-window)", mode = { "n" }, desc = "Leap from Window" },
      -- f/F/t/T must be listed here so lazy.nvim loads the plugin on first press;
      -- the actual leap-powered mappings are created in config() below
      { "f", mode = { "n", "x", "o" }, desc = "Leap f" },
      { "F", mode = { "n", "x", "o" }, desc = "Leap F" },
      { "t", mode = { "n", "x", "o" }, desc = "Leap t" },
      { "T", mode = { "n", "x", "o" }, desc = "Leap T" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end

      -- Enhanced f/F/t/T: 1-char search with clever-f traversal (replaces flit.nvim)
      local clever = require("leap.user").with_traversal_keys
      local clever_f = clever("f", "F")
      local clever_t = clever("t", "T")

      local function as_ft(key_specific_args)
        -- Force autojump to the first match. Leap still labels the remaining
        -- safe targets, so operator-pending commands can refine after landing.
        local common_args = {
          inputlen = 1,
          inclusive = true,
          opts = { labels = "" },
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
}
