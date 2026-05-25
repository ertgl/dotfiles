local M = {}

function M.get_lspconfig_package_names()
  return {
    "ansiblels",
    "ast_grep",
    "astro",
    "autotools_ls",
    "basedpyright",
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
    "fish_lsp",
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
end

function M.get_mason_package_names()
  return {
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
end

function M.get_unmanaged_server_names()
  return {}
end

function M.enable_unmanaged_servers()
  vim.lsp.enable(M.get_unmanaged_server_names())
end

function M.apply_shared()
  local capabilities_module = require("lsp.capabilities")
  local capabilities = capabilities_module.detect_client_capabilities()

  vim.lsp.config("*", {
    autostart = true,
    capabilities = capabilities,
    ---@diagnostic disable-next-line: unused-local
    root_dir = function(bufnr, callback)
      callback(vim.fn.getcwd())
    end,
    single_file_support = true,
  })
end

function M.setup()
  M.apply_shared()
  M.enable_unmanaged_servers()
end

return M
