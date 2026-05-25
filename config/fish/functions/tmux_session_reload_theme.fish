function tmux_session_reload_theme -a tmux_session -a color_scheme
    if test -z "$tmux_session"
        return 1
    end

    set color_scheme (normalize_prefers_color_scheme "$color_scheme")

    if test -z "$color_scheme"
        return 1
    end

    tmux set-option -g -t $tmux_session @prefers-color-scheme $color_scheme
    tmux set-option -gw -t $tmux_session @prefers-color-scheme $color_scheme
    tmux setenv -t $tmux_session PREFERS_COLOR_SCHEME $color_scheme
    PREFERS_COLOR_SCHEME=$color_scheme tmux source-file -t $tmux_session ~/.config/tmux/tmux.conf
end
