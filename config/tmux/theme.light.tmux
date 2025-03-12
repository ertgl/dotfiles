# Based on Gruvbox Light theme.

set -g pane-border-style 'fg=#ebdbb2'
set -g pane-active-border-style 'fg=#D2C6A1'

set -g window-status-style 'fg=#b79d68,bg=#D5C6A3,dim'
set -g window-status-format '#[#{window-status-style}] #I #[fg=#4e4845,dim]#W '

set -g window-status-current-style 'fg=#f4f3f2,bg=#53493b,bright'
set -g window-status-current-format '#[#{window-status-current-style}] #I #W '

set -g status-style 'bg=#D4C9A6,fg=#45403E'

set -g message-style 'bg=#2a2320,fg=#f8f7f4'

set -g clock-mode-colour '#82b96f'

set -g @prefix_highlight_bg '#427B58'
set -g @prefix_highlight_fg '#f1f8f3'
set -g @prefix_highlight_copy_mode_attr 'fg=#fcfaea,bg=#d79c1b'
set -g @prefix_highlight_sync_mode_attr 'fg=#fff0f1,bg=#920a0f'
