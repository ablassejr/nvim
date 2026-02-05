-- Override LazyVim's which-key config for faster popup
return {
  "folke/which-key.nvim",
  opts = {
    delay = 0,
    plugins = {
      marks = false,
      registers = false,
      presets = false,
    },
  },
}
