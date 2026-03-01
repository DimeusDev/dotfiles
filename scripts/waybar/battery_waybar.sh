#!/usr/bin/env bash
# waybar custom battery module with power profile in tooltip

BAT_PATH=$(ls -d /sys/class/power_supply/BAT* 2>/dev/null | head -1)
if [[ -z "$BAT_PATH" ]]; then
    printf '{"text":"","tooltip":"No battery","percentage":0,"class":"none"}\n'
    exit 0
fi

capacity=$(cat "$BAT_PATH/capacity" 2>/dev/null || echo 0)
status=$(cat "$BAT_PATH/status" 2>/dev/null || echo "Unknown")

icons=("󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")
icon_idx=$(( capacity / 10 ))
[[ $icon_idx -gt 10 ]] && icon_idx=10
icon="${icons[$icon_idx]}"

case "$status" in
    Charging)    text=" ${capacity}%" ;;
    Full)        text="󱘖" ;;
    *)           text="${icon} ${capacity}%" ;;
esac

# power profile
if command -v powerprofilesctl >/dev/null 2>&1 && \
   systemctl is-active --quiet power-profiles-daemon 2>/dev/null; then
    profile=$(powerprofilesctl get 2>/dev/null || echo "balanced")
    case "$profile" in
        performance) pw_name="Performance" ;;
        balanced)    pw_name="Balanced" ;;
        power-saver) pw_name="Power Saver" ;;
        *)           pw_name="$profile" ;;
    esac
elif command -v tlp >/dev/null 2>&1; then
    ac=$(cat /sys/class/power_supply/AC*/online 2>/dev/null | head -1)
    if [[ "$ac" == "1" ]]; then
        pw_name="AC (Performance)"
    else
        pw_name="Battery (Power Save)"
    fi
else
    pw_name="No power manager"
fi

# time remaining via upower
time_str=""
if command -v upower >/dev/null 2>&1; then
    udev_path=$(upower -e 2>/dev/null | grep -i 'BAT' | head -1)
    if [[ -n "$udev_path" ]]; then
        upower_out=$(upower -i "$udev_path" 2>/dev/null)
        t_empty=$(echo "$upower_out" | awk '/time to empty/{print $4, $5}')
        t_full=$(echo "$upower_out" | awk '/time to full/{print $4, $5}')
        if [[ -n "$t_empty" ]]; then
            time_str=" - ${t_empty} remaining"
        elif [[ -n "$t_full" ]]; then
            time_str=" - ${t_full} to full"
        fi
    fi
fi

# css class
if [[ "$status" == "Charging" || "$status" == "Full" ]]; then
    css="charging"
elif (( capacity <= 15 )); then
    css="critical"
elif (( capacity <= 30 )); then
    css="warning"
else
    css="good"
fi

tooltip="Profile: ${pw_name}\\n${status}${time_str}"

printf '{"text":"%s","tooltip":"%s","percentage":%d,"class":"%s"}\n' \
    "$text" "$tooltip" "$capacity" "$css"
