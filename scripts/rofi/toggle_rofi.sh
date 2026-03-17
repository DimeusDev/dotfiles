#!/usr/bin/env bash
# toggle rofi menus , prevents stacking, closes on repeat press

if [ "$#" -lt 1 ]; then
    exit 1
fi

if pgrep -x rofi > /dev/null; then
    # exclude self ($$) then check if THIS menu is already open
    if pgrep -af "toggle_rofi" | grep -v "^$$ " | grep -qF "$(basename "$1")"; then
        pkill -x rofi
    else
        pkill -x rofi
        "$@"
    fi
else
    "$@"
fi
