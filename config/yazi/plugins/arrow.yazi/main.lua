--- @sync entry

return {
  ---@diagnostic disable-next-line: unused-local
  entry = function(st, job)
    ---@diagnostic disable-next-line: undefined-global
    local current = cx.active.current
    local new = (current.cursor + job.args[1]) % #current.files
    ---@diagnostic disable-next-line: undefined-global
    ya.mgr_emit("arrow", { new - current.cursor })
  end,
}
