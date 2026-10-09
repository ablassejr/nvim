-- Plugin: roobert/surround-ui.nvim
-- Installed via store.nvim

return {
    "roobert/surround-ui.nvim",
    event = "VeryLazy",
    dependencies = {
        "kylechui/nvim-surround",
        "folke/which-key.nvim"
    },
    config = function()
        require("surround-ui").setup(
            {
                root_key = "S"
            }
        )
    end
}