set -g mouse on

bind-key -T copy-mode WheelUpPane select-pane\; send-keys -X -N 1 scroll-up
bind-key -T copy-mode WheelDownPane select-pane\; send-keys -X -N 1 scroll-down

bind-key -T root DoubleClick1Pane if-shell -Ft'{mouse}' '#{alternate_on}' "send-keys -M" "copy-mode -t'{mouse}'; send-keys -t'{mouse}' -X select-word"
bind-key -T copy-mode DoubleClick1Pane if-shell -Ft'{mouse}' '#{alternate_on}' "send-keys -M" "copy-mode -t'{mouse}'; send-keys -t'{mouse}' -X select-word"
bind-key -T copy-mode-vi DoubleClick1Pane if-shell -Ft'{mouse}' '#{alternate_on}' "send-keys -M" "copy-mode -t'{mouse}'; send-keys -t'{mouse}' -X select-word"

bind-key -T root TripleClick1Pane if-shell -Ft'{mouse}' '#{alternate_on}' "send-keys -M" "copy-mode -t'{mouse}'; send-keys -t'{mouse}' -X select-line"
bind-key -T copy-mode TripleClick1Pane if-shell -Ft'{mouse}' '#{alternate_on}' "send-keys -M" "copy-mode -t'{mouse}'; send-keys -t'{mouse}' -X select-line"
bind-key -T copy-mode-vi TripleClick1Pane if-shell -Ft'{mouse}' '#{alternate_on}' "send-keys -M" "copy-mode -t'{mouse}'; send-keys -t'{mouse}' -X select-line"

bind-key -T copy-mode MouseDrag1Pane select-pane\; send-keys -t'{mouse}' -X begin-selection

unbind-key -T copy-mode-vi MouseDragEnd1Pane
bind-key -T copy-mode MouseDragEnd1Pane send-keys -t'{mouse}' -X stop-selection

bind-key -T copy-mode MouseDown1Pane select-pane\; send-keys -t'{mouse}' -X clear-selection
