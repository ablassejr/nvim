local function apply_evening_cursor()
  local cursor = { fg = "#000000", bg = "#ff0000", ctermfg = 16, ctermbg = 196 }

  for _, group in ipairs({ "Cursor", "lCursor", "CursorIM", "TermCursor" }) do
    vim.api.nvim_set_hl(0, group, cursor)
  end

  vim.opt.guicursor = table.concat({
    "n-v-c-sm:block-Cursor",
    "i-ci-ve:ver25-Cursor",
    "r-cr-o:hor20-Cursor",
    "t:block-TermCursor",
  }, ",")
end

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "macchiato",
      integrations = {
        aerial = true,
        blink_cmp = true,
        dropbar = { enabled = true, color_mode = true },
        flash = true,
        grug_far = true,
        leap = true,
        lsp_trouble = true,
        mason = true,
        mini = { enabled = true },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
          inlay_hints = { background = true },
        },
        neogit = true,
        neotest = true,
        noice = true,
        notify = true,
        overseer = true,
        snacks = true,
        telescope = { enabled = true },
        treesitter = true,
        which_key = true,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    init = function()
      local group = vim.api.nvim_create_augroup("evening_cursor_contrast", { clear = true })

      vim.api.nvim_create_autocmd("ColorScheme", {
        group = group,
        pattern = "evening",
        callback = apply_evening_cursor,
      })
    end,
    opts = {
      colorscheme = function()
        vim.cmd.colorscheme("evening")
        apply_evening_cursor()
      end,
    },
  },
}
