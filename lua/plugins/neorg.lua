-- Plugin: nvim-neorg/neorg
-- Organizer, note-taking, and knowledge base in Neovim.
-- Includes core.latex.renderer for inline LaTeX rendering in .norg files
-- (only when image.nvim is available — skipped in headless mode).

return {
  "nvim-neorg/neorg",
  lazy = false,
  version = "*",
  dependencies = {
    { "3rd/image.nvim", optional = true },
  },
  config = function()
    -- Symlink rock-built tree-sitter parsers into site/parser/ so nvim-treesitter can find them.
    -- lazy.nvim builds rocks into lazy-rocks/ and adds to package.cpath, but nvim-treesitter
    -- searches the rtp (vim.api.nvim_get_runtime_file), not package.cpath.
    local rocks_root = vim.fn.stdpath("data") .. "/lazy-rocks"
    local site_parser = vim.fn.stdpath("data") .. "/site/parser"
    vim.fn.mkdir(site_parser, "p")
    for _, entry in ipairs({
      { rock = "tree-sitter-norg", parser = "norg.so" },
      { rock = "tree-sitter-norg-meta", parser = "norg_meta.so" },
    }) do
      local src = rocks_root .. "/" .. entry.rock .. "/lib/lua/5.1/parser/" .. entry.parser
      local dst = site_parser .. "/" .. entry.parser
      if vim.uv.fs_stat(src) and not vim.uv.fs_stat(dst) then
        vim.uv.fs_symlink(src, dst)
      end
    end

    -- Ensure @neorg.rendered.latex has an explicit fg color.
    -- The slate colorscheme's Normal group lacks an fg attribute (relies on terminal default),
    -- which causes neorg's compute_foreground() to crash with: format(nil) at module.lua:87
    local normal_fg = vim.api.nvim_get_hl(0, { name = "Normal", link = false }).fg
    vim.api.nvim_set_hl(0, "@neorg.rendered.latex", { fg = normal_fg or 0xc8c8c8 })

    -- Build the module list. Only load core.latex.renderer when image.nvim is present.
    local modules = {
      ["core.defaults"] = {},
      ["core.concealer"] = {},
      ["core.dirman"] = {
        config = {
          workspaces = {
            notes = "~/notes",
          },
          default_workspace = "notes",
        },
      },
    }

    local has_image = pcall(require, "image")
    if has_image then
      modules["core.latex.renderer"] = {
        config = {
          conceal = true,
          dpi = 350,
          render_on_enter = false,
          scale = 1,
        },
      }
    end

    require("neorg").setup({ load = modules })

    vim.wo.foldlevel = 99
    vim.wo.conceallevel = 2
  end,
}
