#!/usr/bin/env bash
# rofi clipboard manager - cliphist + wl-copy with pin support

set -o nounset
set -o pipefail
shopt -s nullglob

readonly XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
readonly XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
readonly PINS_DIR="${XDG_DATA_HOME}/rofi-cliphist/pins"
readonly THUMB_DIR="${XDG_CACHE_HOME}/rofi-cliphist/thumbs"

readonly PIN_ICON=" "
readonly IMG_ICON=" "

readonly MAX_PREVIEW_LENGTH=80
readonly THUMB_SIZE="256x256"

validate_dependencies() {
    local missing=() cmd
    for cmd in cliphist wl-copy; do
        command -v "${cmd}" &>/dev/null || missing+=("${cmd}")
    done

    if ((${#missing[@]} > 0)); then
        printf 'Error: Missing dependencies: %s\n' "${missing[*]}" >&2
        return 1
    fi
    return 0
}

validate_dependencies || exit 1
mkdir -p "${PINS_DIR}" "${THUMB_DIR}"
chmod 700 "${PINS_DIR}" "${THUMB_DIR}"

generate_hash() {
    local input="$1"
    if command -v b2sum &>/dev/null; then
        printf '%s' "${input}" | b2sum | cut -c1-16
    else
        printf '%s' "${input}" | md5sum | cut -c1-16
    fi
}

create_preview() {
    local content="$1"
    local preview

    if ((${#content} > MAX_PREVIEW_LENGTH * 2)); then
        content="${content:0:$((MAX_PREVIEW_LENGTH * 2))}"
    fi

    # bash cleanup (no tr)
    preview="${content//[$'\n\r\t\v\f\x00\x1f']/ }"

    while [[ "${preview}" == *"  "* ]]; do
        preview="${preview//  / }"
    done

    preview="${preview#"${preview%%[![:space:]]*}"}"
    preview="${preview%"${preview##*[![:space:]]}"}"

    if ((${#preview} > MAX_PREVIEW_LENGTH)); then
        preview="${preview:0:MAX_PREVIEW_LENGTH}…"
    fi

    printf '%s' "${preview:-[empty]}"
}

ensure_thumbnail() {
    local id="$1"
    local thumb_path="${THUMB_DIR}/${id}.png"

    if [[ -f "${thumb_path}" ]]; then
        printf '%s' "${thumb_path}"
        return 0
    fi

    if ! command -v magick &>/dev/null; then
        return 1
    fi

    local tmp_path="${thumb_path}.tmp.$$"
    
    if cliphist decode "${id}" 2>/dev/null \
        | magick - -background none -resize "${THUMB_SIZE}" "${tmp_path}" 2>/dev/null; then
        mv -f "${tmp_path}" "${thumb_path}" 2>/dev/null && {
            printf '%s' "${thumb_path}"
            return 0
        }
    fi

    rm -f "${tmp_path}" 2>/dev/null
    return 1
}

display_menu() {
    printf '\000message\x1f<b>Alt+T</b>: Wipe | <b>Alt+U</b>: Pin | <b>Alt+Y</b>: UnPin\n'
    printf '\000use-hot-keys\x1ftrue\n'
    printf '\000keep-selection\x1ftrue\n'

    # pinned items
    local pin_file filename content preview
    while IFS= read -r pin_file; do
        [[ -r "${pin_file}" ]] || continue

        filename="${pin_file##*/}"
        content=$(<"${pin_file}") || continue
        preview=$(create_preview "${content}")

        printf '%s %s\000info\x1fpin:%s\n' "${PIN_ICON}" "${preview}" "${filename}"
    done < <(
        find "${PINS_DIR}" -maxdepth 1 -name '*.pin' -type f \
            -printf '%T@\t%p\n' 2>/dev/null \
        | sort -t$'\t' -k1 -rn \
        | cut -f2
    )

    # history items
    local line id rest rest_lower thumb_path display_text
    while IFS= read -r line; do
        [[ -z "${line}" ]] && continue

        id="${line%%$'\t'*}"
        rest="${line#*$'\t'}"

        rest_lower="${rest,,}"
        if [[ "${rest_lower}" =~ binary.*(png|jpg|jpeg|bmp|webp) ]]; then
            thumb_path=$(ensure_thumbnail "${id}") || thumb_path=""

            if [[ -n "${thumb_path}" ]]; then
                printf '%s: %s [Image]\000icon\x1f%s\x1finfo\x1fhist:%s\n' \
                    "${id}" "${IMG_ICON}" "${thumb_path}" "${line}"
            else
                printf '%s: [Binary] (No Preview)\000info\x1fhist:%s\n' \
                    "${id}" "${line}"
            fi
        else
            display_text=$(create_preview "${rest}")
            printf '%s: %s\000info\x1fhist:%s\n' "${id}" "${display_text}" "${line}"
        fi
    done < <(cliphist list 2>/dev/null)
}

handle_selection() {
    local selection="${1:-}"
    local action="${ROFI_RETV:-0}"
    local info="${ROFI_INFO:-}"

    # alt+t: wipe clipboard
    if ((action == 12)); then
        cliphist wipe 2>/dev/null
        rm -f "${THUMB_DIR}"/*.png
        display_menu
        return 0
    fi

    if [[ -z "${selection}" ]]; then
        display_menu
        return 0
    fi

    local type="${info%%:*}"
    local data="${info#*:}"

    if [[ "${type}" == "pin" ]]; then
        case "${action}" in
            1)  # Enter: Copy using input redirection
                [[ -r "${PINS_DIR}/${data}" ]] && wl-copy < "${PINS_DIR}/${data}"
                ;;
            10|11) # Alt+U/Y: Delete pin
                rm -f "${PINS_DIR}/${data}"
                display_menu
                ;;
            *) display_menu ;;
        esac
    
    else
        local id="${data%%$'\t'*}"
        case "${action}" in
            1)  # Enter: Decode and copy
                cliphist decode "${id}" 2>/dev/null | wl-copy
                ;;
            10) # Alt+U: Pin (Text only)
                local txt hash
                txt=$(cliphist decode "${id}" 2>/dev/null) || txt=""
                if [[ -n "${txt}" ]]; then
                    hash=$(generate_hash "${txt}")
                    printf '%s' "${txt}" > "${PINS_DIR}/${hash}.pin"
                fi
                display_menu
                ;;
            11) # Alt+Y: Delete from history + cache
                cliphist delete "${id}" 2>/dev/null
                rm -f "${THUMB_DIR}/${id}.png"
                display_menu
                ;;
            *) display_menu ;;
        esac
    fi
}

if (($# == 0)); then
    display_menu
else
    handle_selection "${1:-}"
fi
