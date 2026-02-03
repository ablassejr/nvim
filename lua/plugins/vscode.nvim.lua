return {
  "Mofiqul/vscode.nvim",
  config = function()
    require("vscode").setup({
      style = "dark", -- Options: 'dark' or 'light'
      transparent = true,
      italic_comments = true,
      disable_nvimtree_bg = true,
    })
    vim.cmd.colorscheme("vscode")
  end,
}
