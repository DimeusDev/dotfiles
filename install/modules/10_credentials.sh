#!/usr/bin/env bash
# detect and optionally remove credential managers (gnome-keyring, kwallet) (because those stuff piss me off)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../lib/common.sh"

# format: "package:user_service"
readonly CREDENTIAL_MANAGERS=(
    "gnome-keyring:gnome-keyring-daemon"
    "seahorse:"
    "kwallet:kwalletd5"
    "kwallet6:kwalletd6"
    "kwalletmanager:"
)

detect_credential_managers() {
    local entry pkg
    for entry in "${CREDENTIAL_MANAGERS[@]}"; do
        pkg="${entry%%:*}"
        if pkg_installed "$pkg"; then
            echo "$entry"
        fi
    done
}

disable_credential_service() {
    local service="$1"
    [[ -z "$service" ]] && return 0
    systemctl --user stop    "${service}.service" 2>/dev/null || true
    systemctl --user disable "${service}.service" 2>/dev/null || true
    systemctl --user mask    "${service}.service" 2>/dev/null || true
}

main() {
    log_step "Credential Managers"

    local found=()
    local entry
    while IFS= read -r entry; do
        [[ -n "$entry" ]] && found+=("$entry")
    done < <(detect_credential_managers)

    if [[ ${#found[@]} -eq 0 ]]; then
        log_info "no credential managers detected"
        return 0
    fi

    local pkg_display="${found[0]%%:*}"
    local i
    for (( i=1; i<${#found[@]}; i++ )); do
        pkg_display+=", ${found[$i]%%:*}"
    done

    echo ""
    echo "  ${YELLOW}${BOLD}Credential managers detected:${RESET}  ${CYAN}${BOLD}${pkg_display}${RESET}"
    echo ""

    if ! ask_yes_no "Stop, disable, and remove them?" "y"; then
        log_info "skipped"
        return 0
    fi

    echo ""
    for entry in "${found[@]}"; do
        local pkg="${entry%%:*}"
        local service="${entry##*:}"

        disable_credential_service "$service"

        local required_by
        required_by=$(pacman -Qi "$pkg" 2>/dev/null | awk -F': ' '/^Required By/{print $2}')
        if [[ "$required_by" == "None" || -z "$required_by" ]]; then
            log_substep "removing $pkg"
            sudo pacman -Rns --noconfirm "$pkg" 2>/dev/null || log_warn "could not remove $pkg"
        else
            log_substep "$pkg kept (required by: $required_by) - service masked"
        fi
    done

    log_success "credential managers removed"
}

main "$@"
