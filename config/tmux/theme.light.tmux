# Based on Gruvbox Light theme.

set -g pane-border-style 'fg=#ebdbb2'
set -g pane-active-border-style 'fg=#D2C6A1'

set -g window-status-style 'fg=#c5c0ac,bg=#c6ba97,dim'
set -g window-status-format '#[#{window-status-style}] #I #[fg=#aba186,bg=#c6ba97,bright]#W '

set -g window-status-current-style 'fg=#dcd9cc,bg=#51483d,bright'
set -g window-status-current-format '#[#{window-status-current-style}] #I #W '

set -g status-style 'bg=#c6ba97,fg=#4D4742'

set -g message-style 'bg=#39382e,fg=#f5f4f0'

set -g clock-mode-colour '#82b96f'

set -g @prefix_highlight_bg '#427B58'
set -g @prefix_highlight_fg '#f1f8f3'
set -g @prefix_highlight_copy_mode_attr 'fg=#fcfaea,bg=#d79c1b'
set -g @prefix_highlight_sync_mode_attr 'fg=#fff0f1,bg=#920a0f'
