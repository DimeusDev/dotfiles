#!/usr/bin/env bash
# cava visualizer for waybar (run only when audio playing)
bar="▁▂▃▄▅▆▇█"
dict="s/;//g"
bar_length=${#bar}
for ((i = 0; i < bar_length; i++)); do
    dict+=";s/$i/${bar:$i:1}/g"
done

CAVA_CFG="/tmp/cava_cfg_$$"
PIPELINE_PID=""
GRACE=3
SILENT="▁▁▁▁▁▁▁▁▁▁"

cat > "$CAVA_CFG" <<EOF
[general]
framerate = 30
bars = 10

[input]
method = pulse
source = auto

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
EOF

cleanup() {
    if [[ -n "$PIPELINE_PID" ]]; then
        kill "$PIPELINE_PID" 2>/dev/null
        pkill -f "cava -p $CAVA_CFG" 2>/dev/null
        wait "$PIPELINE_PID" 2>/dev/null
    fi
    rm -f "$CAVA_CFG"
}
trap cleanup EXIT
trap 'exit 0' INT TERM PIPE

has_audio() {
    # Corked: no = playing
    # Corked: yes = paused
    pactl list sink-inputs 2>/dev/null | grep -q "Corked: no"
}

start_pipeline() {
    [[ -n "$PIPELINE_PID" ]] && kill -0 "$PIPELINE_PID" 2>/dev/null && return
    cava -p "$CAVA_CFG" 2>/dev/null | sed -u "$dict" | while IFS= read -r f; do
        if [[ "$f" != "$SILENT" ]]; then
            silent_since=0
            echo "$f"
        elif (( silent_since == 0 )); then
            printf -v silent_since '%(%s)T' -1
            echo "$f"
        else
            printf -v _now '%(%s)T' -1
            if (( _now - silent_since < GRACE )); then
                echo "$f"
            else
                echo ""
            fi
        fi
    done &
    PIPELINE_PID=$!
}

stop_pipeline() {
    [[ -z "$PIPELINE_PID" ]] && return
    kill "$PIPELINE_PID" 2>/dev/null
    pkill -f "cava -p $CAVA_CFG" 2>/dev/null
    wait "$PIPELINE_PID" 2>/dev/null
    PIPELINE_PID=""
    echo ""
}

printf -v _t '%(%s)T' -1
last_audio=$(( _t - GRACE - 1 ))
last_check=0

while true; do
    printf -v now '%(%s)T' -1

    if (( now - last_check >= 1 )); then
        last_check=$now
        if has_audio; then
            last_audio=$now
            start_pipeline
        elif (( now - last_audio >= GRACE )); then
            stop_pipeline
        fi
    fi

    if [[ -z "$PIPELINE_PID" ]]; then
        echo ""
    fi

    sleep 0.1
done
