#!/usr/bin/env bash
# volume listener for eww

update_vol() {
    local raw vol volico
    raw=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)
    [[ -z "$raw" ]] && return
    read -r vol volico < <(awk '{
        muted = ($0 ~ /MUTED/)
        print (muted ? 0 : int($2 * 100)), (muted ? "󰖁" : "󰕾")
    }' <<< "$raw")
    eww update volico="$volico" get_vol="$vol"
}

update_vol

pactl subscribe | grep --line-buffered "Event 'change' on sink" | while read -r _; do
    update_vol
done
