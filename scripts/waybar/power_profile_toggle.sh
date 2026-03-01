#!/usr/bin/env bash
# waybar power profile toggle - cycles PPD or TLP modes

if command -v powerprofilesctl >/dev/null 2>&1 && \
   systemctl is-active --quiet power-profiles-daemon 2>/dev/null; then
    current=$(powerprofilesctl get 2>/dev/null || echo "balanced")
    case "$current" in
        performance) next="balanced" ;;
        balanced)    next="power-saver" ;;
        *)           next="performance" ;;
    esac
    powerprofilesctl set "$next"
    notify-send -u low -t 2000 "Power Profile" "Switched to: $next" 2>/dev/null || true

elif command -v tlp >/dev/null 2>&1; then
    ac_online=$(cat /sys/class/power_supply/AC*/online 2>/dev/null | head -1)
    if [[ "$ac_online" == "1" ]]; then
        tlp bat >/dev/null 2>&1
        notify-send -u low -t 2000 "TLP" "Switched to Battery mode" 2>/dev/null || true
    else
        tlp ac >/dev/null 2>&1
        notify-send -u low -t 2000 "TLP" "Switched to AC mode" 2>/dev/null || true
    fi
fi
