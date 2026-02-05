-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local set = vim.keymap.set
set("n", "<leader>xS", "<cmd>Trouble symbols<CR>", { desc = "Trouble Symbols" })
set("n", "<leader>ns", "<cmd>NoiceSnacks<CR>", { desc = "Noice Snacks" })
set("n", "<leader>gH", function() Snacks.dashboard.open() end, { desc = "Dashboard" })
set("n", "<leader>gp", function() Snacks.picker.projects() end, { desc = "Projects" })
set("n", "<leader>gr", function() Snacks.picker.github({ state = "open" }) end, { desc = "Open Pull Requests" })
set("n", "<leader>gR", function() Snacks.picker.github({ state = "all" }) end, { desc = "All Pull Requests" })

-- Which-key group descriptions for custom plugin namespaces
local ok, wk = pcall(require, "which-key")
if ok then
  wk.add({
    { "<leader>a", group = "ai" },
    { "<leader>ac", group = "claude code" },
    { "<leader>g", group = "git" },
    { "<leader>k", group = "sidekick" },
    { "<leader>L", group = "latex" },
    { "<leader>o", group = "opencode" },
    { "<leader>T", group = "todos" },
  })
end
