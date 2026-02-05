-- Plugin: HakonHarnes/img-clip.nvim
-- Paste images from clipboard into markup files (Markdown, Neorg, LaTeX, etc.).
-- Complements image.nvim which renders images; this plugin handles saving + inserting markup.

return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from clipboard" },
  },
  opts = {
    default = {

      -- Save images in an 'assets' subfolder relative to the current file
      dir_path = "assets",
      relative_to_current_file = false,
      use_absolute_path = true,
      -- Timestamp-based filenames, no prompt interruption
      file_name = "%Y-%m-%d-%H-%M-%S",
      prompt_for_file_name = false,

      -- Drag and drop support
      drag_and_drop = {
        enabled = true,
        insert_mode = false,
      },
    },

    -- Filetype-specific templates (defaults are sensible; only override if needed)
    filetypes = {
      markdown = {
        url_encode_path = true,
        template = "![$CURSOR]($FILE_PATH)",
        download_images = false,
      },
      norg = {
        template = ".image $FILE_PATH",
      },
    },
  },
}
