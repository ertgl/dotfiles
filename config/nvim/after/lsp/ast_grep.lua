local lsp_manager = require("config.lsp_manager")

local config_file_path = lsp_manager.find_config_file_path({
  "sgconfig.yaml",
  "sgconfig.yml",
})

return {
  autostart = not not config_file_path,
}
