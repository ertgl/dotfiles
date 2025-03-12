function bat_get_theme_by_color_scheme -a color_scheme
    if test -z "$color_scheme"
        set color_scheme $PREFERS_COLOR_SCHEME
    end

    if test -z "$color_scheme"
        set color_scheme (defaults_read_apple_interface_style)
    end

    if test -z "$color_scheme"
        return 1
    end

    set -lu bat_theme ""

    if test "$color_scheme" = light
        set bat_theme $BAT_THEME_LIGHT
    else
        set bat_theme $BAT_THEME_DARK
    end

    echo $bat_theme
end
