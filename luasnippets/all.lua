-- Global snippets (available in all filetypes)
-- See :h luasnip for documentation

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local sn = ls.snippet_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
  -- Simple text expansion
  s("lorem", {
    t({
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    }),
  }),

  -- Current user (from git config)
  s("me", f(function()
    local name = vim.fn.system("git config user.name"):gsub("\n", "")
    return name ~= "" and name or "User"
  end)),

  -- Email signature
  s(
    "sig",
    fmt(
      [[
Best regards,
{}
{}
]],
      {
        f(function()
          return vim.fn.system("git config user.name"):gsub("\n", "")
        end),
        f(function()
          return vim.fn.system("git config user.email"):gsub("\n", "")
        end),
      }
    )
  ),

  -- Box comment
  s(
    "box",
    fmt(
      [[
// ══════════════════════════════════════════════
// {}
// ══════════════════════════════════════════════
{}]],
      {
        i(1, "Title"),
        i(0),
      }
    )
  ),

  -- ISO timestamp
  s("iso", f(function()
    return os.date("!%Y-%m-%dT%H:%M:%SZ")
  end)),

  -- UUID v4 (simple version)
  s("uuid", f(function()
    local random = math.random
    local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
    return (
      template:gsub("[xy]", function(c)
        local v = (c == "x") and random(0, 0xf) or random(8, 0xb)
        return string.format("%x", v)
      end)
    )
  end)),
}
