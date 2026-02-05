return {
  "FabijanZulj/blame.nvim",
  cmd = "BlameToggle",
  keys = {
    { "<leader>gb", "<cmd>BlameToggle window<cr>", desc = "Git Blame (window)" },
    { "<leader>gB", "<cmd>BlameToggle virtual<cr>", desc = "Git Blame (virtual text)" },
  },
  opts = {
    date_format = "%Y-%m-%d",
    relative_date_if_recent = true,
    virtual_style = "right_align",
    focus_blame = true,
    merge_consecutive = false,
    max_summary_width = 40,
    blame_options = { "-w" },
    commit_detail_view = "vsplit",
    mappings = {
      commit_info = "K",
      stack_push = "<Tab>",
      stack_pop = "<S-Tab>",
      show_commit = "<CR>",
      close = { "q", "<Esc>" },
    },
  },
}
