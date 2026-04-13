-- JetBrains-style reference/implementation counts above functions

return {
  "Wansmer/symbol-usage.nvim",
  event = "LspAttach",
  opts = {
    vt_position = "above",
    references = { enabled = true, include_declaration = false },
    definition = { enabled = false },
    implementation = { enabled = true },
  },
}
