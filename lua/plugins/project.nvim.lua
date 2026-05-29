-- Plugin: ahmedkhalf/project.nvim
-- Project root detection + history. The Telescope `projects` extension
-- is loaded from lua/plugins/telescope.nvim.lua so this spec does not
-- need to know about Telescope directly.
return {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  opts = {
    detection_methods = { "lsp", "pattern" },
    patterns = {
      ".git",
      "_darcs",
      ".hg",
      ".bzr",
      ".svn",
      "Makefile",
      "package.json",
      "pyproject.toml",
      "Cargo.toml",
      "go.mod",
      "pom.xml",
      "build.gradle",
      "stylua.toml",
      "lazy-lock.json",
    },
    ignore_lsp = { "null-ls", "none-ls", "copilot" },
    exclude_dirs = { "~/.cargo/*", "~/.local/share/nvim/lazy/*" },
    show_hidden = false,
    silent_chdir = true,
    scope_chdir = "global",
    datapath = vim.fn.stdpath("data"),
  },
  config = function(_, opts)
    require("project_nvim").setup(opts)
  end,
}
