local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- lazy.nvim stops subprocess timeout timers after Git commands finish, but it
-- does not close them. A background update check can therefore leave one
-- libuv handle behind per plugin and make Neovim spin in loop_close on exit.
-- Close each guard as soon as its subprocess coroutine completes. Keeping the
-- patch here also covers explicit :Lazy check/sync runs.
local lazy_process = require("lazy.manage.process")
if not lazy_process.exit_hang_guard then
  local spawn = lazy_process.spawn

  lazy_process.spawn = function(...)
    local task = spawn(...)
    task:on("done", function()
      local timeout = task.timeout
      if timeout and not timeout:is_closing() then
        timeout:close()
      end
      task.timeout = nil
    end)
    return task
  end

  lazy_process.exit_hang_guard = true
end

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "slate", "tokyonight", "habamax", "cyberdream" } },
  checker = {
    -- Avoid spawning a Git process for every plugin in ordinary editor
    -- sessions. Updates remain available explicitly through :Lazy check/sync.
    enabled = false,
    notify = false, -- notify on update
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
