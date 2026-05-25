function tmux_reload_theme -a color_scheme
    set color_scheme (normalize_prefers_color_scheme "$color_scheme")

    if test -z "$color_scheme"
        return 1
    end

    set -lu tmux_sessions (tmux ls -F "#{session_name}" 2>&1)
    set -lu tmux_ls_status $status

    if not test $tmux_ls_status -eq 0
        return 1
    end

    tmux set-option -g @prefers-color-scheme $color_scheme
    tmux set-option -gw @prefers-color-scheme $color_scheme
    tmux setenv PREFERS_COLOR_SCHEME $color_scheme
    PREFERS_COLOR_SCHEME=$color_scheme tmux source-file ~/.config/tmux/tmux.conf

    for tmux_session in $tmux_sessions
        tmux_session_reload_theme $tmux_session $color_scheme &
    end
    wait
end
