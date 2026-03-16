-- Plugin: mfussenegger/nvim-dap
-- Installed via store.nvim

return {
  "mfussenegger/nvim-dap",
  lazy = true,
  -- Load only when debugging is explicitly invoked.
  cmd = {
    "DapContinue",
    "DapToggleBreakpoint",
    "DapClearBreakpoints",
    "DapSetLogLevel",
    "DapShowLog",
    "DapStepInto",
    "DapStepOver",
    "DapStepOut",
    "DapStepBack",
    "DapRunToCursor",
    "DapGoto",
    "DapPause",
    "DapTerminate",
    "DapDisconnect",
    "DapRestart",
    "DapNew",
    "DapRunLast",
    "DapREPL",
    "DapLoadLaunchJSON",
  },
  keys = {
    { "<F5>", function() require("dap").continue() end, desc = "DAP Continue" },
    { "<F10>", function() require("dap").step_over() end, desc = "DAP Step Over" },
    { "<F11>", function() require("dap").step_into() end, desc = "DAP Step Into" },
    { "<S-F11>", function() require("dap").step_out() end, desc = "DAP Step Out" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP Toggle Breakpoint" },
    { "<leader>dq", function() require("dap").terminate() end, desc = "DAP Terminate" },
  },
}
