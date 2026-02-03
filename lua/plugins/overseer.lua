-- Plugin: stevearc/overseer.nvim
-- Task runner and job management

return {
  "stevearc/overseer.nvim",
  cmd = { "OverseerRun", "OverseerToggle" },
  opts = {
    -- Link with nvim-dap for preLaunchTask/postDebugTask
    dap = true,
    
    task_list = {
      direction = "bottom",
      min_height = 25,
      max_height = 25,
      default_detail = 1,
    },
    
    -- Component aliases for default tasks
    component_aliases = {
      default = {
        { "display_duration", detail_level = 2 },
        "on_output_summarize",
        "on_exit_set_status",
        "on_complete_notify",
        "on_complete_dispose",
      },
    },
  },
}
