#!/usr/bin/env bash
# waybar power profile status - supports PPD and TLP, outputs JSON

if command -v powerprofilesctl >/dev/null 2>&1 && \
   systemctl is-active --quiet power-profiles-daemon 2>/dev/null; then
    profile=$(powerprofilesctl get 2>/dev/null || echo "balanced")
    case "$profile" in
        performance) icon=""; css="performance"; tip="Performance" ;;
        balanced)    icon=""; css="balanced";    tip="Balanced" ;;
        power-saver) icon=""; css="power-saver"; tip="Power Saver" ;;
        *)           icon=""; css="unknown";     tip="$profile" ;;
    esac
    printf '{"text":"%s","tooltip":"PPD: %s","class":"%s"}\n' "$icon" "$tip" "$css"

elif command -v tlp >/dev/null 2>&1; then
    ac_online=$(cat /sys/class/power_supply/AC*/online 2>/dev/null | head -1)
    if [[ "$ac_online" == "1" ]]; then
        printf '{"text":"󰌪","tooltip":"TLP: AC (Performance)","class":"performance"}\n'
    else
        printf '{"text":"󰁿","tooltip":"TLP: Battery (Power Save)","class":"power-saver"}\n'
    fi

else
    printf '{"text":"","tooltip":"No power manager detected","class":"none"}\n'
fi
