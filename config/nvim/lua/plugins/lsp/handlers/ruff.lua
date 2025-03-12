local disable_linters = function()
  local linter_manager = require("config.linter_manager")

  linter_manager.disable_by_name("ruff")
  vim.g.disable_linter_ruff = true
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

    if linter_manager.is_enabled("ruff") then
      fidget.notify("The linter ruff is disabled because LSP is taking over.", vim.log.levels.INFO, {
        key = "ruff_lsp_is_taking_over_ruff_linter",
      })
    end
  end

  disable_linters()
end

return setup_lsp
