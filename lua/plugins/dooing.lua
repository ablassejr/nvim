-- Plugin: atiladefreitas/dooing
-- Minimalist todo manager in a floating window, with per-project todos.
-- Default keymaps live under <leader>t* which collides with LazyVim's
-- test/terminal namespace, so they are remapped to <leader>T* to match
-- the existing "todos" which-key group registered in lua/config/keymaps.lua.
return {
  "atiladefreitas/dooing",
  event = "VeryLazy",
  opts = {
    save_path = vim.fn.stdpath("data") .. "/dooing_todos.json",
    pretty_print_json = true,

    window = {
      width = 60,
      height = 22,
      border = "rounded",
      position = "center",
    },

    per_project = {
      enabled = true,
      default_filename = "dooing.json",
      auto_gitignore = "prompt",
      on_missing = "prompt",
      auto_open_project_todos = false,
    },

    nested_tasks = {
      enabled = true,
      indent = 2,
      retain_structure_on_complete = true,
      move_completed_to_end = true,
    },

    due_notifications = {
      enabled = true,
      on_startup = false,
      on_open = true,
    },

    keymaps = {
      toggle_window = "<leader>Td",
      open_project_todo = "<leader>TD",
      show_due_notification = "<leader>TN",
      new_todo = "i",
      create_nested_task = "<leader>Tn",
      toggle_todo = "x",
      delete_todo = "d",
      delete_completed = "D",
      close_window = "q",
      undo_delete = "u",
      add_due_date = "H",
      remove_due_date = "r",
      toggle_help = "?",
      toggle_tags = "t",
      toggle_priority = "<Space>",
      clear_filter = "c",
      edit_todo = "e",
      edit_tag = "e",
      edit_priorities = "p",
      delete_tag = "d",
      search_todos = "/",
      add_time_estimation = "T",
      remove_time_estimation = "R",
      import_todos = "I",
      export_todos = "E",
      remove_duplicates = "<leader>TX",
      open_todo_scratchpad = "<leader>Tp",
      refresh_todos = "f",
    },
  },
}
