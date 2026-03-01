#!/usr/bin/env bash
# rofi power mode switcher, writes to hypr/source/power-mode.conf

CONF="$HOME/.config/hypr/source/power-mode.conf"

chosen=$(printf '⚡  Performance\n  Normal' | \
    rofi -dmenu -p "Power Mode" -config "$HOME/.config/rofi/config.rasi" -format s)

[[ -z "$chosen" ]] && exit 0

case "$chosen" in
    *Performance*)
        cat > "$CONF" << 'EOF'
# Performance mode (disable all effects)
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
    *Normal*)
      printf '# Normal mode (using appearance.conf)\n' > "$CONF"
        hyprctl reload
        notify-send -u low -t 2000 "Power Mode" "Normal - settings restored"
        ;;
esac
