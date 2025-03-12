function defaults_read_apple_interface_style
    set -lu color_scheme light

    defaults read -g AppleInterfaceStyle 2>/dev/null 1>/dev/null

    if test $status -eq 0
        set color_scheme dark
    end

    echo $color_scheme

    return 0
end
