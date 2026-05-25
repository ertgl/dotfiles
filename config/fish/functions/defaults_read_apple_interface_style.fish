function defaults_read_apple_interface_style
    set -lu color_scheme light

    defaults read -g AppleInterfaceStyle &>/dev/null

    if test $status -eq 0
        set color_scheme dark
    end

    echo $color_scheme
end
