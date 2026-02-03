-- Plugin: 3rd/image.nvim
-- Renders inline images in Neovim via Kitty graphics protocol.
-- Required by Neorg's core.latex.renderer module.

return {
  "3rd/image.nvim",
  build = false, -- don't build the magick rock; we use magick_cli
  opts = {
    backend = "kitty",
    processor = "magick_cli", -- uses ImageMagick CLI (must be installed)
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        filetypes = { "markdown", "vimwiki" },
      },
      neorg = {
        enabled = true,
        filetypes = { "norg" },
      },
    },
    max_height_window_percentage = 50,
    window_overlap_clear_enabled = false,
    editor_only_render_when_focused = false,
  },
}
