function alacritty_reload_theme -a color_scheme
    set -lu alacritty_theme_config_file_path (realpath ~/.config/alacritty/theme.toml)
    set -lu alacritty_theme_file_path ""
    set -lu old_string ""
    set -lu new_string ""

    if test -z "$color_scheme"
        set color_scheme $PREFERS_COLOR_SCHEME
    end

    if test -z "$color_scheme"
        set color_scheme (defaults_read_apple_interface_style)
    end

    if test -z "$color_scheme"
        return 1
    end

    if test "$color_scheme" = light
        set alacritty_theme_file_path ~/.config/alacritty/themes/light.toml
        set old_string dark
        set new_string light
    else
        set alacritty_theme_file_path ~/.config/alacritty/themes/dark.toml
        set old_string light
        set new_string dark
    end

    if ! test -f $alacritty_theme_file_path
        echo "Alacritty theme file not found: $alacritty_theme_file_path"
        return 1
    end

    sed -i "" -e "s/$old_string/$new_string/g" $alacritty_theme_config_file_path

    #alacritty msg config "$(cat $alacritty_theme_file_path)"
    #alacritty msg config "$(cat $alacritty_theme_config_file_path)"
end
