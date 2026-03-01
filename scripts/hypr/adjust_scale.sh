#!/usr/bin/env bash
# adjust primary monitor scale by +/-0.25
# usage: adjust_scale.sh + / -

STEP=0.25
MONITOR=$(hyprctl monitors -j | jq -r '.[0].name')
CURRENT=$(hyprctl monitors -j | jq '.[0].scale')

if [[ "$1" == "+" ]]; then
    NEW=$(echo "scale=2; $CURRENT + $STEP" | bc)
else
    NEW=$(echo "scale=2; $CURRENT - $STEP" | bc)
fi

hyprctl keyword monitor "$MONITOR,preferred,auto,$NEW"
notify-send -u low -t 2000 "Display Scale" "$CURRENT → $NEW"
