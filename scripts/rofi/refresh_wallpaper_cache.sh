#!/usr/bin/env bash

set -u
set -o pipefail

readonly WALLPAPER_DIR="${HOME}/Pictures/wallpapers"
readonly CACHE_DIR="${HOME}/.cache/rofi-wallpaper-thumbs"
readonly CACHE_FILE="${CACHE_DIR}/rofi_input_v2.cache"
readonly PATH_MAP="${CACHE_DIR}/path_map.cache"
readonly PLACEHOLDER_FILE="${CACHE_DIR}/_placeholder.png"
readonly THUMB_SIZE=300

readonly MAX_JOBS=$(($(nproc) * 2))

for cmd in magick notify-send; do
    if ! command -v "$cmd" &>/dev/null; then
        notify-send -u critical "Wallpaper" "missing: $cmd"
        exit 1
    fi
done

mkdir -p "$CACHE_DIR"

ensure_placeholder() {
    if [[ ! -f "$PLACEHOLDER_FILE" ]]; then
        magick -size "${THUMB_SIZE}x${THUMB_SIZE}" xc:"#333333" \
            "$PLACEHOLDER_FILE" 2>/dev/null
    fi
}

generate_single_thumb() {
    local file="$1"
    local filename="${file##*/}"
    local thumb="${CACHE_DIR}/${filename}.png"

    [[ -f "$thumb" && "$thumb" -nt "$file" ]] && return 0

    nice -n 19 magick "${file}[0]" \
        -strip \
        -resize "${THUMB_SIZE}x${THUMB_SIZE}^" \
        -gravity center \
        -extent "${THUMB_SIZE}x${THUMB_SIZE}" \
        "$thumb" 2>/dev/null
}
export -f generate_single_thumb
export CACHE_DIR THUMB_SIZE

cleanup_orphans() {
    for thumb in "$CACHE_DIR"/*.png; do
        filename=$(basename "$thumb")
        [[ "$filename" == "_placeholder.png" ]] && continue

        if ! grep -q "^${filename%.png}" "$PATH_MAP" 2>/dev/null; then
             rm -f "$thumb"
        fi
    done
}

notify-send -u low -t 2000 "Wallpaper" "rebuilding cache"

ensure_placeholder

find "$WALLPAPER_DIR" -type f \( \
    -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \
    -o -iname "*.webp" -o -iname "*.gif" \
\) -print0 | xargs -0 -P "$MAX_JOBS" -I {} bash -c 'generate_single_thumb "$@"' _ {}

: > "$CACHE_FILE"
: > "$PATH_MAP"

while IFS= read -r -d '' file; do
    filename=$(basename "$file")
    thumb="${CACHE_DIR}/${filename}.png"

    if [[ -f "$thumb" ]]; then
        icon="$thumb"
    else
        icon="$PLACEHOLDER_FILE"
    fi

    printf '%s\0icon\x1f%s\n' "$filename" "$icon" >> "$CACHE_FILE"
    printf '%s\t%s\n' "$filename" "$file" >> "$PATH_MAP"

done < <(find "$WALLPAPER_DIR" -type f \( \
    -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \
    -o -iname "*.webp" -o -iname "*.gif" \
\) -print0 | sort -z)

cleanup_orphans

notify-send -u low -t 2000 "Wallpaper" "cache ready"