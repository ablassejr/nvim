-- Enhanced Metals: best-effort compilation + scalafmt/scalafix paths

return {
  "scalameta/nvim-metals",
  opts = function(_, metals_config)
    metals_config.settings = vim.tbl_deep_extend("force", metals_config.settings or {}, {
      enableBestEffort = true,
    })
    return metals_config
  end,
}
