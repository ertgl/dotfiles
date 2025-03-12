local fidget = require("fidget")

local linter_manager = require("config.linter_manager")

return {
  on_attach = function(client, bufnr)
    if linter_manager.is_enabled("ruff") then
      fidget.notify("The linter ruff is disabled because LSP is taking over.", vim.log.levels.INFO, {
        key = "ruff_lsp_is_taking_over_ruff_linter",
      })
    end

    linter_manager.disable_by_name("ruff")
    vim.g.disable_linter_ruff = true
  end,
  settings = {
    codeActionOnSave = {
      enable = true,
      mode = "all",
    },
  },
}
