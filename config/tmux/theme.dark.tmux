# Based on Gruvbox Dark theme.

set -g pane-border-style 'fg=#3c3836'
set -g pane-active-border-style 'fg=#7A866C'

set -g window-status-style 'fg=#CBBF9B,bg=#4D4742,dim'
# set -g window-status-format '#[#{window-status-style}] #I #[fg=white,bright]#W #[fg=gray]#F '
set -g window-status-format '#[#{window-status-style}] #I #[fg=white,bright]#W '

set -g window-status-current-style 'fg=#1C2122,bg=#CBBF9B,bright'
# set -g window-status-current-format '#[#{window-status-current-style}] #I #W #[fg=black]#F '
set -g window-status-current-format '#[#{window-status-current-style}] #I #W '

set -g status-style 'bg=#4D4742,fg=#CBBF9B'
# set -g status-left-style 'bg=#4D4742'
# set -g status-right-style 'bg=#4D4742'

set -g message-style 'bg=#E2C08E,fg=#1d2021'

set -g clock-mode-colour '#d79921'

set -g @prefix_highlight_fg '#ebdbb2'
set -g @prefix_highlight_bg '#056678'
set -g @prefix_highlight_copy_mode_attr 'fg=black,bg=yellow'
set -g @prefix_highlight_sync_mode_attr 'fg=black,bg=green'
