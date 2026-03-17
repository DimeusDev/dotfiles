#!/usr/bin/env bash
# enable and start required systemd services

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../lib/common.sh"

readonly CONFIG_FILE="/tmp/dotfiles-install-config.env"
if [[ -f "$CONFIG_FILE" ]]; then
    source "$CONFIG_FILE"
fi

readonly DOTFILES_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"

enable_user_service() {
    local service="$1"
    log_substep "enabling user service: $service"
    systemctl --user enable "$service" 2>/dev/null || log_warn "Failed to enable $service"
}

enable_system_service() {
    local service="$1"
    log_substep "enabling system service: $service"
    sudo systemctl enable "$service" 2>/dev/null || log_warn "Failed to enable $service"
}

main() {
    log_step "Systemd Services"

    log_info "configuring user services"

    if systemctl --user list-unit-files | grep -q hypridle; then
        enable_user_service "hypridle.service"
    fi

    log_info "configuring system services"

    if [[ "${USE_BLUETOOTH:-false}" == "true" ]]; then
        enable_system_service "bluetooth.service"
        log_substep "starting bluetooth service"
        sudo systemctl start bluetooth.service 2>/dev/null || true
    fi

    log_info "enabling power-profiles-daemon"
    if systemctl list-unit-files | grep -q power-profiles-daemon; then
        enable_system_service "power-profiles-daemon.service"
        sudo systemctl start power-profiles-daemon.service 2>/dev/null || true
    fi

    log_info "deploying logind power config"
    local logind_src="$DOTFILES_DIR/config/logind/10-power.conf"
    if [[ -f "$logind_src" ]]; then
        sudo mkdir -p /etc/systemd/logind.conf.d
        sudo cp "$logind_src" /etc/systemd/logind.conf.d/10-power.conf
        # reload logind config without killing sessions
        sudo systemctl kill -s HUP systemd-logind 2>/dev/null || true
        log_substep "power button and lid configured"
    fi

    log_info "setting up hyprland plugins"
    if check_command hyprpm; then
        log_substep "adding hyprland-plugins"
        if hyprpm add https://github.com/hyprwm/hyprland-plugins 2>/dev/null; then
            log_success "hyprland-plugins added"
            log_substep "enabling hyprexpo"
            if hyprpm enable hyprexpo 2>/dev/null; then
                log_success "hyprexpo enabled"
            else
                log_warn "hyprpm enable hyprexpo failed"
            fi
        else
            log_warn "hyprpm add failed"
        fi
    else
        log_warn "hyprpm not found"
    fi

    log_success "services configured"
}

main "$@"
