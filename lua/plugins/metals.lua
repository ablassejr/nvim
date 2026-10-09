-- Enhanced Metals: best-effort compilation + scalafmt/scalafix paths

return {
  "scalameta/nvim-metals",
  opts = function(_, metals_config)
    metals_config.settings = vim.tbl_deep_extend("force", metals_config.settings or {}, {
      enableBestEffort = true,
    })
    -- Started via vim.lsp.start, so the lsp-diagnostics ["*"] wildcard
    -- doesn't apply; JVM shutdown is slow enough to hang :qa without this.
    metals_config.exit_timeout = 200
    return metals_config
  end,
}
