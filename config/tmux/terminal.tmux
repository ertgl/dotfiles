set -g default-terminal "tmux-256color"

set -as terminal-features ",alacritty*:RGB"

set -ag terminal-overrides ",${TERM}:AX:Bidi:Ms:Rect:RGB:Tc:XT"

set -g focus-events on
