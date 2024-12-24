set -g default-terminal "tmux-256color"

set -as terminal-features ",xterm*,alacritty*:256:clipboard:ccolour:cstyle:extkeys:focus:hyperlinks:margins:mouse:osc7:overline:rectfill:RGB:sixel:strikethrough:sync:title:usstyle"

set -ag terminal-overrides ",${TERM}:AX:Bidi:Eneks:Hls:Ms:Rect:RGB:rmcup@:smcup@:Smol:Sxl:Sync:Tc:XT"

set -g focus-events on
