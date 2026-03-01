#!/usr/bin/env bash
# set performance mode from waybar context menu

CONF="$HOME/.config/hypr/source/power-mode.conf"
mode="${1:-normal}"

case "$mode" in
    performance)
        cat > "$CONF" << 'EOF'
# Performance mode - all effects disabled
decoration {
    active_opacity   = 1.0
    inactive_opacity = 1.0
    dim_inactive     = false
    shadow {
        enabled = false
    }
    blur {
        enabled = false
    }
}
animations {
    enabled = false
}
EOF
        hyprctl keyword decoration:blur:enabled false
        hyprctl keyword decoration:shadow:enabled false
        hyprctl keyword animations:enabled false
        hyprctl keyword decoration:inactive_opacity 1.0
        hyprctl keyword decoration:dim_inactive false
        notify-send -u low -t 2000 "Power Mode" "Performance - effects off"
        ;;
    normal)
        printf '# Normal mode - appearance.conf settings active\n' > "$CONF"
        hyprctl reload
        notify-send -u low -t 2000 "Power Mode" "Normal - settings restored"
        ;;
esac
