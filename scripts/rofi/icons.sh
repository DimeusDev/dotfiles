#!/usr/bin/env bash
# nerd font icon picker - rofi + wtype
# source: github.com/cebem1nt/dotfiles

cat "$HOME/.config/rofi/icons.txt" \
    | rofi -dmenu -theme "$HOME/.config/rofi/config.rasi" \
    | awk '{printf "%s", $1}' \
    | wtype -
