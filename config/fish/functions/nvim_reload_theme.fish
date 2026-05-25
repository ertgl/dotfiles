function nvim_reload_theme -a color_scheme
    set color_scheme (normalize_prefers_color_scheme "$color_scheme")

    if test -z "$color_scheme"
        return 1
    end

    for nvim_server_addr in (nvr --nostart -s --serverlist)
        nvr --nostart -s --servername "$nvim_server_addr" -c ":set background=$color_scheme" 2>/dev/null &
    end
    wait
end
