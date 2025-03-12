set -g xterm-keys on
set -s extended-keys off

set -g mode-keys vi
set -g status-keys vi

set -g prefix C-a

unbind C-b
bind C-a send-prefix

set -g escape-time 0

bind-key r {
    display-message "reloading configuration...";
    source-file ~/.config/tmux/tmux.conf;
    display-message "reloading configuration... done.";
}

bind-key ? list-keys
bind-key : command-prompt

# deprecated:
bind-key C-t new-window -c "#{pane_current_path}"
# by:
bind-key c new-window -c "#{pane_current_path}"

# deprecated:
bind-key C-w kill-window

unbind C-s
bind-key C-s split-window -c "#{pane_current_path}"
bind-key C-d split-window -h -c "#{pane_current_path}"
bind-key C-x kill-pane

bind Tab last-window
bind \` switch-client -t'{marked}'

bind -T copy-mode Home send-keys -X history-top
bind -T copy-mode End copy-mode -q

