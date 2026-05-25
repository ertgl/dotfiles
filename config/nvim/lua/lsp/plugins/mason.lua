local M = {}

function M.get_pack_specs()
  return {
    {
      name = "mason",
      src = "https://github.com/mason-org/mason.nvim",
      version = "44d1e90e1f66e077268191e3ee9d2ac97cc18e65",
    },
    {
      name = "mason-lspconfig",
      src = "https://github.com/mason-org/mason-lspconfig.nvim",
      version = "a676ab7282da8d651e175118bcf54483ca11e46d",
    },
    {
      name = "mason-tool-installer",
      src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
      version = "443f1ef8b5e6bf47045cb2217b6f748a223cf7dc",
    },
  }
end

function M.setup()
  local mason = require("mason")

  local borders = require("ui.borders")

  local borders_array = borders.as_float_borders_array()

  mason.setup({
    pip = {
      upgrade_pip = false,
    },
    ui = {
      border = borders_array,
      check_outdated_packages_on_open = false,
    },
  })

  M.setup_mason_lspconfig()
  M.setup_mason_tool_installer()
end

function M.setup_mason_lspconfig()
  local mason_lspconfig = require("mason-lspconfig")

  local lsp_config = require("lsp.config")

  mason_lspconfig.setup({
    automatic_enable = {
      exclude = {
        "ast_grep",
      },
    },
    ensure_installed = lsp_config.get_lspconfig_package_names(),
  })
end

function M.setup_mason_tool_installer()
  local mason_tool_installer = require("mason-tool-installer")

  local lsp_config = require("lsp.config")

  M.setup_mason_tool_installer_autocmds()

  mason_tool_installer.setup({
    auto_update = false,
    ensure_installed = lsp_config.get_mason_package_names(),
    integrations = {
      ["mason-lspconfig"] = true,
    },
    run_on_start = false,
  })
end

function M.setup_mason_tool_installer_autocmds()
  local runtime = require("core.runtime")

  local fidget = nil

  if not vim.g.vscode and not runtime.is_headless() then
    fidget = require("fidget")
  end

  local fidget_notification_handle = nil

  vim.api.nvim_create_autocmd("User", {
    pattern = "MasonToolsStartingInstall",
    callback = function()
      vim.schedule(function()
        if fidget ~= nil then
          fidget_notification_handle = fidget.progress.handle.create({
            title = "Mason Tool Installer",
            message = "Installing missing tools...",
          })
        end
      end)
    end,
  })

  vim.api.nvim_create_autocmd("User", {
    pattern = "MasonToolsUpdateCompleted",
    callback = function()
      vim.schedule(function()
        if fidget_notification_handle then
          fidget_notification_handle:report({
            message = "Installation completed.",
          })

          fidget_notification_handle:finish()
        end
      end)
    end,
  })
end

return M
