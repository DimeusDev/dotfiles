#!/usr/bin/env bash
# rofi wallpaper selector with thumbnail cache

set -uo pipefail

LOCK_FILE="/tmp/rofi-wallpaper-selector-lock"
exec 201>"$LOCK_FILE"
if ! flock -n 201; then
    notify-send -u low -t 1000 "Wallpaper" "already running"
    exit 1
fi

_LIB="${BASH_SOURCE[0]%/*}/_wallpaper_cache_lib.sh"
source "$_LIB" || { notify-send -u critical "Wallpaper" "cache lib not found"; exit 1; }

for cmd in magick rofi awww notify-send; do
    if ! command -v "$cmd" &>/dev/null; then
        notify-send -u critical "Wallpaper" "missing: $cmd"
        exit 1
    fi
done

resolve_path() {
    awk -F'\t' -v t="$1" '$1 == t {print $2; exit}' "$PATH_MAP"
}

if [[ ! -s "$CACHE_FILE" ]] || [[ "$WALLPAPER_DIR" -nt "$CACHE_FILE" ]]; then
    rebuild_cache
    ( cleanup_orphans ) 201>&- &
    disown
fi

selection=$(rofi \
    -dmenu \
    -i \
    -show-icons \
    -theme "$HOME/.config/rofi/wallpaper.rasi" \
    -p "Wallpaper" \
    < "$CACHE_FILE") || exit 0

if [[ -n "$selection" ]]; then
    full_path=$(resolve_path "$selection")

    if [[ -n "$full_path" && -f "$full_path" ]]; then
        cp "$full_path" ~/.cache/current_wallpaper 2>/dev/null

        awww img "$full_path" \
            --transition-type grow \
            --transition-duration 2 \
            --transition-fps 60 201>&- &

        setsid uwsm-app -- matugen --mode dark --source-color-index 0 image "$full_path" 201>&- &
    else
        rm -f "$CACHE_FILE"
        notify-send -u critical "Wallpaper" "path not found, cache cleared"
    fi
fi
