#!/usr/bin/env bash
# used to toggle rofi menu (so they dont open twice + they close when pressing again)

if [ "$#" -lt 1 ]; then
    exit 1
fi

script_name=$(realpath "$0")
args="$*"

if pgrep -af "$script_name" | grep -qv "$args"; then
    # different menu: kill old and launch the new menu
    pkill -x rofi
    "$@"
elif pgrep -x rofi > /dev/null; then
    # same menu kill
    pkill -x rofi
else
    # nothing: simply launch
    "$@"
fi
