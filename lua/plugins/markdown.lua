-- Disable markdownlint-cli2 from the LazyVim markdown extra
return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters["markdownlint-cli2"] = { command = "" }
      for _, key in ipairs({ "markdown", "markdown.mdx" }) do
        local ft = (opts.formatters_by_ft or {})[key]
        if ft then
          opts.formatters_by_ft[key] = vim.tbl_filter(function(f)
            return f ~= "markdownlint-cli2"
          end, ft)
        end
      end
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.sources = vim.tbl_filter(function(source)
        return not source or source.name ~= "markdownlint_cli2"
      end, opts.sources or {})
    end,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = {},
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_filter(function(pkg)
        return pkg ~= "markdownlint-cli2"
      end, opts.ensure_installed or {})
    end,
  },
}
