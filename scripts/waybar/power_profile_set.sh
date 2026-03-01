#!/usr/bin/env bash
# set a specific PPD power profile by name
profile="${1:-balanced}"
powerprofilesctl set "$profile" 2>/dev/null || exit 0
notify-send -u low -t 2000 "Power Profile" "$profile"
