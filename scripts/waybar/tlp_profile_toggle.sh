#!/usr/bin/env bash
# cycle TLP power profiles

STATE_FILE="/tmp/tlp_profile_mode"
current=$(cat "$STATE_FILE" 2>/dev/null || echo "balanced")

case "$current" in
    performance) next="power-saver" ;;
    power-saver) next="balanced" ;;
    *)           next="performance" ;;
esac

"$HOME/.local/bin/tlp_profile_set.sh" "$next"
