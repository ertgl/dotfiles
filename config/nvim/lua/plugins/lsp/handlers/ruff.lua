local disable_ruff = function()
  local lint = require("lint")

  for linter_idx, linter in ipairs(lint.linters) do
    if linter == "ruff" then
      table.remove(lint.linters, linter_idx)
    end
  end

  for _, linters in pairs(lint.linters_by_ft) do
    for linter_idx, linter in ipairs(linters) do
      if linter == "ruff" then
        table.remove(linters, linter_idx)
      end
    end
  end

  vim.g.disable_linter_ruff = true
end

local setup_ruff = function(opts)
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

    fidget.notify("The linter ruff is disabled because LSP is taking over.", vim.log.levels.INFO, {
      key = "ruff_lsp_is_taking_over_ruff_linter",
    })
  end

  disable_ruff()
end

return setup_ruff
