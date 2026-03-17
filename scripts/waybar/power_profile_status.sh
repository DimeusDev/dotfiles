#!/usr/bin/env bash
# waybar power profile status - outputs PPD profile as JSON

profile=$(powerprofilesctl get 2>/dev/null || echo "balanced")
case "$profile" in
    performance) icon=""; css="performance"; tip="Performance" ;;
    balanced)    icon=""; css="balanced";    tip="Balanced" ;;
    power-saver) icon=""; css="power-saver"; tip="Power Saver" ;;
    *)           icon=""; css="unknown";     tip="$profile" ;;
esac
printf '{"text":"%s","tooltip":"PPD: %s","class":"%s"}\n' "$icon" "$tip" "$css"
