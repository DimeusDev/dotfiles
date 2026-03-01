#!/usr/bin/env bash
# Set a tlp profile from name

STATE_FILE="/tmp/tlp_profile_mode"
profile="${1:-balanced}"

echo "$profile" > "$STATE_FILE"

case "$profile" in
    performance)
        sudo tlp ac >/dev/null 2>&1
        notify-send -u low -t 2000 "TLP" "Performance - forced AC mode"
        ;;
    balanced)
        sudo tlp start >/dev/null 2>&1
        notify-send -u low -t 2000 "TLP" "Auto - follows power source"
        ;;
    power-saver)
        sudo tlp bat >/dev/null 2>&1
        notify-send -u low -t 2000 "TLP" "Power Saver - forced battery mode"
        ;;
esac
