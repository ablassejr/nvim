local ruff_config_files = { "ruff.toml", ".ruff.toml", "pyproject.toml" }

local function has_ruff_config(path)
  local name = vim.fs.basename(path)
  if name == "ruff.toml" or name == ".ruff.toml" then
    return true
  end

  local ok, lines = pcall(vim.fn.readfile, path, "", 200)
  if not ok then
    return false
  end

  for _, line in ipairs(lines) do
    if line:match("^%s*%[tool%.ruff") then
      return true
    end
  end

  return false
end

local function ruff_config(ctx)
  local configs = vim.fs.find(ruff_config_files, { upward = true, path = ctx.dirname, limit = math.huge })
  for _, path in ipairs(configs) do
    if has_ruff_config(path) then
      return path
    end
  end
end

local function ruff_config_args(_, ctx)
  local config = ruff_config(ctx)
  return config and { "--config", config } or {}
end

local function ruff_config_cwd(self, ctx)
  local config = ruff_config(ctx)
  if config then
    return vim.fs.dirname(config)
  end

  return require("conform.util").root_file(ruff_config_files)(self, ctx)
end

return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = { "ruff_format", "ruff_organize_imports" },
    },
    formatters = {
      ruff_format = {
        append_args = ruff_config_args,
        cwd = ruff_config_cwd,
      },
      ruff_organize_imports = {
        append_args = ruff_config_args,
        cwd = ruff_config_cwd,
      },
    },
  },
}
