#!/usr/bin/env bash
# toggle between TLP and PPD

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(cd "${SCRIPT_DIR}/../../.." && pwd)"
source "${SCRIPT_DIR}/../../lib/common.sh"

WAYBAR_CFG="$HOME/.config/waybar/config.jsonc"

# detection

detect_current() {
    if systemctl is-active --quiet tlp.service 2>/dev/null; then
        echo "tlp"
    elif systemctl is-active --quiet power-profiles-daemon.service 2>/dev/null; then
        echo "ppd"
    elif pkg_installed tlp; then
        echo "tlp"
    elif pkg_installed power-profiles-daemon; then
        echo "ppd"
    else
        echo "none"
    fi
}

show_status() {
    local current="$1"
    printf "\n"
    printf "  ${BOLD}${CYAN}current power manager:${RESET}  "
    if [[ "$current" == "tlp" ]]; then
        printf "${GREEN}TLP${RESET}\n"
        printf "  ${BOLD}${CYAN}waybar layout:${RESET}          "
        grep -q "laptop-tlp" "$WAYBAR_CFG" 2>/dev/null \
            && printf "${GREEN}laptop-tlp${RESET}\n" \
            || printf "${YELLOW}laptop (mismatch?)${RESET}\n"
    elif [[ "$current" == "ppd" ]]; then
        printf "${BLUE}power-profiles-daemon${RESET}\n"
        printf "  ${BOLD}${CYAN}waybar layout:${RESET}          "
        grep -q "laptop-tlp" "$WAYBAR_CFG" 2>/dev/null \
            && printf "${YELLOW}laptop-tlp (mismatch?)${RESET}\n" \
            || printf "${GREEN}laptop${RESET}\n"
    else
        printf "${RED}none detected${RESET}\n"
    fi
    printf "\n"
}

# waybar layout

set_waybar_layout() {
    local layout="$1"   # "laptop-tlp" or "laptop"
    [[ ! -f "$WAYBAR_CFG" ]] && { log_warn "waybar config not found: $WAYBAR_CFG"; return; }

    # replace
    sed -i "s|layouts/laptop-tlp\.jsonc|layouts/__PLACEHOLDER__.jsonc|g" "$WAYBAR_CFG"
    sed -i "s|layouts/laptop\.jsonc|layouts/__PLACEHOLDER__.jsonc|g" "$WAYBAR_CFG"
    sed -i "s|layouts/__PLACEHOLDER__\.jsonc|layouts/${layout}.jsonc|g" "$WAYBAR_CFG"
    log_substep "waybar layout → ${layout}.jsonc"
}

restart_waybar() {
    if systemctl --user is-active --quiet waybar 2>/dev/null; then
        systemctl --user restart waybar 2>/dev/null && log_substep "waybar restarted (systemd)" && return
    fi
    pkill -x waybar 2>/dev/null || true
    sleep 0.5
    nohup waybar &>/dev/null &
    disown
    log_substep "waybar restarted"
}

# switch to tlp

switch_to_tlp() {
    log_step "Switching to TLP"
    init_sudo

    # stop + mask PPD
    log_info "stopping power-profiles-daemon"
    sudo systemctl stop  power-profiles-daemon.service 2>/dev/null || true
    sudo systemctl mask  power-profiles-daemon.service 2>/dev/null || true
    sudo systemctl disable power-profiles-daemon.service 2>/dev/null || true

    # install TLP if missing
    if ! pkg_installed tlp; then
        log_info "installing TLP"
        install_packages "tlp" "tlp-rdw"
    fi

    # mask rfkill (required by TLP)
    sudo systemctl mask systemd-rfkill.service 2>/dev/null || true
    sudo systemctl mask systemd-rfkill.socket  2>/dev/null || true

    # enable + start TLP
    sudo systemctl enable --now tlp.service 2>/dev/null || true
    sudo systemctl enable --now NetworkManager-dispatcher.service 2>/dev/null || true

    sudo tlp start 2>/dev/null || true
    log_substep "TLP started"

    set_waybar_layout "laptop-tlp"
    restart_waybar

    cleanup_sudo
    log_success "switched to TLP"
}

# switch to PPD

switch_to_ppd() {
    log_step "Switching to power-profiles-daemon"
    init_sudo

    # stop + disable TLP
    log_info "stopping TLP"
    sudo systemctl stop    tlp.service     2>/dev/null || true
    sudo systemctl disable tlp.service     2>/dev/null || true
    sudo systemctl stop    tlp-rdw.service 2>/dev/null || true
    sudo systemctl disable tlp-rdw.service 2>/dev/null || true

    # unmask rfkill and PPD
    sudo systemctl unmask systemd-rfkill.service         2>/dev/null || true
    sudo systemctl unmask systemd-rfkill.socket          2>/dev/null || true
    sudo systemctl unmask power-profiles-daemon.service  2>/dev/null || true

    # install PPD if missing
    if ! pkg_installed power-profiles-daemon; then
        log_info "installing power-profiles-daemon"
        install_package_safe "power-profiles-daemon"
    fi

    # enable + start PPD
    sudo systemctl enable --now power-profiles-daemon.service 2>/dev/null || true
    log_substep "power-profiles-daemon started"

    set_waybar_layout "laptop"
    restart_waybar

    cleanup_sudo
    log_success "switched to power-profiles-daemon"
}

# main

main() {
    log_step "Power Manager Toggle"

    local current
    current=$(detect_current)
    show_status "$current"

    local target
    if [[ "$current" == "tlp" ]]; then
        target=$(ask_choice "currently on TLP - switch to:" \
            "power-profiles-daemon" \
            "Cancel")
        [[ "$target" == "Cancel" ]] && return 0
        target="ppd"
    elif [[ "$current" == "ppd" ]]; then
        target=$(ask_choice "currently on power-profiles-daemon - switch to:" \
            "TLP" \
            "Cancel")
        [[ "$target" == "Cancel" ]] && return 0
        target="tlp"
    else
        target=$(ask_choice "no power manager detected - enable:" \
            "TLP" \
            "power-profiles-daemon" \
            "Cancel")
        case "$target" in
            "TLP")                   target="tlp" ;;
            "power-profiles-daemon") target="ppd" ;;
            "Cancel")                return 0 ;;
        esac
    fi

    echo ""
    ask_yes_no "switch to ${target}? (services will restart, waybar will reload)" "y" || return 0

    if [[ "$target" == "tlp" ]]; then
        switch_to_tlp
    else
        switch_to_ppd
    fi

    printf "\n"
    show_status "$(detect_current)"
}

main "$@"
