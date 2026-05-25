local M = {}

function M.get_pack_specs()
  return {
    {
      name = "garbage-day",
      src = "https://github.com/zeioth/garbage-day.nvim",
      version = "2fcc56556281de8ee871a5f3beb9db7ab747ef32",
    },
  }
end

function M.setup()
  local garbage_day = require("garbage-day")

  garbage_day.setup({
    aggressive_mode = false,
    excluded_lsp_clients = {},
    grace_period = 60 * 5,
    retries = 5,
    timeout = 5000,
    wakeup_delay = 1000,
  })
end

return M
