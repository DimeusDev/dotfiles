#!/usr/bin/env bash
# final steps, print completion message, reboot prompt

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../lib/common.sh"

main() {
    log_step "Installation Complete"

    echo ""
    echo "${BOLD}  installation complete${RESET}"
    echo ""

    if [[ -n "${INSTALLER_BACKUP_DIR:-}" ]]; then
        echo "${CYAN}Backup Location:${RESET}"
        echo "   $INSTALLER_BACKUP_DIR"
        echo ""
    fi

    echo "${CYAN}Next Steps:${RESET}"
    echo ""
    echo "   1. ${BOLD}Reboot your system${RESET} for all changes to take effect"
    echo "   2. Log into Hyprland (using UWSM if available)"
    echo "   3. Press ${BOLD}Ctrl+Space${RESET} to open wallpaper selector"
    echo "   4. Choose a wallpaper to generate your color theme"
    echo "   5. Press ${BOLD}Ctrl+Shift+Space${RESET} to view all keybindings"
    echo ""

    echo "${CYAN}Essential Keybindings:${RESET}"
    echo ""
    echo "   ${BOLD}Super+SEMICOLON${RESET}          - Open terminal (Kitty)"
    echo "   ${BOLD}Super+N${RESET}          - Open browser"
    echo "   ${BOLD}Super+E${RESET}          - Open file manager"
    echo "   ${BOLD}Alt+Space${RESET}        - Application launcher"
    echo "   ${BOLD}Ctrl+Space${RESET}       - Wallpaper selector"
    echo "   ${BOLD}Ctrl+Shift+Space${RESET} - Show all keybindings"
    echo "   ${BOLD}Alt+F4${RESET}           - Power menu"
    echo "   ${BOLD}SUPER+ESC${RESET}           - Rofi power menu"
    echo "   ${BOLD}Super+Q${RESET}          - Close window"
    echo ""

    echo "${CYAN}Configuration Files:${RESET}"
    echo ""
    echo "   Hyprland:  ${BOLD}~/.config/hypr/hyprland.conf${RESET}"
    echo "   Keybinds:  ${BOLD}~/.config/hypr/source/keybinds.conf${RESET}"
    echo "   Waybar:    ${BOLD}~/.config/waybar/config.jsonc${RESET}"
    echo "   Rofi:      ${BOLD}~/.config/rofi/${RESET}"
    echo "   Matugen:   ${BOLD}~/.config/matugen/config.toml${RESET}"
    echo ""

    echo "${CYAN}Troubleshooting:${RESET}"
    echo ""
    echo "   • Verify services: ${BOLD}systemctl --user status pipewire${RESET}"
    echo "   • Reload Hyprland: ${BOLD}Alt+R${RESET}"
    echo "   • Restart Waybar: ${BOLD}Alt+9${RESET}"
    echo "   • GitHub: ${BOLD}https://github.com/DimeusDev/dotfiles${RESET}"
    echo ""

    echo ""

    local action
    action=$(ask_choice "what would you like to do?" \
        "Reboot now" \
        "Tools" \
        "Exit")

    case "$action" in
        "Reboot now")
            log_info "rebooting"
            sleep 2
            systemctl reboot
            ;;
        "Tools")
            bash "${SCRIPT_DIR}/../utility/utility.sh"
            ;;
        "Exit")
            log_info "reboot when ready: systemctl reboot"
            ;;
    esac

    log_success "Done!"
    echo ""
}

main "$@"
