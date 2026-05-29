local function patch_cache(cache)
  if cache._reset_safe_async_cache then
    return cache
  end

  cache.by_bufnr_async = function(cb)
    local key = {}
    cache.cache[key] = {}

    return function(params, done)
      local bufnr = params.bufnr
      cache.cache[key] = cache.cache[key] or {}

      if cache.cache[key][bufnr] == nil then
        cb(params, function(result)
          cache.cache[key] = cache.cache[key] or {}
          cache.cache[key][bufnr] = result or false
          done(vim.deepcopy(cache.cache[key][bufnr]))
        end)
      else
        done(vim.deepcopy(cache.cache[key][bufnr]))
      end
    end
  end

  cache.by_bufroot_async = function(cb)
    local key = {}
    cache.cache[key] = {}

    return function(params, done)
      local root = params.root
      assert(root, "root should not be empty when caching by bufroot")
      cache.cache[key] = cache.cache[key] or {}

      if cache.cache[key][root] == nil then
        cb(params, function(result)
          cache.cache[key] = cache.cache[key] or {}
          cache.cache[key][root] = result or false
          done(vim.deepcopy(cache.cache[key][root]))
        end)
      else
        done(vim.deepcopy(cache.cache[key][root]))
      end
    end
  end

  cache._reset_safe_async_cache = true
  return cache
end

local function install_cache_patch()
  local module = "null-ls.helpers.cache"
  if _G.__none_ls_cache_patch_installed then
    return
  end
  _G.__none_ls_cache_patch_installed = true

  if package.loaded[module] then
    patch_cache(package.loaded[module])
    return
  end

  package.preload[module] = function()
    local root = require("lazy.core.config").options.root
    local path = root .. "/none-ls.nvim/lua/null-ls/helpers/cache.lua"
    local cache = assert(loadfile(path))()
    return patch_cache(cache)
  end
end

return {
  {
    "nvimtools/none-ls.nvim",
    init = function(plugin)
      install_cache_patch()
      LazyVim.on_very_lazy(function()
        LazyVim.format.register({
          name = "none-ls.nvim",
          priority = 200,
          primary = true,
          format = function(buf)
            return LazyVim.lsp.format({
              bufnr = buf,
              filter = function(client)
                return client.name == "null-ls"
              end,
            })
          end,
          sources = function(buf)
            local sources = require("null-ls.sources").get_available(vim.bo[buf].filetype, "NULL_LS_FORMATTING") or {}
            return vim.tbl_map(function(source)
              return source.name
            end, sources)
          end,
        })
      end)
    end,
  },
}
