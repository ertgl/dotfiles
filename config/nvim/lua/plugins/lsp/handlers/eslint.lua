local disable_eslintd = function()
  local lint = require("lint")

  for linter_idx, linter in ipairs(lint.linters) do
    if linter == "eslint_d" then
      table.remove(lint.linters, linter_idx)
    end
  end

  for _, linters in pairs(lint.linters_by_ft) do
    for linter_idx, linter in ipairs(linters) do
      if linter == "eslint_d" then
        table.remove(linters, linter_idx)
      end
    end
  end

  vim.g.disable_linter_eslint_d = true
end

local setup_eslint = function(opts)
  local fidget = require("fidget")

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

    fidget.notify("The linter eslint_d is disabled because LSP is taking over.", vim.log.levels.INFO, {
      key = "eslint_lsp_is_taking_over_eslint_d_linter",
    })

    client.config.settings.workingDirectory = {
      directory = client.config.root_dir,
    }

    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end

  disable_eslintd()
end

return setup_eslint
