# Based on Gruvbox Light theme.

set -g pane-border-style 'fg=#ebdbb2'
set -g pane-active-border-style 'fg=#D2C6A1'

set -g window-status-style 'fg=gray,bg=#D3C7A3,dim'
# set -g window-status-format '#[#{window-status-style}] #I #[fg=white,dim]#W #[fg=gray]#F '
set -g window-status-format '#[#{window-status-style}] #I #[fg=white,dim]#W '

set -g window-status-current-style 'fg=#D2C5A2,bg=#243134'
# set -g window-status-current-format '#[#{window-status-current-style}] #I #W #[fg=white,bright]#F '
set -g window-status-current-format '#[#{window-status-current-style}] #I #W '

set -g status-style 'bg=#D3C7A3,fg=#45403E'
# set -g status-left-style 'bg=#D3C7A3'
# set -g status-right-style 'bg=#D3C7A3'

set -g message-style 'bg=#D79920,fg=#FAF5D7'

set -g clock-mode-colour '#D79920'

set -g @prefix_highlight_fg '#ebdbb2'
set -g @prefix_highlight_bg '#056678'
set -g @prefix_highlight_copy_mode_attr 'fg=black,bg=yellow'
set -g @prefix_highlight_sync_mode_attr 'fg=black,bg=green'

