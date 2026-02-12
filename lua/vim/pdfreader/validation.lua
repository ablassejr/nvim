local M = {}

local supported_terminals = { "kitty", "ghostty" }

M.is_supported_terminal = function()
  local term = os.getenv("TERM") or ""
  local term_program = os.getenv("TERM_PROGRAM") or ""

  for _, name in ipairs(supported_terminals) do
    if term:find(name) or term_program:find(name) then
      return true
    end
  end

  if os.getenv("TMUX") then
    return true
  end

  return false
end

M.command_exits = function(cmd)
  if vim and vim.fn and vim.fn.executable then
    return vim.fn.executable(cmd) == 1
  end
  return false
end

local dependencies = {
  {
    command = "magick",
    message = "PDFReader DEPENDENCY MISING ERROR: 'magick' not found in $PATH. Please install ImageMagick.",
  },
  {
    command = "pdftotext",
    message = "PDFReader DEPENDENCY MISSING ERROR: 'pdftotext' not found in $PATH. Please install poppler-utils.",
  },
  {
    command = "pdfinfo",
    message = "PDFReader DEPENDENCY MISSING ERROR: 'pdfinfo' not found $PATH. Please install poppler-utils.",
  },
}

function M.check_depencencies()
  for _, dep in pairs(dependencies) do
    if not M.command_exits(dep.command) then
      vim.notify(dep.message, vim.log.levels.ERROR)
      return false
    end
  end
  return true
end

return M
