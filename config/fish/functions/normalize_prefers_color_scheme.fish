function normalize_prefers_color_scheme -a color_scheme
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
        return 1
    end

    echo "$color_scheme"
end
