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

    if [[ "${POWER_MANAGER:-}" == "tlp" ]]; then
        log_info "enabling TLP"
        enable_system_service "tlp.service"
        enable_system_service "NetworkManager-dispatcher.service"

        log_substep "masking conflicting services"
        sudo systemctl mask systemd-rfkill.service 2>/dev/null || true
        sudo systemctl mask systemd-rfkill.socket 2>/dev/null || true
        sudo systemctl mask power-profiles-daemon.service 2>/dev/null || true
        sudo systemctl stop power-profiles-daemon.service 2>/dev/null || true

        log_substep "deploying TLP config"
        local tlp_src="$DOTFILES_DIR/config/tlp/tlp.conf"
        if [[ -f "$tlp_src" ]]; then
            sudo cp "$tlp_src" /etc/tlp.conf
            log_success "TLP config deployed to /etc/tlp.conf"
        else
            log_warn "TLP config not found at $tlp_src"
        fi

        log_substep "deploying sysctl battery tuning"
        local sysctl_src="$DOTFILES_DIR/config/tlp/sysctl-battery.conf"
        if [[ -f "$sysctl_src" ]]; then
            sudo cp "$sysctl_src" /etc/sysctl.d/99-battery.conf
            sudo sysctl -p /etc/sysctl.d/99-battery.conf 2>/dev/null || true
            log_success "sysctl battery tuning deployed"
        fi

        log_substep "deploying sudoers rule for waybar TLP controls"
        local sudoers_src="$DOTFILES_DIR/config/tlp/sudoers-tlp"
        if [[ -f "$sudoers_src" ]]; then
            if sudo visudo -cf "$sudoers_src" 2>/dev/null; then
                sudo cp "$sudoers_src" /etc/sudoers.d/tlp-waybar
                sudo chmod 440 /etc/sudoers.d/tlp-waybar
                log_success "sudoers rule deployed"
            else
                log_warn "sudoers file failed validation - skipping"
            fi
        fi

        log_substep "applying TLP settings"
        sudo tlp start 2>/dev/null || true

    elif [[ "${POWER_MANAGER:-}" == "ppd" ]]; then
        log_info "enabling power-profiles-daemon"
        if systemctl list-unit-files | grep -q power-profiles-daemon; then
            enable_system_service "power-profiles-daemon.service"
            sudo systemctl start power-profiles-daemon.service 2>/dev/null || true
        fi
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
