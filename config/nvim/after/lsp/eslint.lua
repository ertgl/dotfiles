local fidget = require("fidget")

local linter_manager = require("config.linter_manager")

return {
  on_attach = function(client, bufnr)
    if linter_manager.is_enabled("eslint_d") then
      fidget.notify("The linter eslint_d is disabled because LSP is taking over.", vim.log.levels.INFO, {
        key = "eslint_lsp_is_taking_over_eslint_d_linter",
      })
    end

    client.config.settings.workingDirectory = {
      directory = client.config.root_dir,
    }

    -- if client:supports_method("textDocument/formatting") then
    --   vim.api.nvim_create_autocmd("BufWritePre", {
    --     buffer = bufnr,
    --     command = "EslintFixAll",
    --   })
    -- end

    linter_manager.disable_by_name("eslint_d")
    vim.g.disable_linter_eslint_d = true
  end,
  settings = {
    codeActionOnSave = {
      enable = true,
      mode = "all",
    },
    packageManager = "yarn",
  },
}
