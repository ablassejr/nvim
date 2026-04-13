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

-- Buffers
set("n", "<leader>bf", function() Snacks.picker.buffers() end, { desc = "Find Buffers" })
set("n", "<leader>bF", function() Snacks.picker.buffers({ hidden = true, nofile = true }) end, { desc = "Find Buffers (All)" })

-- Overseer (task runner)
set("n", "<leader>oo", "<cmd>OverseerToggle<CR>", { desc = "Toggle Task List" })
set("n", "<leader>or", "<cmd>OverseerRun<CR>", { desc = "Run Task" })
set("n", "<leader>oa", "<cmd>OverseerTaskAction<CR>", { desc = "Task Action" })
set("n", "<leader>oq", "<cmd>OverseerQuickAction<CR>", { desc = "Quick Action" })
set("n", "<leader>os", "<cmd>OverseerShell<CR>", { desc = "Shell" })

-- Which-key group descriptions for custom plugin namespaces
-- (groups already provided by LazyVim: <leader>a, <leader>g, <leader>d, <leader>t, <leader>w, etc.)
local ok, wk = pcall(require, "which-key")
if ok then
  wk.add({
    { "<leader>ac", group = "claude code" },
    { "<leader>k", group = "sidekick" },
    { "<leader>L", group = "latex" },
    { "<leader>M", group = "multicursors" },
    { "<leader>nt", group = "neovim tips" },
    { "<leader>o", group = "overseer" },
    { "<leader>D", group = "database" },
    { "<leader>T", group = "todos" },
  })
end
