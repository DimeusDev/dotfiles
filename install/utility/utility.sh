#!/usr/bin/env bash
# Tool selector

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../lib/common.sh"

main() {
    log_step "Tools"

    local choice
    choice=$(ask_choice "select a tool:" \
        "Restore backup" \
        "Dynamic Monitors" \
        "Exit")

    case "$choice" in
        "Restore backup")   bash "${SCRIPT_DIR}/modules/restore.sh" ;;
        "Dynamic Monitors") bash "${SCRIPT_DIR}/modules/hyprdynamicmonitors.sh" ;;
        "Exit") return 0 ;;
    esac
}

main "$@"
