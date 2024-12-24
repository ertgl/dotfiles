function bat_reload_theme -a color_scheme
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

    # @fish-lsp-disable-next-line 2003
    set -e -Ug BAT_THEME

    # @fish-lsp-disable-next-line 2003
    set -Ux BAT_THEME $bat_theme
end
