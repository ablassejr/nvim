-- ftplugin/codecompanion.lua
-- Make the CodeCompanion chat buffer scrollable and clickable.
-- Runs after CodeCompanion sets filetype = "codecompanion", so these
-- window-local options override the plugin defaults.

local wo = vim.wo
local bo = vim.bo

-- Scrolling: smooth scroll-wheel experience with context lines
wo.scrolloff = 4
wo.smoothscroll = true

-- Clickable: cursorline gives visual feedback on mouse position
wo.cursorline = true
wo.number = false
wo.relativenumber = false
wo.signcolumn = "no"

-- Wrapping: long LLM responses wrap at word boundaries
wo.wrap = true
wo.linebreak = true
wo.breakindent = true

-- Buffer: allow mouse-driven edits in the prompt area at the bottom
bo.modifiable = true
