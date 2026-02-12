-- Plugin: LuaSnip — powerful snippet engine with dynamic features
-- Loads both snipmate-format snippets and Lua-based snippets

return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  dependencies = {
    "rafamadriz/friendly-snippets", -- Community snippet collection
  },
  build = "make install_jsregexp", -- Optional: enables advanced regex features
  event = "InsertEnter",
  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local sn = ls.snippet_node
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node
    local c = ls.choice_node
    local d = ls.dynamic_node
    local r = ls.restore_node
    local fmt = require("luasnip.extras.fmt").fmt
    local fmta = require("luasnip.extras.fmt").fmta
    local rep = require("luasnip.extras").rep

    -- Helper to add snippets to multiple filetypes
    local function add_snippets_multi(filetypes, snippets)
      for _, ft in ipairs(filetypes) do
        ls.add_snippets(ft, snippets)
      end
    end

    -- ── Configuration ────────────────────────────────
    ls.config.set_config({
      history = true, -- Keep last snippet around for jumping back
      updateevents = "TextChanged,TextChangedI", -- Update as you type
      enable_autosnippets = true,
      ext_opts = {
        [require("luasnip.util.types").choiceNode] = {
          active = {
            virt_text = { { "←", "Error" } }, -- Visual indicator for choice nodes
          },
        },
      },
    })

    -- ── Load snippets ────────────────────────────────
    -- Load existing snipmate-format snippets from ~/.config/nvim/snippets/
    require("luasnip.loaders.from_snipmate").lazy_load({
      paths = { vim.fn.stdpath("config") .. "/snippets" },
    })

    -- Load friendly-snippets (community collection)
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Load Lua-based snippets from ~/.config/nvim/luasnippets/
    require("luasnip.loaders.from_lua").lazy_load({
      paths = { vim.fn.stdpath("config") .. "/luasnippets" },
    })

    -- ── Keymaps ──────────────────────────────────────
    -- Tab: Expand snippet or jump forward
    vim.keymap.set({ "i", "s" }, "<Tab>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      else
        return "<Tab>"
      end
    end, { expr = true, silent = true })

    -- Shift-Tab: Jump backward
    vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      else
        return "<S-Tab>"
      end
    end, { expr = true, silent = true })

    -- Ctrl-L: Cycle through choice node options (forward)
    vim.keymap.set({ "i", "s" }, "<C-l>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, { silent = true })

    -- Ctrl-H: Cycle through choice node options (backward)
    vim.keymap.set({ "i", "s" }, "<C-h>", function()
      if ls.choice_active() then
        ls.change_choice(-1)
      end
    end, { silent = true })

    -- ── Example Advanced Snippets ────────────────────
    -- These showcase LuaSnip's advanced features
    -- Place custom snippets in ~/.config/nvim/luasnippets/<filetype>.lua

    -- Python: Function with docstring (dynamic)
    ls.add_snippets("python", {
      s(
        "deff",
        fmt(
          [[
def {}({}):
    """{}

    Args:
        {}

    Returns:
        {}
    """
    {}
]],
          {
            i(1, "function_name"),
            i(2, "args"),
            i(3, "Brief description"),
            i(4, "arg descriptions"),
            i(5, "return description"),
            i(0, "pass"),
          }
        )
      ),
    })

    -- Python: Class with choice node for inheritance
    ls.add_snippets("python", {
      s(
        "clss",
        fmt(
          [[
class {}{}:
    def __init__(self{}):
        {}
        {}
]],
          {
            i(1, "ClassName"),
            c(2, {
              t(""),
              sn(nil, { t("("), i(1, "BaseClass"), t(")") }),
            }),
            c(3, {
              t(""),
              sn(nil, { t(", "), i(1, "args") }),
            }),
            f(function(args)
              local base = args[1][1]
              if base:match("%(.*%)") then
                return "super().__init__()"
              else
                return ""
              end
            end, { 2 }),
            i(0, "pass"),
          }
        )
      ),
    })

    -- All filetypes: Insert current date
    ls.add_snippets("all", {
      s("date", f(function()
        return os.date("%Y-%m-%d")
      end)),
    })

    -- All filetypes: Insert current datetime
    ls.add_snippets("all", {
      s("datetime", f(function()
        return os.date("%Y-%m-%d %H:%M:%S")
      end)),
    })

    -- All filetypes: Insert filename without extension
    ls.add_snippets("all", {
      s("fname", f(function()
        return vim.fn.expand("%:t:r")
      end)),
    })

    -- JavaScript/TypeScript: Console log with variable name
    add_snippets_multi({ "javascript", "typescript" }, {
      s(
        "clg",
        fmt([[console.log("{}: ", {})]], {
          rep(1),
          i(1, "variable"),
        })
      ),
    })

    -- JavaScript/TypeScript: Function with JSDoc
    add_snippets_multi({ "javascript", "typescript" }, {
      s(
        "fndoc",
        fmt(
          [[
/**
 * {}
 * @param {{{}}} {}
 * @returns {{{}}}
 */
function {}({}) {{
  {}
}}
]],
          {
            i(1, "Description"),
            i(2, "type"),
            i(3, "param"),
            i(4, "returnType"),
            i(5, "functionName"),
            rep(3),
            i(0, "// implementation"),
          }
        )
      ),
    })

    -- C/C++: Header guard (dynamic based on filename)
    add_snippets_multi({ "c", "cpp" }, {
      s(
        "guard",
        fmt(
          [[
#ifndef {}
#define {}

{}

#endif // {}
]],
          {
            f(function()
              return vim.fn.expand("%:t:r"):upper() .. "_H"
            end),
            f(function()
              return vim.fn.expand("%:t:r"):upper() .. "_H"
            end),
            i(0),
            f(function()
              return vim.fn.expand("%:t:r"):upper() .. "_H"
            end),
          }
        )
      ),
    })

    -- Lua: Require with choice between module styles
    ls.add_snippets("lua", {
      s(
        "req",
        fmt([[local {} = require("{}")]], {
          i(1, "module"),
          rep(1),
        })
      ),
    })
  end,
}
