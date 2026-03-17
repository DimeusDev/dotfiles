#!/usr/bin/env bash
# waybar custom battery module with power profile in tooltip

shopt -s nullglob
bat_paths=( /sys/class/power_supply/BAT* )
shopt -u nullglob

if [[ ${#bat_paths[@]} -eq 0 ]]; then
    printf '{"text":"","tooltip":"No battery","percentage":0,"class":"none"}\n'
    exit 0
fi

BAT_PATH="${bat_paths[0]}"
capacity=$(<"$BAT_PATH/capacity")
status=$(<"$BAT_PATH/status")

icons=("󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")
icon_idx=$(( capacity / 10 ))
[[ $icon_idx -gt 10 ]] && icon_idx=10
icon="${icons[$icon_idx]}"

case "$status" in
    Charging) text=" ${capacity}%" ;;
    Full)     text="󱘖" ;;
    *)        text="${icon} ${capacity}%" ;;
esac

# power profile
profile=$(powerprofilesctl get 2>/dev/null) || profile="balanced"
case "$profile" in
    performance) pw_name="Performance" ;;
    balanced)    pw_name="Balanced" ;;
    power-saver) pw_name="Power Saver" ;;
    *)           pw_name="$profile" ;;
esac

# time remaining via sysfs
time_str=""
if [[ "$status" == "Discharging" ]] && [[ -r "$BAT_PATH/time_to_empty_avg" ]]; then
    t_secs=$(<"$BAT_PATH/time_to_empty_avg")
    if (( t_secs > 0 && t_secs < 86400 )); then
        h=$(( t_secs / 3600 ))
        m=$(( (t_secs % 3600) / 60 ))
        (( h > 0 )) && time_str=" - ${h}h ${m}m remaining" || time_str=" - ${m}m remaining"
    fi
elif [[ "$status" == "Charging" ]] && [[ -r "$BAT_PATH/time_to_full_avg" ]]; then
    t_secs=$(<"$BAT_PATH/time_to_full_avg")
    if (( t_secs > 0 && t_secs < 86400 )); then
        h=$(( t_secs / 3600 ))
        m=$(( (t_secs % 3600) / 60 ))
        (( h > 0 )) && time_str=" - ${h}h ${m}m to full" || time_str=" - ${m}m to full"
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
