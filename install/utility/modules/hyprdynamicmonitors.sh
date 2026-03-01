#!/usr/bin/env bash
# install and configure hyprdynamicmonitors for dynamic monitor profiles

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../../lib/common.sh"

AUTOSTART="$HOME/.config/hypr/source/autostart.conf"
HDM_CONFIG_DIR="$HOME/.config/hyprdynamicmonitors"
HDM_CONFIG="$HDM_CONFIG_DIR/config.toml"
HDM_DESTINATION="\$HOME/.config/hypr/source/monitors.conf"

install_hdm() {
    if command -v hyprdynamicmonitors &>/dev/null; then
        log_success "hyprdynamicmonitors already installed"
        return 0
    fi

    log_info "installing hyprdynamicmonitors"

    local aur_cmd
    if command -v paru &>/dev/null; then
        aur_cmd="paru"
    elif command -v yay &>/dev/null; then
        aur_cmd="yay"
    else
        log_error "no AUR helper found (paru or yay required)"
        return 1
    fi

    if ! $aur_cmd -S --noconfirm hyprdynamicmonitors-bin; then
        log_error "failed to install hyprdynamicmonitors-bin"
        return 1
    fi

    log_success "hyprdynamicmonitors installed"
}

write_config() {
    if [[ -f "$HDM_CONFIG" ]]; then
        log_info "config already exists: $HDM_CONFIG"
        ask_yes_no "overwrite with new config?" "n" || return 0
    fi

    mkdir -p "$HDM_CONFIG_DIR"

    cat > "$HDM_CONFIG" <<EOF
[general]
# generated monitors.conf written to hypr source dir
destination = "${HDM_DESTINATION}"
debounce_time_ms = 1500
EOF

    log_success "config written: $HDM_CONFIG"
    log_info "destination: ~/.config/hypr/source/monitors.conf"
}

add_autostart() {
    local exec_line="exec-once = uwsm-app -- hyprdynamicmonitors run"

    if [[ ! -f "$AUTOSTART" ]]; then
        log_warn "autostart.conf not found: $AUTOSTART"
        return 0
    fi

    if grep -qF "hyprdynamicmonitors" "$AUTOSTART"; then
        log_info "hyprdynamicmonitors already in autostart.conf"
        return 0
    fi

    echo "" >> "$AUTOSTART"
    echo "# dynamic monitor profiles" >> "$AUTOSTART"
    echo "$exec_line" >> "$AUTOSTART"

    log_success "added to autostart.conf"
}

run_tui() {
    log_info "launching TUI - configure your monitor profiles"
    log_info "Tab to navigate, n to add a new profile, q to quit"
    echo ""
    sleep 1
    hyprdynamicmonitors tui
}

main() {
    log_step "Dynamic Monitors"

    install_hdm || return 1
    write_config
    add_autostart

    echo ""
    log_info "after setup, the daemon starts automatically on next Hyprland launch"
    log_info "to apply a profile before Hyprland starts, add to your session startup:"
    log_info "  hyprdynamicmonitors prepare"
    echo ""

    if ask_yes_no "launch TUI to configure monitor profiles now?" "y"; then
        run_tui
    fi

    log_success "dynamic monitors configured"
}

main "$@"
