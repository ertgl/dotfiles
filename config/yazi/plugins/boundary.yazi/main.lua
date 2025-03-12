--- @sync entry

return {
  entry = function(st, job)
    local action = job.args[1]

    if action == "toggle-auto-fix" then
      if st.enabled_auto_fix then
        action = "disable-auto-fix"
      else
        action = "enable-auto-fix"
      end
    end

    if action == "fix" then
      if not st.root then
        return
      end
      ---@diagnostic disable-next-line: undefined-global
      if not cx.active.current.cwd:starts_with(st.root) then
        ---@diagnostic disable-next-line: undefined-global
        ya.mgr_emit("plugin", { "pane", "hide-parent" })
        ---@diagnostic disable-next-line: undefined-global
        ya.mgr_emit("cd", { tostring(st.root) })
      ---@diagnostic disable-next-line: undefined-global
      elseif cx.active.current.cwd == st.root then
        ---@diagnostic disable-next-line: undefined-global
        ya.mgr_emit("plugin", { "pane", "hide-parent" })
      else
        ---@diagnostic disable-next-line: undefined-global
        ya.mgr_emit("plugin", { "pane", "show-parent" })
      end
    elseif action == "set-root" then
      ---@diagnostic disable-next-line: undefined-global
      st.root = (job.args[2] and Url(job.args[2])) or cx.active.current.cwd
      ---@diagnostic disable-next-line: undefined-global
      ya.mgr_emit("plugin", { "boundary", "fix" })
    elseif action == "enable-auto-fix" then
      if st.enabled_auto_fix then
        return
      end
      ---@diagnostic disable-next-line: undefined-global
      ps.sub("cd", function()
        ---@diagnostic disable-next-line: undefined-global
        ya.mgr_emit("plugin", { "boundary", "fix" })
      end)
      st.enabled_auto_fix = true
      ---@diagnostic disable-next-line: undefined-global
      ya.mgr_emit("plugin", { "boundary", "fix" })
    elseif action == "disable-auto-fix" then
      if not st.enabled_auto_fix then
        return
      end
      ---@diagnostic disable-next-line: undefined-global
      ps.unsub("cd")
      st.enabled_auto_fix = false
      ---@diagnostic disable-next-line: undefined-global
      ya.mgr_emit("plugin", { "boundary", "fix" })
    end
  end,

  ---@diagnostic disable-next-line: unused-local
  setup = function(st, opts)
    opts = opts or {}
    opts.root = opts.root or os.getenv("YAZI_ROOT_DIR")

    if opts.root ~= nil and opts.root ~= "" then
      ---@diagnostic disable-next-line: undefined-global
      ya.mgr_emit("plugin", { "boundary", "set-root" .. " " .. tostring(opts.root) })
    end

    ---@diagnostic disable-next-line: undefined-global
    ya.mgr_emit("plugin", { "boundary", "enable-auto-fix" })
  end,
}
