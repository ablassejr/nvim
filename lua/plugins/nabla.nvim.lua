-- Plugin: jbyuki/nabla.nvim
-- Renders LaTeX equations as ASCII art in a popup or as virtual text.
-- Works in any buffer with LaTeX (including .tex files).

return {
  "jbyuki/nabla.nvim",
  lazy = true,
  keys = {
    {
      "<leader>p",
      function()
        require("nabla").popup({ border = "rounded" })
      end,
      desc = "Nabla: preview LaTeX equation",
    },
    {
      "<leader>P",
      function()
        require("nabla").toggle_virt({ autogen = true, silent = true })
      end,
      desc = "Nabla: toggle inline virtual text",
    },
  },
}
