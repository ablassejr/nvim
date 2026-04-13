-- LSP features for embedded code blocks (Python in markdown, SQL in strings)

return {
  "jmbuhr/otter.nvim",
  ft = { "markdown", "norg", "quarto" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {},
}
