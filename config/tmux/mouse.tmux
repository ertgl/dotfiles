set -g mouse on

unbind-key -T copy-mode MouseDragEnd1Pane
unbind-key -T copy-mode-vi MouseDragEnd1Pane
bind-key -T copy-mode MouseDown1Pane select-pane\; send-keys -X clear-selection
bind-key -T copy-mode-vi MouseDown1Pane select-pane\; send-keys -X clear-selection

unbind-key -T root DoubleClick1Pane
unbind-key -T copy-mode DoubleClick1Pane
unbind-key -T copy-mode-vi DoubleClick1Pane
bind-key -T root DoubleClick1Pane copy-mode \; send-keys -X select-word
bind-key -T copy-mode DoubleClick1Pane send-keys -X select-word
bind-key -T copy-mode-vi DoubleClick1Pane send-keys -X select-word

unbind-key -T root TripleClick1Pane
unbind-key -T copy-mode TripleClick1Pane
unbind-key -T copy-mode-vi TripleClick1Pane
bind-key -T root TripleClick1Pane copy-mode \; send-keys -X select-line
bind-key -T copy-mode TripleClick1Pane send-keys -X select-line
bind-key -T copy-mode-vi TripleClick1Pane send-keys -X select-line
