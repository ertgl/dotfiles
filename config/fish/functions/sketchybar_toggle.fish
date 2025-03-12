function sketchybar_toggle
    set -lu sketchybar_height (sketchybar --query bar | jq -r '.height' 2>/dev/null)
    set -lu sketchybar_height_is_na (test -z $sketchybar_height; echo $status)
    if test -z $sketchybar_height
        set sketchybar_height 0
    end

    set -lu sketchybar_new_height 0
    if test $sketchybar_height -eq 0
        set sketchybar_new_height 32
    end

    if test $sketchybar_height_is_na -eq 0
        brew services start sketchybar
    else
        sketchybar --bar height="$sketchybar_new_height"
    end

    yabai -m config external_bar "all:$sketchybar_new_height:0"
end
