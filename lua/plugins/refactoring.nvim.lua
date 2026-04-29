-- Upstream refactoring.nvim removed its bundled telescope extension (commit 7bcb7f7,
-- a declared breaking change). LazyVim's editor.refactoring extra still calls
-- load_extension("refactoring") and uses telescope.extensions.refactoring.refactors()
-- in its <leader>rs picker. Override both surfaces with select_refactor(), which
-- uses vim.ui.select and is the upstream-recommended replacement.
return {
  {
    "ThePrimeagen/refactoring.nvim",
    config = function(_, opts)
      require("refactoring").setup(opts)
    end,
    keys = {
      {
        "<leader>rs",
        function()
          require("refactoring").select_refactor()
        end,
        mode = { "n", "x" },
        desc = "Refactor",
      },
    },
  },
}
