-- Plugin: r-pletnev/pdfreader.nvim
-- Installed via store.nvim

return {
    "r-pletnev/pdfreader.nvim",
    lazy = false,
    dependencies = {
        "folke/snacks.nvim", -- image rendering via snacks
        "nvim-telescope/telescope.nvim" -- pickers
    },
    opts = {
        mode = 0, -- 0: standard images, 1: dark images, 2: text-only
    },
    config = function(_, opts)
        -- Ensure TERM is set for terminal detection
        vim.env.TERM = vim.env.TERM or "xterm-ghostty"

        -- Use custom validation that supports ghostty
        package.loaded["pdfreader.validation"] = require("vim.pdfreader.validation")

        require("pdfreader").setup(opts)
    end,
    keys = {
        { "<leader>fp", "<cmd>Telescope pdfreader<cr>", desc = "PDF Reader: Open recent" },
    },
}