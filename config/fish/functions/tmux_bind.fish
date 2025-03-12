function tmux_bind
    set -lu tmux_ls_output (tmux ls 2>&1)
    set -lu tmux_ls_status $status

    if not test $tmux_ls_status -eq 0
        tmux new-session
    else
        set -lu tmux_ls_attached_output (echo $tmux_ls_output | grep -q 'attached')
        set -lu tmux_ls_attached_status $status

        if test $tmux_ls_attached_status -eq 0
            tmux new-window
        else
            tmux a || tmux
        end
    end
end
