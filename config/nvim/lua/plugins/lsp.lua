local lspconfig_ensure_installed = {
  "ansiblels",
  "ast_grep",
  "astro",
  "autotools_ls",
  "bashls",
  "clangd",
  "css_variables",
  "cssmodules_ls",
  "cssls",
  "diagnosticls",
  "docker_compose_language_service",
  "dockerls",
  "elixirls",
  "elp",
  "eslint",
  -- "fish_lsp",
  "gopls",
  "graphql",
  "html",
  "jinja_lsp",
  "jqls",
  "jsonls",
  "lemminx",
  "lua_ls",
  "mdx_analyzer",
  -- "nginx_language_server",
  "pylsp",
  "remark_ls",
  "ruff",
  "rust_analyzer",
  "stimulus_ls",
  "stylelint_lsp",
  "tailwindcss",
  "taplo",
  "vimls",
  "vtsls",
  "yamlls",
  "zls",
}

local mason_ensure_installed = {
  "actionlint",
  "clang-format",
  "clangd",
  "commitlint",
  "django-template-lsp",
  "editorconfig-checker",
  "eslint_d",
  "jsonld-lsp",
  "mypy",
  "shellcheck",
  "sql-formatter",
  "stylua",
  "xmlformatter",
  "yamlfmt",
}

return {
  {
    "williamboman/mason.nvim",
    cond = not (vim.g.nvcat or vim.g.vscode),
    -- event = "VeryLazy",
    config = function()
      local mason = require("mason")

      mason.setup({
        ui = {
          border = "single",
          check_outdated_packages_on_open = false,
        },
      })
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    cond = not (vim.g.nvcat or vim.g.vscode),
    -- event = "VeryLazy",
    config = function()
      local mason_tool_installer = require("mason-tool-installer")

      mason_tool_installer.setup({
        ensure_installed = mason_ensure_installed,
        integrations = {
          ["mason-lspconfig"] = true,
        },
        run_on_start = true,
      })

      local fidget = require("fidget")

      local fidget_notification_handle = nil

      vim.api.nvim_create_autocmd("User", {
        pattern = "MasonToolsStartingInstall",
        callback = function()
          vim.schedule(function()
            fidget_notification_handle = fidget.progress.handle.create({
              title = "Mason Tool Installer",
              message = "Installing missing tools...",
            })
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
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    cond = not (vim.g.nvcat or vim.g.vscode),
    -- event = "VeryLazy",
    config = function()
      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup({
        automatic_enable = true,
        ensure_installed = lspconfig_ensure_installed,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    cond = not (vim.g.nvcat or vim.g.vscode),
    -- event = "BufEnter",
  },

  {
    "tamago324/nlsp-settings.nvim",
    cond = not (vim.g.nvcat or vim.g.vscode),
    -- event = "VeryLazy",
    config = function()
      local nlspsettings = require("nlspsettings")

      ---@diagnostic disable-next-line: missing-fields
      nlspsettings.setup({
        append_default_schemas = true,
        config_home = vim.fn.stdpath("config") .. "/nlsp-settings",
        ignored_servers = {},
        loader = "json",
        local_settings_dir = "",
        local_settings_root_markers_fallback = {
          ".git",
        },
      })
    end,
  },

  {
    "onsails/lspkind.nvim",
    cond = not (vim.g.nvcat or vim.g.vscode),
    -- event = "BufEnter",
    config = function()
      local lspkind = require("lspkind")

      lspkind.init({
        mode = "symbol_text",
        preset = "codicons",
      })
    end,
  },

  {
    "Bilal2453/luvit-meta",
    cond = not (vim.g.nvcat or vim.g.vscode),
    -- event = "VeryLazy",
    -- lazy = true,
  },

  {
    "folke/lazydev.nvim",
    cond = not (vim.g.nvcat or vim.g.vscode),
    -- event = "VeryLazy",
    ft = "lua",
    opts = {
      library = {
        {
          path = "luvit-meta/library",
          words = {
            "vim%.loop",
            "vim%.uv",
          },
        },
      },
    },
  },

  {
    "hinell/lsp-timeout.nvim",
    cond = not (vim.g.nvcat or vim.g.vscode),
    -- event = "VeryLazy",
    init = function()
      vim.g.lspTimeoutConfig = {
        silent = false,
        startTimeout = 1000 * 1,
        stopTimeout = 1000 * 60 * 5,
      }
    end,
  },

  {
    "aznhe21/actions-preview.nvim",
    cond = not (vim.g.nvcat or vim.g.vscode),
    event = "VeryLazy",
    config = function()
      local actions_preview = require("actions-preview")
      local actions_preview_highlight = require("actions-preview.highlight")
      local telescope_themes = require("telescope.themes")

      local borders = require("config.borders")

      actions_preview.setup({
        backends = {
          "telescope",
        },
        highlight_command = {
          actions_preview_highlight.delta("delta"),
        },
        telescope = telescope_themes.get_dropdown({
          border = true,
          borderchars = {
            borders.top,
            borders.right,
            borders.bottom,
            borders.left,
            borders.top_left,
            borders.top_right,
            borders.bottom_right,
            borders.bottom_left,
          },
          layout_strategy = "vertical",
          layout_config = {
            height = 0.9,
            prompt_position = "top",
            width = 0.9,
          },
        }),
      })
    end,
  },
}
