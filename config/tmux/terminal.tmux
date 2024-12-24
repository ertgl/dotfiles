set -g default-terminal "tmux-256color"

set -as terminal-features ",alacritty*:256:RGB:clipboard:ccolour:cstyle:extkeys:focus:hyperlinks:margins:mouse:osc7:overline:rectfill:sixel:strikethrough:sync:title:usstyle"

set -ag terminal-overrides ",${TERM}:AX:Bidi:Eneks:Hls:Ms:Rect:Smol:RGB:Sxl:Sync:Tc:XT"

set -g focus-events on
