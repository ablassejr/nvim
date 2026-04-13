-- Populate diagnostics for ALL project files, not just open buffers

return {
  "artemave/workspace-diagnostics.nvim",
  event = "LspAttach",
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
          require("workspace-diagnostics").setup({ workspace_files = function() return vim.fn.systemlist("git ls-files") end })
        end
      end,
    })
  end,
}
