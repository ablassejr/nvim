-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Workaround: Neovim nightly (v0.12.0-dev) _folding_range.lua:235 uses
-- assert(vim.lsp.get_client_by_id(...)) inside an LspNotify callback.
-- The client can be detached before the callback fires (race condition),
-- causing "Error in LspNotify Autocommands".
-- Override: lua/vim/lsp/_folding_range.lua shadows the runtime copy with
-- a nil-guard on line 235. Remove once upstream patches this.

-- Fix: Snacks.nvim prompt buffers break backspace for the first character.
-- Root cause: buftype=prompt + vim.bo.modified=false on TextChangedI makes
-- Neovim treat freshly typed text as pre-existing (neovim/neovim#14116).
-- Overriding buftype to "nofile" after Snacks sets it to "prompt" fixes this.
-- Snacks.input and Snacks.picker.input both have their own CR/Esc keymaps,
-- so prompt buffer callbacks (prompt_setcallback) aren't needed.
local snacks_prompt_fix = vim.api.nvim_create_augroup("snacks_prompt_fix", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = snacks_prompt_fix,
  pattern = { "snacks_picker_input", "snacks_input" },
  callback = function(ev)
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(ev.buf) then
        vim.bo[ev.buf].buftype = "nofile"
      end
    end)
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = snacks_prompt_fix,
  callback = function(ev)
    local ft = vim.bo[ev.buf].filetype
    if ft == "snacks_picker_input" or ft == "snacks_input" then
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(ev.buf) then
          vim.bo[ev.buf].buftype = "nofile"
        end
      end)
    end
  end,
})
