local M = {}

function M.get_pack_specs()
  return {
    {
      name = "treesitter",
      src = "https://github.com/nvim-treesitter/nvim-treesitter",
      version = "2b50ab5ccbcd9e5708deb351308edd738adbf84c",
    },
  }
end

function M.setup_pack_autocmds()
  local handle_pack_changed = function(ev)
    if
      ev.data.spec.name == "treesitter"
      and (ev.data.kind == "install" or ev.data.kind == "update")
    then
      M.install_or_update_parsers()
    end
  end

  vim.api.nvim_create_autocmd("PackChanged", {
    callback = handle_pack_changed,
  })
end

function M.setup()
  local treesitter = require("nvim-treesitter")
  local treesitter_config = require("nvim-treesitter.config")

  local syntax_config = require("syntax.config")
  local treesitter_parser_names = syntax_config.get_treesitter_parser_names()

  treesitter_config.setup({
    auto_install = true,
    ---@diagnostic disable-next-line: unused-local
    disable = function(lang, buf)
      local max_filesize = 1024 * 200
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    ensure_installed = treesitter_parser_names,
    highlight = {
      enabled = true,
      additional_vim_regex_highlighting = false,
    },
    ignore_install = {},
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<S-C-Right>",
        node_incremental = "<S-C-Right>",
        node_decremental = "<S-C-Left>",
        scope_incremental = "<S-C-M-Right>",
      },
    },
    indent = {
      enabled = true,
    },
    modules = {},
    sync_install = true,
  })

  treesitter.setup()

  M.setup_folding()
  M.setup_indent()
  M.setup_languages()
  M.setup_autocmds()
end

function M.setup_folding()
  vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.o.foldlevelstart = 99
  vim.o.foldmethod = "expr"
end

function M.setup_indent()
  vim.o.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

function M.setup_languages()
  vim.treesitter.language.register("bash", "tmux")
  vim.treesitter.language.register("python", "spec")
end

function M.setup_autocmds()
  local treesitter = require("nvim-treesitter")

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(ev)
      local bufnr = ev.buf
      local buf = nil

      if vim.api.nvim_buf_is_valid(bufnr) then
        buf = vim.bo[bufnr]
      end

      if not buf then
        return
      end

      local file_type = buf.filetype

      if not file_type then
        return
      end

      local parser_name = vim.treesitter.language.get_lang(file_type) or file_type

      local function start_treesitter()
        vim.treesitter.start(bufnr, parser_name)
      end

      local ok, parser = pcall(vim.treesitter.get_parser, 0, parser_name)
      if ok and parser then
        start_treesitter()
      else
        if vim.tbl_contains(treesitter.get_available(), parser_name) then
          vim.notify("Installing Tree-sitter parser: " .. parser_name)
          treesitter.install({ parser_name })
          start_treesitter()
        end
      end
    end,
  })
end

function M.install_or_update_parsers()
  local treesitter = require("nvim-treesitter")

  local syntax_config = require("syntax.config")
  local treesitter_parser_names = syntax_config.get_treesitter_parser_names()

  treesitter.install(treesitter_parser_names):wait(false)
  treesitter.update(treesitter_parser_names):wait(false)
end

return M
