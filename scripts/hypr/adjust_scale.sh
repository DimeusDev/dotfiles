#!/usr/bin/env bash
# cycle primary monitor scale 
# usage: adjust_scale.sh + / -

readonly -a STEPS=(0.80 1.00 1.25 1.60)

read -r MONITOR WIDTH HEIGHT RATE POS_X POS_Y CURRENT < <(
    hyprctl monitors -j | jq -r '.[0] | "\(.name) \(.width) \(.height) \(.refreshRate) \(.x) \(.y) \(.scale)"'
)

# find current index (2 decimals)
idx=-1
for i in "${!STEPS[@]}"; do
    if awk -v a="${STEPS[$i]}" -v b="$CURRENT" 'BEGIN { exit !(int(a*100) == int(b*100)) }'; then
        idx=$i
        break
    fi
done

# if current scale not in list use nearest
if (( idx == -1 )); then
    idx=$(awk -v c="$CURRENT" 'BEGIN {
        split("0.75 1.00 1.25 1.50", s)
        best=0; d=999
        for (i=1; i<=4; i++) { diff=(s[i]-c < 0 ? c-s[i] : s[i]-c); if (diff < d) { d=diff; best=i-1 } }
        print best
    }')
fi

n=${#STEPS[@]}
if [[ "$1" == "+" ]]; then
    new_idx=$(( idx + 1 < n ? idx + 1 : idx ))
else
    new_idx=$(( idx - 1 >= 0 ? idx - 1 : idx ))
fi

NEW="${STEPS[$new_idx]}"

if [[ "$new_idx" == "$idx" ]]; then
    notify-send -u low -t 2000 "Display Scale" "already at limit (${CURRENT})"
    exit 0
fi

hyprctl keyword monitor "$MONITOR,${WIDTH}x${HEIGHT}@${RATE},${POS_X}x${POS_Y},$NEW"
notify-send -u low -t 2000 "Display Scale" "$CURRENT → $NEW"
