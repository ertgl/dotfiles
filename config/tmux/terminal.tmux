set -g default-terminal "tmux-256color"

# set -as terminal-features ",alacritty*:256:clipboard:ccolour:cstyle:extkeys:focus:hyperlinks:margins:mouse:osc7:overline:rectfill:RGB:sixel:strikethrough:sync:title:usstyle"
set -as terminal-features ",alacritty*:256:clipboard:ccolour:cstyle:extkeys:hyperlinks:margins:mouse:overline:rectfill:RGB:strikethrough:title:usstyle"

# set -ag terminal-overrides ",${TERM}:AX:Bidi:Ms:Rect:RGB:Smol:Sxl:Sync:Tc:XT"
set -ag terminal-overrides ",${TERM}:AX:Bidi:Rect:RGB:Tc:XT"

set -g focus-events on
