#!/usr/bin/env bash
# detect system type and ask user preferences
# exports env vars for other modules

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../lib/common.sh"

readonly CONFIG_FILE="/tmp/dotfiles-install-config.env"

main() {
    log_step "System Detection"

    log_info "detecting system type"

    local is_laptop_detected=false
    if is_laptop; then
        is_laptop_detected=true
        log_substep "battery detected (laptop)"
    else
        log_substep "no battery (desktop)"
    fi

    local SYSTEM_TYPE=""
    if $is_laptop_detected; then
        if ask_yes_no "Is this a laptop?" "y"; then
            SYSTEM_TYPE="laptop"
        else
            SYSTEM_TYPE="desktop"
        fi
    else
        if ask_yes_no "Is this a laptop?" "n"; then
            SYSTEM_TYPE="laptop"
        else
            SYSTEM_TYPE="desktop"
        fi
    fi

    log_success "system type: $SYSTEM_TYPE"

    local USE_BLUETOOTH=false
    if ask_yes_no "Do you use Bluetooth?" "n"; then
        USE_BLUETOOTH=true
    fi

    log_info "detecting filesystem"
    local btrfs_detected=false
    if df -T "$HOME" | grep -q btrfs; then
        btrfs_detected=true
        log_substep "BTRFS on home"
    fi

    local USE_BTRFS=false
    if $btrfs_detected; then
        if ask_yes_no "Install BTRFS utilities?" "y"; then
            USE_BTRFS=true
        fi
    else
        if ask_yes_no "Install BTRFS utilities?" "n"; then
            USE_BTRFS=true
        fi
    fi

    local FILE_MANAGER=$(ask_choice "Choose your file manager:" "Nautilus" "Thunar" "Skip (already installed)")
    local BROWSER=$(ask_choice "Choose your browser:" "Firefox" "Zen Browser" "Brave" "Helium" "Skip (already installed)")
    local TEXT_EDITOR=$(ask_choice "Choose your default text editor (Super+M):" "Neovim" "VSCodium" "Kate")

    local AUR_HELPER=""
    if check_command paru; then
        log_info "found existing: paru"
        AUR_HELPER="paru"
    elif check_command yay; then
        log_info "found existing: yay"
        AUR_HELPER="yay"
    else
        AUR_HELPER=$(ask_choice "Choose AUR helper to install:" "paru" "yay")
    fi

    local INSTALL_WALLPAPERS=false
    if ask_yes_no "Download wallpapers from DimeusDev/wallpapers? (~250MB)" "y"; then
        INSTALL_WALLPAPERS=true
    fi

    log_info "saving configuration"

    cat > "$CONFIG_FILE" <<EOF
# generated: $(date)

SYSTEM_TYPE="$SYSTEM_TYPE"
USE_BLUETOOTH=$USE_BLUETOOTH
USE_BTRFS=$USE_BTRFS
FILE_MANAGER="$FILE_MANAGER"
BROWSER="$BROWSER"
TEXT_EDITOR="$TEXT_EDITOR"
AUR_HELPER="$AUR_HELPER"
INSTALL_WALLPAPERS=$INSTALL_WALLPAPERS
EOF

    log_success "configuration saved"

    log_step "Configuration Summary"
    echo ""
    printf "  ${CYAN}System Type:${RESET}       %s\n" "$SYSTEM_TYPE"
    printf "  ${CYAN}Bluetooth:${RESET}         %s\n" "$USE_BLUETOOTH"
    printf "  ${CYAN}BTRFS Tools:${RESET}       %s\n" "$USE_BTRFS"
    printf "  ${CYAN}File Manager:${RESET}      %s\n" "$FILE_MANAGER"
    printf "  ${CYAN}Browser:${RESET}           %s\n" "$BROWSER"
    printf "  ${CYAN}Text Editor:${RESET}       %s\n" "$TEXT_EDITOR"
    printf "  ${CYAN}AUR Helper:${RESET}        %s\n" "$AUR_HELPER"
    printf "  ${CYAN}Wallpapers:${RESET}        %s\n" "$INSTALL_WALLPAPERS"
    echo ""

    if ! ask_yes_no "Proceed with this configuration?" "y"; then
        log_error "cancelled"
        exit 1
    fi

    export SYSTEM_TYPE USE_BLUETOOTH USE_BTRFS FILE_MANAGER BROWSER TEXT_EDITOR AUR_HELPER INSTALL_WALLPAPERS

    log_success "confirmed"
}

main "$@"
