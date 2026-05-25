function setenv_prefers_color_scheme -a color_scheme
    set color_scheme (normalize_prefers_color_scheme "$color_scheme")

    if test -z "$color_scheme"
        echo "Usage: setenv_prefers_color_scheme [dark|light]"
        return 1
    end

    set -gx PREFERS_COLOR_SCHEME $color_scheme

    # @fish-lsp-disable-next-line 2003
    set -Ux LAST_COLOR_SCHEME $color_scheme &>/dev/null
end
