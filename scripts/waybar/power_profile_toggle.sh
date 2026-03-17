#!/usr/bin/env bash
# waybar power profile toggle - cycles PPD profiles

current=$(powerprofilesctl get 2>/dev/null || echo "balanced")
case "$current" in
    performance) next="balanced" ;;
    balanced)    next="power-saver" ;;
    *)           next="performance" ;;
esac
powerprofilesctl set "$next"
notify-send -u low -t 2000 "Power Profile" "Switched to: $next" 2>/dev/null || true
