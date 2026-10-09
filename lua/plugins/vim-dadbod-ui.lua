return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  },
  cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
  keys = {
    { "<leader>D", "<cmd>tab DBUI<CR>", desc = "Open DBUI" },
    { "<leader>Dt", "<cmd>DBUIToggle<CR>", desc = "Toggle DBUI" },
    { "<leader>Da", "<cmd>DBUIAddConnection<CR>", desc = "Add DB Connection" },
    { "<leader>Df", "<cmd>DBUIFindBuffer<CR>", desc = "Find DB Buffer" },
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_auto_execute_table_helpers = 1
    vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/dadbod"

    vim.g.db_ui_env_variable_url = "DATABASE_URL"
    vim.g.db_ui_env_variable_name = "DATABASE_NAME"
  end,
}
