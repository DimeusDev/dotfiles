#!/usr/bin/env bash
# shared wallpaper cache functions

readonly WALLPAPER_DIR="${HOME}/Pictures/wallpapers"
readonly CACHE_DIR="${HOME}/.cache/rofi-wallpaper-thumbs"
readonly CACHE_FILE="${CACHE_DIR}/rofi_input.cache"
readonly PATH_MAP="${CACHE_DIR}/path_map.cache"
readonly PLACEHOLDER_FILE="${CACHE_DIR}/_placeholder.png"
readonly THUMB_SIZE=300
readonly MAX_JOBS=$(( $(nproc) * 2 ))

ensure_placeholder() {
    [[ -f "$PLACEHOLDER_FILE" ]] && return
    magick -size "${THUMB_SIZE}x${THUMB_SIZE}" xc:"#333333" "$PLACEHOLDER_FILE" 2>/dev/null
}

generate_single_thumb() {
    local file="$1"
    local filename="${file##*/}"
    local thumb="${CACHE_DIR}/${filename}.png"
    [[ -f "$thumb" && "$thumb" -nt "$file" ]] && return 0
    # [0] extracts only first frame (handles GIFs correctly)
    nice -n 19 magick "${file}[0]" \
        -strip \
        -resize "${THUMB_SIZE}x${THUMB_SIZE}^" \
        -gravity center \
        -extent "${THUMB_SIZE}x${THUMB_SIZE}" \
        "$thumb" 2>/dev/null
}
export -f generate_single_thumb
export CACHE_DIR THUMB_SIZE

# orphan cleanup
cleanup_orphans() {
    [[ -f "$PATH_MAP" ]] || return
    local -A valid
    local name
    while IFS=$'\t' read -r name _; do
        valid["$name"]=1
    done < "$PATH_MAP"
    local thumb filename base
    shopt -s nullglob
    for thumb in "$CACHE_DIR"/*.png; do
        filename="${thumb##*/}"
        [[ "$filename" == "_placeholder.png" ]] && continue
        base="${filename%.png}"
        [[ -z "${valid[$base]+x}" ]] && rm -f "$thumb"
    done
    shopt -u nullglob
}

rebuild_cache() {
    notify-send -u low -t 2000 "Wallpaper" "rebuilding cache"
    mkdir -p "$CACHE_DIR"
    ensure_placeholder

    find "$WALLPAPER_DIR" -type f \( \
        -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \
        -o -iname "*.webp" -o -iname "*.gif" \
    \) -print0 | xargs -0 -P "$MAX_JOBS" -I {} bash -c 'generate_single_thumb "$@"' _ {}

    : > "$CACHE_FILE"
    : > "$PATH_MAP"

    while IFS= read -r -d '' file; do
        local filename thumb icon
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
}
