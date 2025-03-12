function on_setenv_prefers_color_scheme_reload_tmux_theme --on-event theme_reload_phase_2
    if test -z "$PREFERS_COLOR_SCHEME"
        return 0
    end

    tmux_reload_theme $PREFERS_COLOR_SCHEME
end
