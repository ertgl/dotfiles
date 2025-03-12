function sketchybar_reload_theme -a color_scheme
    if test -z "$color_scheme"
        set color_scheme $PREFERS_COLOR_SCHEME
    end

    if test -z "$color_scheme"
        set color_scheme (defaults_read_apple_interface_style)
    end

    if test -z "$color_scheme"
        return 1
    end

    env PREFERS_COLOR_SCHEME=$color_scheme bash $XDG_CONFIG_HOME/sketchybar/scripts/reload_theme.sh
end
