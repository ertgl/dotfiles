-- local config_finder = require("config.finder")

local root_markers = {
  "sgconfig.yaml",
  "sgconfig.yml",
}

-- local config_file_path = config_finder.find(root_markers)

-- local is_lsp_enabled = not not config_file_path

return {
  root_markers = root_markers,
  -- settings = {
  --   enable = is_lsp_enabled,
  -- },
}
