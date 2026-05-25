set -g extended-keys on
set -g extended-keys-format csi-u

set -g xterm-keys on

set -g escape-time 0

set -g mode-keys vi

set -g status-keys vi

unbind-key C-b
set -g prefix C-a
bind-key C-a send-prefix

bind-key : command-prompt
bind-key ? list-keys

bind-key r {
    display-message "reloading configuration...";
    source-file ~/.config/tmux/tmux.conf;
    display-message "reloading configuration... done.";
}

bind-key C-x kill-pane
