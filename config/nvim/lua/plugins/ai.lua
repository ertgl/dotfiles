return {
  {
    "github/copilot.vim",
    enabled = false,
    cond = not (vim.g.nvcat or vim.g.vscode),
    event = "BufRead",
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          if not client then
            return
          end

          if client.name ~= "GitHub Copilot" then
            return
          end

          client.config.autostart = true
          client.config.cmd_cwd = vim.fn.getcwd()
        end,
      })
    end,
  },
}
