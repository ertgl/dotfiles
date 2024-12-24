local lspconfig_ensure_installed = {
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
  "jedi_language_server",
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
  "stimulus_ls",
  "tailwindcss",
  "taplo",
  "ts_ls",
  "vimls",
  "yamlls",
  "zls",
}

local mason_ensure_installed = {
  "actionlint",
  "astro-language-server",
  "autotools-language-server",
  "bash-language-server",
  "clang-format",
  "clangd",
  "commitlint",
  "css-lsp",
  "css-variables-language-server",
  "cssmodules-language-server",
  "diagnostic-languageserver",
  "django-template-lsp",
  "docker-compose-language-service",
  "dockerfile-language-server",
  "editorconfig-checker",
  "elixir-ls",
  "erlang-ls",
  "eslint_d",
  "gopls",
  "jedi-language-server",
  "jinja-lsp",
  "json-lsp",
  "jsonld-lsp",
  "lua-language-server",
  "mdx-analyzer",
  "mypy",
  -- "nginx-language-server",
  "python-lsp-server",
  "ruff",
  "rust-analyzer",
  "shellcheck",
  "sql-formatter",
  "stimulus-language-server",
  "stylelint-lsp",
  "stylua",
  "tailwindcss-language-server",
  "taplo",
  "typescript-language-server",
  "xmlformatter",
  "yaml-language-server",
  "yamlfmt",
  "zls",
}

return {
  {
    "williamboman/mason.nvim",
    cond = not vim.g.vscode,
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
    cond = not vim.g.vscode,
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
    cond = not vim.g.vscode,
    -- event = "VeryLazy",
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")
      local lsp_manager = require("config.lsp_manager")

      local capabilities = lsp_manager.detect_capabilities()

      mason_lspconfig.setup({
        automatic_installation = {
          exclude = {},
        },
        ensure_installed = lspconfig_ensure_installed,
      })

      local setup_handlers = {
        eslint = require("plugins.lsp.handlers.eslint"),
        jsonls = require("plugins.lsp.handlers.jsonls"),
        yamlls = require("plugins.lsp.handlers.yamlls"),
      }

      mason_lspconfig.setup_handlers({
        function(server_name)
          local server_opts = {
            autostart = true,
            capabilities = capabilities,
            ---@diagnostic disable-next-line: unused-local
            on_attach = function(client, bufnr)
              vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
            end,
            ---@diagnostic disable-next-line: unused-local
            root_dir = function(filename, bufnr)
              -- local ancestor_git_dir = vim.fs.dirname(vim.fs.find(".git", { path = filename, upward = true })[1])
              -- if ancestor_git_dir then
              --   return ancestor_git_dir
              -- end
              return vim.loop.cwd()
            end,
            single_file_support = true,
          }

          if setup_handlers[server_name] then
            local new_server_opts = setup_handlers[server_name](server_opts)
            if new_server_opts then
              server_opts = new_server_opts
            end
          end

          lspconfig[server_name].setup(server_opts)
        end,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    cond = not vim.g.vscode,
    -- event = "BufEnter",
    config = function()
      local lspconfig = require("lspconfig")

      local lsp_manager = require("config.lsp_manager")

      local capabilities = lsp_manager.detect_capabilities()

      lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
        autostart = true,
        capabilities = capabilities,
        ---@diagnostic disable-next-line: unused-local
        root_dir = function(filename, bufnr)
          -- local ancestor_git_dir = vim.fs.dirname(vim.fs.find(".git", { path = filename, upward = true })[1])
          -- if ancestor_git_dir then
          --   return ancestor_git_dir
          -- end
          return vim.loop.cwd()
        end,
        single_file_support = true,
      })

      lspconfig.fish_lsp.setup({})
    end,
  },

  {
    "tamago324/nlsp-settings.nvim",
    cond = not vim.g.vscode,
    -- event = "VeryLazy",
    config = function()
      local nlspsettings = require("nlspsettings")

      ---@diagnostic disable-next-line: missing-fields
      nlspsettings.setup({
        append_default_schemas = true,
        config_home = vim.fn.stdpath("config") .. "/nlsp-settings",
        ignored_servers = {},
        loader = "json",
        local_settings_dir = ".lsp",
        local_settings_root_markers_fallback = {
          ".git",
          ".lsp",
        },
      })
    end,
  },

  {
    "onsails/lspkind.nvim",
    cond = not vim.g.vscode,
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
    cond = not vim.g.vscode,
    -- event = "VeryLazy",
    -- lazy = true,
  },

  {
    "folke/lazydev.nvim",
    cond = not vim.g.vscode,
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
    "luckasranarison/tailwind-tools.nvim",
    cond = not vim.g.vscode,
    -- event = "VeryLazy",
    build = ":UpdateRemotePlugins",
    opts = {
      cmp = {
        highlight = "background",
      },
      document_color = {
        debounce = 750,
        enabled = true,
        inline_symbol = "■",
        kind = "inline",
      },
      server = {
        override = false,
      },
    },
  },

  {
    "hinell/lsp-timeout.nvim",
    cond = not vim.g.vscode,
    -- event = "VeryLazy",
    init = function()
      vim.g.lspTimeoutConfig = {
        silent = false,
        startTimeout = 1000 * 1,
        stopTimeout = 1000 * 60 * 5,
      }
    end,
  },
}
