-- Incremental selection state (replaces nvim-treesitter module removed in main branch)
local stack = {}
local stack_buf = -1

local function select_node(buf, node)
  local sr, sc, er, ec = node:range()
  if ec == 0 and er > sr then
    er = er - 1
    local line = vim.api.nvim_buf_get_lines(buf, er, er + 1, false)[1]
    ec = line and #line or 0
  end
  vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
  vim.cmd("normal! v")
  vim.api.nvim_win_set_cursor(0, { er + 1, math.max(ec - 1, 0) })
end

local function init_or_grow()
  local buf = vim.api.nvim_get_current_buf()
  local mode = vim.fn.mode()

  if mode == "n" then
    local ok, node = pcall(vim.treesitter.get_node)
    if not ok or not node then
      vim.cmd("normal! j")
      return
    end
    stack = { node }
    stack_buf = buf
    select_node(buf, node)
  else
    if buf ~= stack_buf or #stack == 0 then return end
    local parent = stack[#stack]:parent()
    if not parent then return end
    table.insert(stack, parent)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)
    select_node(buf, parent)
  end
end

local function shrink()
  local buf = vim.api.nvim_get_current_buf()
  if buf ~= stack_buf or #stack <= 1 then return end
  table.remove(stack)
  local node = stack[#stack]
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)
  select_node(buf, node)
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      vim.api.nvim_create_autocmd("BufReadPost", {
        callback = function()
          local buf = vim.api.nvim_get_current_buf()
          if vim.treesitter.get_parser(buf, nil, { error = false }) then
            vim.wo.foldmethod = "expr"
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          end
        end,
      })
    end,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "bash",
        "html",
        "javascript",
        "json",
        "latex",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      })
    end,
    keys = {
      { "<CR>", init_or_grow, mode = { "n", "x" }, desc = "Increment Selection" },
      { "<BS>", shrink, mode = "x", desc = "Decrement Selection" },
    },
  },
}
