-- Plugin: iurimateus/luasnip-latex-snippets.nvim
-- Installed via store.nvim

return {
    "iurimateus/luasnip-latex-snippets.nvim",
    dependencies = {
        "L3MON4D3/LuaSnip",
        "lervag/vimtex"
    },
    config = function()
        require "luasnip-latex-snippets".setup(

        )
        -- or setup({ use_treesitter = true })
        require("luasnip").config.setup {
            enable_autosnippets = true
        }
    end,
    event = "VeryLazy"
}