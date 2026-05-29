-- Plugin: folke/snacks.nvim
-- Installed via store.nvim

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    -- Explorer module is disabled below; unmap the keys LazyVim's
    -- editor.snacks_explorer extra registers so they don't call a dead module.
    { "<leader>E", false },
    { "<leader>fE", false },
    { "<leader>fe", false },
  },
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    keys = {
      {
        "<leader>T.",
        function()
          -- Can implement your own logic for saving files by cwd, project, git branch, etc.
          local data = vim.fn.stdpath("data")
          local root = data .. "/snacks/todo"
          vim.fn.mkdir(root, "p")
          local file = root .. "/todo.md"

          ---@diagnostic disable-next-line: missing-fields
          Snacks.scratch.open({
            file = file,
          })
        end,
        desc = "Toggle Scratch Todo",
      },
    },
    bigfile = {
      enabled = true,
    },
    dashboard = {
      enabled = true,
    },
    explorer = {
      enabled = false,
      replace_netrw = false,
    },
    indent = {
      enabled = true,
    },
    input = {
      enabled = true,
    },
    picker = {
      enabled = true,
      sources = {
        explorer = {
          win = {
            input = {
              keys = {
                ["<CR>"] = {
                  function(win)
                    if vim.fn.mode():sub(1, 1) == "i" then
                      vim.cmd.stopinsert()
                      vim.schedule(function()
                        win:execute("confirm")
                      end)
                    else
                      win:execute("confirm")
                    end
                  end,
                  mode = { "n", "i" },
                  desc = "Confirm",
                },
              },
            },
          },
        },
      },
    },
    notifier = {
      enabled = true,
    },
    quickfile = {
      enabled = true,
    },
    scope = {
      enabled = true,
    },
    scroll = {
      enabled = true,
    },
    statuscolumn = {
      enabled = true,
    },
    terminal = {
      enabled = false,
    },
    words = {
      enabled = true,
    },
  },
}
