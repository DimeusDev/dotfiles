#!/usr/bin/env bash
# rebuild wallpaper thumbnail cache

set -uo pipefail

_LIB="${BASH_SOURCE[0]%/*}/_wallpaper_cache_lib.sh"
source "$_LIB" || { echo "cannot source wallpaper cache lib" >&2; exit 1; }

for cmd in magick notify-send; do
    if ! command -v "$cmd" &>/dev/null; then
        notify-send -u critical "Wallpaper" "missing: $cmd"
        exit 1
    fi
done

rebuild_cache
cleanup_orphans
notify-send -u low -t 2000 "Wallpaper" "cache ready"
