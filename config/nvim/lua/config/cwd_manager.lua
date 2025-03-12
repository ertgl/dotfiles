local M = {}

M.prioritized_marker_groups = {
  -- Prioritize `.git` folder over the other markers
  -- to make it compatible with monorepo projects.
  { ".git" },
  {
    "Cargo.toml",
    "go.mod",
    "Makefile",
    "mix.exs",
    "package.json",
    "pyproject.toml",
  },
}

--- @param source? integer|string
M.determine_root = function(source)
  source = source or vim.fn.bufname() or vim.fn.getcwd()

  for _, marker_group in ipairs(M.prioritized_marker_groups) do
    local root = vim.fs.root(source, marker_group)

    if root then
      return root
    end
  end

  return nil
end

--- @param source? integer|string
M.maybe_chdir = function(source)
  local root = M.determine_root(source)
  if root then
    vim.fn.chdir(root)
    return true
  end
  return false
end

M.setup = function()
  M.create_autocmd()
end

M.create_autocmd = function()
  vim.api.nvim_create_autocmd("BufEnter", {
    callback = function(ctx)
      if not M.maybe_chdir(ctx.buf) then
        vim.fn.chdir(vim.fn.getcwd())
      end
    end,
  })
end

return M
