function theme_reload -a color_scheme
    if test -z "$color_scheme"
        set color_scheme (defaults_read_apple_interface_style)
    end

    if test -z "$color_scheme"
        return 1
    end

    # @fish-lsp-disable-next-line 2003
    set -e -Ug PREFERS_COLOR_SCHEME

    # @fish-lsp-disable-next-line 2003
    set -Ux PREFERS_COLOR_SCHEME $color_scheme
end
