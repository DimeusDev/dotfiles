#!/usr/bin/env bash
# MPRIS metadata listener

cover_dir="$HOME/.config/eww"
cover_file="${cover_dir}/cover.jpg"

playerctl metadata -F -f '{{playerName}}|{{title}}|{{artist}}|{{mpris:artUrl}}|{{status}}|{{mpris:length}}' 2>/dev/null | while IFS='|' read -r name title artist artUrl status length; do
    if [[ -n "$length" && "$length" =~ ^[0-9]+$ ]]; then
        len_sec=$(( (length + 500000) / 1000000 ))
        mins=$((len_sec / 60))
        secs=$((len_sec % 60))
        lengthStr=$(printf "%d:%02d" "$mins" "$secs")
    else
        len_sec=""
        lengthStr=""
    fi

    if [[ "$artUrl" =~ ^https?:// ]]; then
        tmp="${cover_file}.tmp"
        if wget -q -O "$tmp" "$artUrl" 2>/dev/null; then
            mv "$tmp" "$cover_file"
        else
            rm -f "$tmp"
            cp "${cover_dir}/scripts/cover.png" "$cover_file" 2>/dev/null
        fi
    elif [[ "$artUrl" =~ ^file:// ]]; then
        local_path="${artUrl#file://}"
        cp "$local_path" "$cover_file" 2>/dev/null
    else
        cp "${cover_dir}/scripts/cover.png" "$cover_file" 2>/dev/null
    fi

    jq -n -c \
        --arg name "$name" \
        --arg title "$title" \
        --arg artist "$artist" \
        --arg thumbnail "$cover_file" \
        --arg status "$status" \
        --arg length "$len_sec" \
        --arg lengthStr "$lengthStr" \
        '{name: $name, title: $title, artist: $artist, thumbnail: $thumbnail, status: $status, length: $length, lengthStr: $lengthStr}'
done
