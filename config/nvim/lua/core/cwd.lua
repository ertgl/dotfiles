local M = {}

M.prioritized_marker_groups = {
  {
    ".cargo",
    ".git",
    ".vscode",
  },
  {
    "Cargo.toml",
    "go.mod",
    "Makefile",
    "mix.exs",
    "package.json",
    "pyproject.toml",
    "tsconfig.json",
  },
}

--- @param path string
M.chdir = function(path)
  vim.api.nvim_set_current_dir(path)
  vim.fn.chdir(path, "tabpage")
  vim.fn.chdir(path, "window")
end

M.chdir_to_initial_pwd = function()
  M.chdir(M.get_initial_pwd())
end

--- @param source? integer|string
--- @param marker_groups? string[][]
M.determine_root = function(source, marker_groups)
  if not source then
    local cwd = vim.fn.getcwd()
    local bufname = vim.fn.expand("%:p")

    if bufname and bufname ~= "" then
      source = bufname
    else
      source = cwd
    end
  end

  marker_groups = marker_groups or M.prioritized_marker_groups

  for _, marker_group in ipairs(marker_groups) do
    local root = vim.fs.root(source, marker_group)

    if root then
      return root
    end
  end

  return nil
end

M.get_pwd = function()
  return vim.env.PWD
end

M._initial_pwd = M.get_pwd()

M.get_initial_pwd = function()
  return M._initial_pwd
end

--- @param source? integer|string
M.maybe_chdir_for_source = function(source)
  local root = M.determine_root(source)

  if root then
    M.chdir(root)
    return true
  end

  return false
end

M.setup = function()
  if vim.g.vscode then
    return
  end

  M.setup_autocmd()
end

M.setup_autocmd = function()
  vim.api.nvim_create_autocmd("BufEnter", {
    callback = function(ctx)
      if not M.maybe_chdir_for_source(ctx.buf) then
        M.chdir_to_initial_pwd()
      end
    end,
  })
end

return M
