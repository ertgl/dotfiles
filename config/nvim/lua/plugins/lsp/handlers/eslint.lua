local disable_linters = function()
  local linter_manager = require("config.linter_manager")

  linter_manager.disable_by_name("eslint_d")
  vim.g.disable_linter_eslint_d = true
end

local setup_lsp = function(opts)
  local fidget = require("fidget")

  local linter_manager = require("config.linter_manager")

  opts.settings = {
    codeActionOnSave = {
      enable = true,
      mode = "all",
    },
    packageManager = "yarn",
  }

  local super_on_attach = opts.on_attach

  opts.on_attach = function(client, bufnr)
    if super_on_attach then
      super_on_attach(client, bufnr)
    end

    if linter_manager.is_enabled("eslint_d") then
      fidget.notify("The linter eslint_d is disabled because LSP is taking over.", vim.log.levels.INFO, {
        key = "eslint_lsp_is_taking_over_eslint_d_linter",
      })
    end

    client.config.settings.workingDirectory = {
      directory = client.config.root_dir,
    }

    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end

  disable_linters()
end

return setup_lsp
