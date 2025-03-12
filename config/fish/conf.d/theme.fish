if status is-interactive && test -z "$PREFERS_COLOR_SCHEME"
    setenv_prefers_color_scheme
end

function on_setenv_prefers_color_scheme_reload_theme --on-variable PREFERS_COLOR_SCHEME
    if test -z "$PREFERS_COLOR_SCHEME"
        return 0
    end

    emit theme_reload_phase_1 $PREFERS_COLOR_SCHEME
    emit theme_reload_phase_2 $PREFERS_COLOR_SCHEME
    emit theme_reload_phase_3 $PREFERS_COLOR_SCHEME
    emit theme_reload_phase_4 $PREFERS_COLOR_SCHEME
end
