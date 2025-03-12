%if #{TMUX}
set -g status-bg red
%endif

set -g status-interval 1

set -g status-position bottom
set -g status-justify left

set -g status-left ""
set -g status-left-length 0

set -g status-right '#{prefix_highlight} #{pane_title} '
set -g status-right-length 200
