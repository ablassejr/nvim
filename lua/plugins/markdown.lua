-- Disable markdownlint from the LazyVim markdown extra
return {
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      opts.sources = vim.tbl_filter(function(source)
        return source ~= require("null-ls").builtins.diagnostics.markdownlint_cli2
      end, opts.sources or {})
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      local ft = opts.formatters_by_ft or {}
      for _, key in ipairs({ "markdown", "markdown.mdx" }) do
        if ft[key] then
          ft[key] = vim.tbl_filter(function(f)
            return f ~= "markdownlint-cli2"
          end, ft[key])
        end
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_filter(function(pkg)
        return pkg ~= "markdownlint-cli2"
      end, opts.ensure_installed or {})
    end,
  },
}
