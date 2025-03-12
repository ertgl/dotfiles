function fish_user_key_bindings
    # alacritty
    bind \e\[1\;9D beginning-of-line
    bind \e\[1\;9H beginning-of-line
    bind \e\[1\;10D beginning-of-line
    bind \e\[1\;9C end-of-line
    bind \e\[1\;9F end-of-line
    bind \e\[1\;10C end-of-line
    bind \e\[1\;3D backward-word
    bind \e\[1\;3C forward-word
    bind \e\[1\;\x7F cancel
    bind \e\[3\;9~ kill-line
    bind \cBf728 kill-bigword

    # tmux
    bind --preset home beginning-of-line
    bind \e\[1~ beginning-of-line
    bind \e\[1\;3H beginning-of-line
    bind --preset end end-of-line
    bind \e\[4~ end-of-line
    bind \e\[1\;3F end-of-line
    bind \e\[3\;3~ kill-line
end
