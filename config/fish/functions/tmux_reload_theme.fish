function tmux_reload_theme -a color_scheme
    if test -z "$color_scheme"
        set color_scheme $PREFERS_COLOR_SCHEME
    end

    if test -z "$color_scheme"
        set color_scheme (defaults_read_apple_interface_style)
    end

    if test -z "$color_scheme"
        return 1
    end

    set -lu tmux_sessions (tmux ls -F "#{session_name}" 2>&1)
    set -lu tmux_ls_status $status

    if not test $tmux_ls_status -eq 0
        return 1
    end

    tmux setenv PREFERS_COLOR_SCHEME $color_scheme
    tmux source-file ~/.config/tmux/tmux.conf

    for tmux_session in $tmux_sessions
        tmux_session_reload_theme $tmux_session $color_scheme &
    end
    wait
end

function tmux_session_reload_theme -a tmux_session -a color_scheme
    if test -z "$tmux_session"
        return 1
    end

    if test -z "$color_scheme"
        set color_scheme $PREFERS_COLOR_SCHEME
    end

    if test -z "$color_scheme"
        set color_scheme (defaults_read_apple_interface_style)
    end

    if test -z "$color_scheme"
        return 1
    end

    tmux setenv -t $tmux_session PREFERS_COLOR_SCHEME $color_scheme
    tmux source-file -t $tmux_session ~/.config/tmux/tmux.conf
end
