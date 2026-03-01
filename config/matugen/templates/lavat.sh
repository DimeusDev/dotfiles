#!/usr/bin/env bash
lavat -g -c "{{colors.source_color.default.hex_stripped}}" -k "{{colors.on_primary.default.hex_stripped}}" -R 2 -s 1
exec "$0"
