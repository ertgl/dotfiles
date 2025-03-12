# Based on Gruvbox Dark theme.

set -g pane-border-style 'fg=#3c3836'
set -g pane-active-border-style 'fg=#7A866C'

set -g window-status-style 'fg=#CBBF9B,bg=#4D4742,dim'
set -g window-status-format '#[#{window-status-style}] #I #[fg=white,bright]#W '

set -g window-status-current-style 'fg=#1C2122,bg=#CBBF9B,bright'
set -g window-status-current-format '#[#{window-status-current-style}] #I #W '

set -g status-style 'bg=#4D4742,fg=#CBBF9B'

set -g message-style 'bg=#C7BC98,fg=#1C2122'

set -g clock-mode-colour '#aed5a0'

set -g @prefix_highlight_bg '#80ba6e'
set -g @prefix_highlight_fg '#13240f'
set -g @prefix_highlight_copy_mode_attr 'fg=#3d1d0b,bg=#e7b328'
set -g @prefix_highlight_sync_mode_attr 'fg=#490d06,bg=#ffa99f'
