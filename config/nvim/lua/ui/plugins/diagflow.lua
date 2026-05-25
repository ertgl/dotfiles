local M = {}

function M.get_pack_specs()
  return {
    {
      name = "diagflow",
      src = "https://github.com/dgagn/diagflow.nvim",
      version = "b13321b517ff64bf42eeac2214085d3c76d83a0d",
    }
  }
end

function M.setup()
  if vim.g.vscode then
    return
  end

  local diagflow = require("diagflow")

  diagflow.setup({
    placement = "top",
    scope = "line",
    toggle_event = {
      "InsertEnter",
      "InsertLeave",
    },
    update_event = {
      "BufReadPost",
      "DiagnosticChanged",
    },
  })
end

return M
