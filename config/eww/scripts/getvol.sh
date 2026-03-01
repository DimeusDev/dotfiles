#!/usr/bin/env bash
# Volume listener for eww

update_vol() {
    local raw vol muted
    raw=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)
    vol=$(echo "$raw" | awk '{printf "%.0f", $2 * 100}')
    muted=$(echo "$raw" | grep -c MUTED)
    if [ "$muted" -eq 1 ]; then
        eww update volico="󰖁"
        eww update get_vol="0"
    else
        eww update volico="󰕾"
        eww update get_vol="$vol"
    fi
}

# initial read
update_vol

# listen for sink changes
pactl subscribe | stdbuf -oL grep --line-buffered "Event 'change' on sink" | while read -r _; do
    update_vol
done
