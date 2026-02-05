-- Override LazyVim's claudecode.nvim keymaps
-- Moves Claude Code from <leader>a* to <leader>ac* to share <leader>a with CodeCompanion

return {
  "coder/claudecode.nvim",
  keys = {
    -- Disable LazyVim defaults (mapped under <leader>a*)
    { "<leader>ac", false },
    { "<leader>af", false },
    { "<leader>ar", false },
    { "<leader>aC", false },
    { "<leader>ab", false },
    { "<leader>as", false, mode = "v" },
    { "<leader>as", false, ft = { "NvimTree", "neo-tree", "oil" } },
    { "<leader>aa", false },
    { "<leader>ad", false },

    -- Re-map under <leader>ac* (ai → claude code)
    { "<leader>ac", "", desc = "+claude code", mode = { "n", "v" } },
    { "<leader>acc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<leader>acf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<leader>acr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { "<leader>acC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<leader>acb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { "<leader>acs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    {
      "<leader>acs",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file",
      ft = { "NvimTree", "neo-tree", "oil" },
    },
    { "<leader>aca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>acd", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
  },
}
