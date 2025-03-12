function nvim_reload_theme -a color_scheme
    if test -z "$color_scheme"
        set color_scheme $PREFERS_COLOR_SCHEME
    end

    if test -z "$color_scheme"
        set color_scheme (defaults_read_apple_interface_style)
    end

    if test -z "$color_scheme"
        return 1
    end

    for nvim_server_addr in (nvr --nostart -s --serverlist)
        nvr --nostart -s --servername "$nvim_server_addr" -c ":set background=$color_scheme" 2>/dev/null &
    end
    wait
end
