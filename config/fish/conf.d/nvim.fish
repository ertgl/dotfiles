function on_setenv_prefers_color_scheme_reload_nvim_theme --on-event theme_reload_phase_3
    if test -z "$PREFERS_COLOR_SCHEME"
        return 0
    end

    nvim_reload_theme $PREFERS_COLOR_SCHEME
end
