#!/usr/bin/env bash
if eww active-windows 2>/dev/null | grep -q "control-panel"; then
    eww close-all
    hyprctl dispatch submap reset
else
    eww open control-panel
    hyprctl dispatch submap eww-panel
fi
