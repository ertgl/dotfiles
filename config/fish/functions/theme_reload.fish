function theme_reload -a color_scheme
    if test -z "$color_scheme"
        set color_scheme (defaults_read_apple_interface_style)
    end

    if test -z "$color_scheme"
        return 1
    end

    setenv_prefers_color_scheme $color_scheme
end
