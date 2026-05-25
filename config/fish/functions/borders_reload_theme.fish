function borders_reload_theme -a color_scheme
    set color_scheme (normalize_prefers_color_scheme "$color_scheme")

    if test -z "$color_scheme"
        return 1
    end

    env PREFERS_COLOR_SCHEME=$color_scheme bash $XDG_CONFIG_HOME/borders/scripts/reload_theme.sh
end
