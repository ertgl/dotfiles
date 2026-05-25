local runtime = require("core.runtime")
local is_headless = runtime.is_headless()

local M = {}

function M.setup()
  M.setup_now()
  M.setup_on_vim_enter()
  M.setup_on_ui_enter()
  M.setup_on_buf_enter()
end

function M.setup_now()
  local package_manager = require("core.package_manager")

  require("utility.plugins.plenary").setup()

  require("core.options").setup()
  require("core.cwd").setup()
  require("core.keymaps").setup()

  package_manager.setup_pack_autocmds()
  package_manager.setup()

  require("core.file_types").setup()

  require("ui.options").setup()
  require("ui.color_scheme").setup()
  require("ui.theme").setup()

  if not is_headless then
    require("session.plugins.auto-session").setup()
  end
end

function M.setup_on_vim_enter()
  local function handle_vim_enter()
    require("diagnostic.options").setup()

    require("editor.options").setup()

    require("syntax.config").setup()

    require("syntax.parser.plugins.treesitter").setup()

    require("lsp.config").setup()

    require("lsp.plugins.garbage-day").setup()
    require("lsp.plugins.lspconfig").setup()
    require("lsp.plugins.mason").setup()

    require("utility.plugins.lazydev").setup()

    require("diagnostic.plugins.trouble").setup()
  end

  if is_headless or vim.v.vim_did_enter == 1 then
    handle_vim_enter()
  else
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = handle_vim_enter,
    })
  end
end

function M.setup_on_ui_enter()
  local function handle_ui_enter()
    require("ui.plugins.fidget").setup()
    require("ui.plugins.lualine").setup()
    require("ui.plugins.scrollbar").setup()

    require("ui.backdrop").setup()
    require("ui.borders").setup()
    require("ui.status_column").setup()
    require("ui.plugins.diagflow").setup()

    require("editor.folding").setup()
    require("editor.search.options").setup()

    require("editor.completion.plugins.auto-indent").setup()
    require("editor.completion.plugins.autopairs").setup()
    require("editor.completion.plugins.cmp").setup()
    require("editor.completion.plugins.luasnip").setup()
    require("editor.completion.plugins.surround").setup()

    require("editor.linter.plugins.lint").setup()

    require("editor.refactoring.plugins.grug-far").setup()
    require("editor.refactoring.plugins.ssr").setup()

    require("lsp.plugins.lspkind").setup()

    require("ui.plugins.colorizer").setup()
    require("ui.plugins.gitsigns").setup()
    require("ui.plugins.hlslens").setup()
    require("ui.plugins.mini-indentscope").setup()
    require("ui.plugins.treewalker").setup()
    require("ui.plugins.web-devicons").setup()

    require("ui.plugins.flash").setup()
    require("ui.plugins.which-key").setup()

    require("ui.plugins.telescope").setup()
    require("ui.plugins.actions-preview").setup()

    require("ui.plugins.yazi").setup()
  end

  vim.api.nvim_create_autocmd("UIEnter", {
    callback = handle_ui_enter,
  })
end

function M.setup_on_buf_enter()
  local function handle_buf_enter()
    require("buffer.options").setup()

    require("editor.formatter.plugins.conform").setup()

    require("ui.plugins.treesitter-context").setup()
  end

  vim.api.nvim_create_autocmd("BufEnter", {
    callback = handle_buf_enter,
  })
end

M.setup()
