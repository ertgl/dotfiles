function setenv_prefers_color_scheme -a color_scheme
    if test -z "$color_scheme"
        if test -z "$DARKMODE"
            set color_scheme (defaults_read_apple_interface_style)
        else
            if test $DARKMODE -eq 1
                set color_scheme dark
            else
                set color_scheme light
            end
        end
    end

    if test -z "$color_scheme"
        echo "Usage: setenv_prefers_color_scheme [dark|light]"
        return 1
    end

    set -e --no-event PREFERS_COLOR_SCHEME

    # @fish-lsp-disable-next-line 2003
    set -Ux --no-event PREFERS_COLOR_SCHEME $color_scheme

    # @fish-lsp-disable-next-line 2003
    set -gx PREFERS_COLOR_SCHEME $color_scheme

    return 0
end
