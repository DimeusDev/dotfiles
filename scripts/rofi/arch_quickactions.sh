#!/usr/bin/env bash
# quick actions menu

CHOICE=$(printf " Terminal\n Power\n GTK Settings" | \
    rofi -dmenu \
         -i \
         -p "Quick Actions" \
         -theme "$HOME/.config/rofi/config.rasi" \
         -theme-str 'window { width: 22%; } listview { lines: 3; fixed-height: false; }')

case "$CHOICE" in
    *Terminal)    kitty ;;
    *Power)       "$HOME/.local/bin/logout.sh" ;;
    *"GTK"*)      nwg-look ;;
esac
