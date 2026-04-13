-- Sign column lightbulb when code actions are available

return {
  "kosayoda/nvim-lightbulb",
  event = "LspAttach",
  opts = {
    autocmd = { enabled = true },
    sign = { enabled = true, text = "" },
  },
}
