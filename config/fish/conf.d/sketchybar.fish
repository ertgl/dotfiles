function on_setenv_prefers_color_scheme_reload_sketchybar_theme --on-event theme_reload_phase_1
    if test -z "$PREFERS_COLOR_SCHEME"
        return 0
    end

    sketchybar_reload_theme $PREFERS_COLOR_SCHEME
end
