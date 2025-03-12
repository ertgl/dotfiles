--- @sync entry

return {
  ---@diagnostic disable-next-line: unused-local
  entry = function(st, job)
    local action = job.args[1]
    local should_resize = false

    if action == "toggle-parent" then
      ---@diagnostic disable-next-line: undefined-global
      local is_parent_visible = ((st.parent == rt.mgr.ratio.parent and 0) or rt.mgr.ratio.parent) > 0
      if is_parent_visible then
        action = "show-parent"
      else
        action = "hide-parent"
      end
    end

    if action == "hide-parent" then
      st.parent = 0
      st.old_current = st.current
      st.current = 7
      st.old_preview = st.preview
      st.preview = 4
      should_resize = true
    elseif action == "show-parent" then
      st.parent = rt.mgr.ratio.parent
      ---@diagnostic disable-next-line: undefined-global
      st.current = st.old_current or rt.mgr.ratio.current
      st.old_current = nil
      ---@diagnostic disable-next-line: undefined-global
      st.preview = st.old_preview or rt.mgr.ratio.preview
      st.old_preview = nil
      should_resize = true
    elseif action == "reset" then
      ---@diagnostic disable-next-line: undefined-global
      Tab.layout = st.old_tab_layout
      st.old_tab_layout = nil
      st.parent = nil
      st.current = nil
      st.preview = nil
      should_resize = true
    end

    if not st.old_tab_layout then
      ---@diagnostic disable-next-line: undefined-global
      st.old_tab_layout = Tab.layout
      ---@diagnostic disable-next-line: undefined-global
      Tab.layout = function(self)
        local all = st.parent + st.current + st.preview
        ---@diagnostic disable-next-line: undefined-global
        self._chunks = ui
          .Layout()
          ---@diagnostic disable-next-line: undefined-global
          :direction(ui.Layout.HORIZONTAL)
          :constraints({
            ---@diagnostic disable-next-line: undefined-global
            ui.Constraint.Ratio(st.parent, all),
            ---@diagnostic disable-next-line: undefined-global
            ui.Constraint.Ratio(st.current, all),
            ---@diagnostic disable-next-line: undefined-global
            ui.Constraint.Ratio(st.preview, all),
          })
          :split(self._area)
      end
    end

    if should_resize then
      ---@diagnostic disable-next-line: undefined-global
      ya.emit("resize", {})
    end
  end,
}
