#!/usr/bin/env bash
# caffeine - inhibit idle by stopping hypridle

STATE_FILE="/tmp/hypr_caffeine"

status() {
    if [ -f "$STATE_FILE" ]; then
        printf '{"text":"󰅶","tooltip":"Caffeine: on","class":"active"}\n'
    else
        printf '{"text":"󱫗","tooltip":"Caffeine: off","class":""}\n'
    fi
}

toggle() {
    if [ -f "$STATE_FILE" ]; then
        rm "$STATE_FILE"
        systemctl --user start hypridle 2>/dev/null || (hypridle &>/dev/null & disown)
        notify-send -u low -t 2000 "Caffeine" "disabled"
    else
        touch "$STATE_FILE"
        systemctl --user stop hypridle 2>/dev/null || pkill -x hypridle 2>/dev/null || true
        notify-send -u low -t 2000 "Caffeine" "enabled"
    fi
    pkill -RTMIN+9 waybar 2>/dev/null || true
}

case "${1:-toggle}" in
    status) status ;;
    *)      toggle ;;
esac
