-- Move LSP inlay hints from inline to end-of-line
-- Prevents hints from breaking vim motions (w/e/f)

return {
  "chrisgrieser/nvim-lsp-endhints",
  event = "LspAttach",
  opts = {},
}
