local M = {}

M.setup = function()
  M.create_autocmd()
end

M.create_autocmd = function()
  vim.api.nvim_create_autocmd("BufEnter", {
    callback = function(ctx)
      local root = vim.fs.root(ctx.buf, {
        ".git",
        "Cargo.toml",
        "go.mod",
        "Makefile",
        "mix.exs",
        "package.json",
        "pyproject.toml",
      })

      if root then
        vim.fn.chdir(root)
      end
    end,
  })
end

return M
