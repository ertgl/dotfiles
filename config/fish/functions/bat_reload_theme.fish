function bat_reload_theme -a color_scheme
    set -lu bat_theme (bat_get_theme_by_color_scheme $color_scheme)

    if test -z "$bat_theme"
        return 1
    end

    set -e --no-event BAT_THEME

    # @fish-lsp-disable-next-line 2003
    set -Ux --no-event BAT_THEME $bat_theme

    # @fish-lsp-disable-next-line 2003
    set -gx BAT_THEME $bat_theme
end
