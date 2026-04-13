-- Code action with diff preview before applying (snacks picker)

return {
  "rachartier/tiny-code-action.nvim",
  event = "LspAttach",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    picker = "snacks",
  },
  keys = {
    {
      "<leader>ca",
      function()
        require("tiny-code-action").code_action()
      end,
      desc = "Code Action (preview)",
    },
  },
}
