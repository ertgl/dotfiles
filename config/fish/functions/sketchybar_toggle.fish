function sketchybar_toggle
    set -lu sketchybar_height (sketchybar --query bar | jq -r '.height' 2>/dev/null)
    set -lu sketchybar_height_is_running true
    set -lu yabai_external_bar_height 0

    if test -z "$sketchybar_height"
        set sketchybar_height 0
        set sketchybar_height_is_running false
    end

    set -lu sketchybar_new_height 0
    if test $sketchybar_height -eq 0
        set sketchybar_new_height 36
    end

    set yabai_external_bar_height (math "max($sketchybar_new_height - 6, 0)")
    yabai -m config external_bar "all:$yabai_external_bar_height:0"

    if test $sketchybar_height_is_running -eq false
        brew services start sketchybar
    else
        sketchybar --bar height="$sketchybar_new_height"
    end
end
