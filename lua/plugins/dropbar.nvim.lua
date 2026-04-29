-- Interactive winbar breadcrumbs with LSP + treesitter backends

return {
  "Bekaboo/dropbar.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>;",
      function()
        require("dropbar.api").pick()
      end,
      desc = "Dropbar Pick",
    },
  },
  opts = {
    icons = {
      kinds = {
        file_icon = function(path)
          local icon_kind_opts = require("dropbar.configs").opts.icons.kinds
          local file_icon = icon_kind_opts.symbols.File
          local file_icon_hl = "DropBarIconKindFile"

          local ok, devicons = pcall(require, "nvim-web-devicons")
          if not ok then
            return file_icon, file_icon_hl
          end

          local basename = vim.fs.basename(path)
          local ext = vim.fn.fnamemodify(path, ":e")
          local icon_ok, devicon, devicon_hl = pcall(devicons.get_icon, basename, ext, { default = false })
          if icon_ok and devicon then
            return devicon .. " ", devicon_hl
          end

          local buf = vim.iter(vim.api.nvim_list_bufs()):find(function(candidate)
            return vim.api.nvim_buf_get_name(candidate) == path
          end)
          if buf then
            local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })
            local ft_ok, ft_icon, ft_icon_hl = pcall(devicons.get_icon_by_filetype, filetype)
            if ft_ok and ft_icon then
              return ft_icon .. " ", ft_icon_hl
            end
          end

          return file_icon, file_icon_hl
        end,
      },
    },
  },
}
