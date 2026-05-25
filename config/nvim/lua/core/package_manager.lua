local M = {}

function M.get_pack_spec_arrays()
  return {
    require("diagnostic.plugins.trouble").get_pack_specs(),

    require("editor.completion.plugins.auto-indent").get_pack_specs(),
    require("editor.completion.plugins.autopairs").get_pack_specs(),
    require("editor.completion.plugins.cmp").get_pack_specs(),
    require("editor.completion.plugins.luasnip").get_pack_specs(),
    require("editor.completion.plugins.surround").get_pack_specs(),

    require("editor.formatter.plugins.conform").get_pack_specs(),

    require("editor.linter.plugins.lint").get_pack_specs(),

    require("editor.refactoring.plugins.grug-far").get_pack_specs(),
    require("editor.refactoring.plugins.ssr").get_pack_specs(),

    require("lsp.plugins.garbage-day").get_pack_specs(),
    require("lsp.plugins.lspconfig").get_pack_specs(),
    require("lsp.plugins.lspkind").get_pack_specs(),
    require("lsp.plugins.mason").get_pack_specs(),

    require("ui.plugins.actions-preview").get_pack_specs(),
    require("ui.plugins.colorizer").get_pack_specs(),
    require("ui.plugins.diagflow").get_pack_specs(),
    require("ui.plugins.fidget").get_pack_specs(),
    require("ui.plugins.flash").get_pack_specs(),
    require("ui.plugins.gitsigns").get_pack_specs(),
    require("ui.plugins.hlslens").get_pack_specs(),
    require("ui.plugins.lualine").get_pack_specs(),
    require("ui.plugins.mini-indentscope").get_pack_specs(),
    require("ui.plugins.scrollbar").get_pack_specs(),
    require("ui.plugins.telescope").get_pack_specs(),
    require("ui.plugins.treesitter-context").get_pack_specs(),
    require("ui.plugins.treewalker").get_pack_specs(),
    require("ui.plugins.web-devicons").get_pack_specs(),
    require("ui.plugins.which-key").get_pack_specs(),
    require("ui.plugins.yazi").get_pack_specs(),
    require("ui.themes.gruvbox").get_pack_specs(),

    require("syntax.parser.plugins.treesitter").get_pack_specs(),

    require("utility.plugins.lazydev").get_pack_specs(),
    require("utility.plugins.plenary").get_pack_specs(),

    require("session.plugins.auto-session").get_pack_specs(),
  }
end

function M.get_pack_specs()
  local pack_specs = {}

  for _, spec_array in ipairs(M.get_pack_spec_arrays()) do
    for _, spec in ipairs(spec_array) do
      table.insert(pack_specs, spec)
    end
  end

  return pack_specs
end

function M.get_active_package_names()
  return vim
    .iter(vim.pack.get())
    :filter(function(package)
      return package.active
    end)
    :map(function(package)
      return package.spec.name
    end)
    :totable()
end

function M.get_passive_package_names()
  return vim
    .iter(vim.pack.get())
    :filter(function(package)
      return not package.active
    end)
    :map(function(package)
      return package.spec.name
    end)
    :totable()
end

function M.setup_pack_autocmds()
  require("editor.completion.plugins.luasnip").setup_pack_autocmds()

  require("syntax.parser.plugins.treesitter").setup_pack_autocmds()

  require("ui.plugins.telescope").setup_pack_autocmds()
end

function M.install_all_packages()
  vim.pack.add(M.get_pack_specs())
end

function M.update_active_packages()
  vim.pack.update(M.get_active_package_names())
end

function M.delete_active_packages()
  vim.pack.del(M.get_active_package_names())
end

function M.delete_passive_packages()
  vim.pack.del(M.get_passive_package_names())
end

function M.delete_all_packages()
  M.delete_active_packages()
  M.delete_passive_packages()
end

function M.setup()
  M.install_all_packages()
end

return M
