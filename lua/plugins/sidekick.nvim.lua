-- Plugin: folke/sidekick.nvim
-- AI sidekick with Copilot NES + CLI tools

return {
  "folke/sidekick.nvim",
  event = "VeryLazy",
  opts = function()
    local function has_copilot(buf)
      local clients
      if vim.lsp.get_clients then
        clients = vim.lsp.get_clients({ bufnr = buf })
      else
        clients = vim.lsp.get_active_clients({ bufnr = buf })
      end

      for _, client in ipairs(clients or {}) do
        if client.name == "copilot" or client.name == "copilot-lsp" then
          return true
        end
      end

      return false
    end

    return {
      jump = {
        jumplist = true,
      },
      signs = {
        enabled = true,
        icon = "> ",
      },
      nes = {
        enabled = function(buf)
          if vim.g.sidekick_nes == false or vim.b[buf].sidekick_nes == false then
            return false
          end
          return has_copilot(buf)
        end,
        debounce = 150,
        trigger = {
          events = { "InsertLeave", "TextChanged", "User SidekickNesDone" },
        },
        clear = {
          events = { "TextChangedI", "TextChanged", "BufWritePre", "InsertEnter" },
          esc = true,
        },
        diff = {
          inline = "lines",
        },
      },
      cli = {
        watch = true,
        win = {
          layout = "right",
          split = {
            width = 80,
            height = 20,
          },
        },
        mux = {
          backend = "zellij",
          enabled = false,
        },
        tools = {
          opencode = { cmd = { "opencode" }, url = "https://github.com/sst/opencode" },
          claude = { cmd = { "claude" }, url = "https://github.com/anthropics/claude-code" },
          codex = { cmd = { "codex", "--search" }, url = "https://github.com/openai/codex" },
          copilot = { cmd = { "copilot", "--banner" }, url = "https://github.com/github/copilot-cli" },
          aider = { cmd = { "aider" }, url = "https://github.com/Aider-AI/aider" },
        },
        prompts = {
          explain = "Explain this code",
          diagnostics = {
            msg = "What do the diagnostics in this file mean?",
            diagnostics = true,
          },
          diagnostics_all = {
            msg = "Can you help me fix these issues?",
            diagnostics = { all = true },
          },
          fix = {
            msg = "Can you fix the issues in this code?",
            diagnostics = true,
          },
          review = {
            msg = "Can you review this code for any issues or improvements?",
            diagnostics = true,
          },
          optimize = "How can this code be optimized?",
          tests = "Can you write tests for this code?",
          file = { location = { row = false, col = false } },
          position = {},
        },
      },
      copilot = {
        status = {
          enabled = true,
        },
      },
      debug = false,
    }
  end,
  -- stylua: ignore
  keys = {
    {
      "<leader>kn",
      function()
        if not require("sidekick").nes_jump_or_apply() then
          vim.notify("No next edit suggestion", vim.log.levels.INFO)
        end
      end,
      desc = "Sidekick next edit",
    },
    {
      "<C-]>",
      function()
        if not require("sidekick").nes_jump_or_apply() then
          vim.notify("No next edit suggestion", vim.log.levels.INFO)
        end
      end,
      desc = "Accept NES suggestion",
      mode = { "n" },
    },
    { "<leader>kc", function() require("sidekick.cli").toggle() end, desc = "Sidekick CLI toggle", mode = { "n", "v" } },
    { "<leader>kt", function() require("sidekick.cli").select() end, desc = "Sidekick select tool" },
    { "<leader>ks", function() require("sidekick.cli").send({ selection = true }) end, desc = "Sidekick send selection", mode = "v" },
    { "<leader>kp", function() require("sidekick.cli").prompt() end, desc = "Sidekick prompts", mode = { "n", "v" } },
    { "<leader>kf", function() require("sidekick.cli").focus() end, desc = "Sidekick focus", mode = { "n", "v" } },
    { "<leader>ka", function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end, desc = "Sidekick Claude toggle", mode = { "n", "v" } },
  },
}
