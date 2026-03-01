#!/usr/bin/env bash
# dimeus dotfiles installer - arch linux + hyprland

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly MODULES_DIR="$SCRIPT_DIR/modules"
readonly LIB_DIR="$SCRIPT_DIR/lib"

if [[ ! -f "$LIB_DIR/common.sh" ]]; then
    echo "ERROR: Common library not found: $LIB_DIR/common.sh"
    exit 1
fi

source "$LIB_DIR/common.sh"

check_prerequisites_full() {
    log_step "Prerequisites Check"

    local errors=0

    if [[ ! -f /etc/arch-release ]]; then
        log_error "This installer is designed for Arch Linux"
        ((++errors))
    else
        log_success "Running on Arch Linux"
    fi

    local required_cmds=("git" "sudo" "pacman" "systemctl")
    for cmd in "${required_cmds[@]}"; do
        if ! check_command "$cmd"; then
            log_error "Required command not found: $cmd"
            ((++errors))
        fi
    done

    if (( errors == 0 )); then
        log_success "prerequisites OK"
    fi

    if ! check_command hyprctl; then
        log_warn "Hyprland not detected"
        if ! ask_yes_no "Continue anyway?" "n"; then
            exit 1
        fi
    else
        log_success "Hyprland detected"
    fi

    if [[ $EUID -eq 0 ]]; then
        log_error "do not run as root"
        exit 1
    fi

    if ! ping -c 1 archlinux.org &>/dev/null; then
        log_warn "no network connectivity"
        if ! ask_yes_no "Continue without network?" "n"; then
            exit 1
        fi
    else
        log_success "network OK"
    fi

    if (( errors > 0 )); then
        log_error "Prerequisites check failed with $errors error(s)"
        exit 1
    fi
}

run_module() {
    local module_script="$1"
    local module_name="$(basename "$module_script" .sh)"

    if [[ ! -f "$module_script" ]]; then
        log_error "Module not found: $module_script"
        return 1
    fi

    if [[ ! -x "$module_script" ]]; then
        chmod +x "$module_script"
    fi

    log_step "Module: $module_name"

    # bash subshell avoids set -e conflict
    local result=0
    bash "$module_script" || result=$?

    if [[ $result -eq 0 ]]; then
        log_success "Module completed: $module_name"
        return 0
    else
        log_error "Module failed: $module_name (Exit code: $result)"
        return 1
    fi
}

main() {
    trap 'cleanup_sudo' EXIT

    log_warn "Hyprland must already be installed"

    if ! ask_yes_no "Ready to install?" "y"; then
        log_info "cancelled"
        exit 0
    fi

    check_prerequisites_full

    # grace period
    log_info "starting in 3s..."
    sleep 3

    local modules=(
        "$MODULES_DIR/01_backup.sh"
        "$MODULES_DIR/02_detect.sh"
        "$MODULES_DIR/03_packages.sh"
        "$MODULES_DIR/04_dotfiles.sh"
        "$MODULES_DIR/05_zsh.sh"
        "$MODULES_DIR/06_services.sh"
        "$MODULES_DIR/07_theming.sh"
        "$MODULES_DIR/09_autologin.sh"
        "$MODULES_DIR/10_credentials.sh"
        "$MODULES_DIR/08_finalize.sh"
    )

    local total_modules=${#modules[@]}
    local current=0
    local failed=0

    for module in "${modules[@]}"; do
        # CRITICAL: use pre-increment to avoid set -e treating 0 as failure
        ((++current))
        echo ""

        if ! run_module "$module"; then
            ((++failed))
            log_error "Module failed! Check errors above."

            if ! ask_yes_no "Continue with remaining modules?" "n"; then
                log_error "Installation aborted by user"
                exit 1
            fi
        fi

        sleep 1
    done

    echo ""
    if (( failed == 0 )); then
        log_success "all modules done"
    else
        log_warn "Installation completed with $failed failed module(s)"
        log_warn "Check logs above for details"
    fi
}

main "$@"
