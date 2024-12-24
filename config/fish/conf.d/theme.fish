if status is-interactive && test -z "$PREFERS_COLOR_SCHEME"
    setenv_prefers_color_scheme
end

function on_setenv_prefers_color_scheme --on-variable PREFERS_COLOR_SCHEME
    if test -z "$PREFERS_COLOR_SCHEME"
        return 0
    end

    sketchybar_reload_theme $PREFERS_COLOR_SCHEME &
    borders_reload_theme $PREFERS_COLOR_SCHEME &
    nvim_reload_theme $PREFERS_COLOR_SCHEME &
    tmux_reload_theme $PREFERS_COLOR_SCHEME &
    alacritty_reload_theme $PREFERS_COLOR_SCHEME &
end
