local M = {}

M.prioritized_marker_groups = {
  -- Check for a `.git` directory first to make it monorepo-compatible.
  {
    ".git",
  },
  {
    "Cargo.toml",
    "go.mod",
    "Makefile",
    "mix.exs",
    "package.json",
    "pyproject.toml",
  },
}

M.chdir_to_pwd = function()
  vim.fn.chdir(M.get_pwd())
end

--- @param source? integer|string
--- @param marker_groups? string[][]
M.determine_root = function(source, marker_groups)
  source = source or vim.fn.bufname() or vim.fn.getcwd()
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

--- @param source? integer|string
M.maybe_chdir_for_source = function(source)
  local root = M.determine_root(source)
  if root then
    vim.fn.chdir(root)
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
        M.chdir_to_pwd()
      end
    end,
  })
end

return M
