#!/usr/bin/env bash
# toggle caffeine (idle inhibitor) by killing/restarting hypridle

STATE_FILE="/tmp/hypr_caffeine"

if [ -f "$STATE_FILE" ]; then
    rm "$STATE_FILE"
    hypridle &>/dev/null &
    disown
    notify-send -u low -t 2000 "Caffeine" "disabled"
else
    touch "$STATE_FILE"
    pkill -x hypridle 2>/dev/null || true
    notify-send -u low -t 2000 "Caffeine" "enabled"
fi

pkill -RTMIN+9 waybar 2>/dev/null || true
