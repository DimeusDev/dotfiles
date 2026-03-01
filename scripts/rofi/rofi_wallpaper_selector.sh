#!/usr/bin/env bash
# rofi wallpaper selector with thumbnail cache

set -u
set -o pipefail

LOCK_FILE="/tmp/rofi-wallpaper-selector-lock"

# exit if already running (in case cache is being generated)
exec 201>"$LOCK_FILE"
if ! flock -n 201; then
	notify-send -u low -t 1000 "Wallpaper" "already running"
    exit 1
fi

readonly WALLPAPER_DIR="${HOME}/Pictures/wallpapers"
readonly CACHE_DIR="${HOME}/.cache/rofi-wallpaper-thumbs"
readonly CACHE_FILE="${CACHE_DIR}/rofi_input.cache"
readonly PATH_MAP="${CACHE_DIR}/path_map.cache"
readonly PLACEHOLDER_FILE="${CACHE_DIR}/_placeholder.png"
readonly ROFI_THEME="${HOME}/.config/rofi/wallpaper.rasi"
readonly THUMB_SIZE=300

readonly MAX_JOBS=$(($(nproc) * 2))

for cmd in magick rofi swww notify-send; do
    if ! command -v "$cmd" &>/dev/null; then
        notify-send "Error" "Missing dependency: $cmd" -u critical
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

    # [0] extracts only first frame (for gif)
    nice -n 19 magick "${file}[0]" \
        -strip \
        -resize "${THUMB_SIZE}x${THUMB_SIZE}^" \
        -gravity center \
        -extent "${THUMB_SIZE}x${THUMB_SIZE}" \
        "$thumb" 2>/dev/null
}
export -f generate_single_thumb
export CACHE_DIR THUMB_SIZE

# remove thumbs for wallpapers that were deleted
cleanup_orphans() {
    for thumb in "$CACHE_DIR"/*.png; do
        filename=$(basename "$thumb")
        [[ "$filename" == "_placeholder.png" ]] && continue

        if ! grep -q "^${filename%.png}" "$PATH_MAP" 2>/dev/null; then
             rm -f "$thumb"
        fi
    done
}

refresh_cache() {
    notify-send -u low -t 1000 "Wallpaper" "rebuilding cache"
    ensure_placeholder

    # update thumbnails 
    find "$WALLPAPER_DIR" -type f \( \
        -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \
        -o -iname "*.webp" -o -iname "*.gif" \
    \) -print0 | xargs -0 -P "$MAX_JOBS" -I {} bash -c 'generate_single_thumb "$@"' _ {}

    # build cache files
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

        # format: Name \0 icon \x1f PathToIcon
        printf '%s\0icon\x1f%s\n' "$filename" "$icon" >> "$CACHE_FILE"
        printf '%s\t%s\n' "$filename" "$file" >> "$PATH_MAP"

    done < <(find "$WALLPAPER_DIR" -type f \( \
        -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \
        -o -iname "*.webp" -o -iname "*.gif" \
    \) -print0 | sort -z)

    ( cleanup_orphans ) 201>&- & disown
}

resolve_path() {
    local name="$1"
    awk -F'\t' -v t="$name" '$1 == t {print $2; exit}' "$PATH_MAP"
}

# refresh cache if missing or different
if [[ ! -s "$CACHE_FILE" ]] || [[ "$WALLPAPER_DIR" -nt "$CACHE_FILE" ]]; then
    refresh_cache
fi

selection=$(rofi \
    -dmenu \
    -i \
    -show-icons \
    -theme "$ROFI_THEME" \
    -p "Wallpaper" \
    < "$CACHE_FILE"
)

exit_code=$?

if [[ $exit_code -ne 0 ]]; then
    exit 0
fi

if [[ -n "$selection" ]]; then
    full_path=$(resolve_path "$selection")

    if [[ -n "$full_path" && -f "$full_path" ]]; then
        current_flags="--mode dark"

        cp "$full_path" ~/.cache/current_wallpaper 2>/dev/null

        swww img "$full_path" \
            --transition-type grow \
            --transition-duration 2 \
            --transition-fps 60 201>&- &

        setsid uwsm-app -- matugen $current_flags image "$full_path" 201>&- &
    else
        # clear cache if not found
        rm -f "$CACHE_FILE"
        notify-send "Error" "Could not resolve path. Cache cleared." -u critical
    fi
fi
