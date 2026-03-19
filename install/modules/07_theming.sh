#!/usr/bin/env bash
# configure gtk, qt, cursor, and icon themes
# runs matugen once to generate initial theme

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../lib/common.sh"

main() {
    log_step "Theming"

    log_info "rebuilding font cache"
    fc-cache -f 2>/dev/null && log_substep "font cache updated" || log_warn "fc-cache failed"

    log_info "setting cursor theme"

    mkdir -p "$HOME/.icons"
    mkdir -p "$HOME/.config/gtk-3.0"
    mkdir -p "$HOME/.config/gtk-4.0"

    cat > "$HOME/.config/gtk-3.0/settings.ini" <<EOF
[Settings]
gtk-cursor-theme-name=Bibata-Modern-Classic
gtk-icon-theme-name=Colloid-Dark
gtk-theme-name=adw-gtk3
gtk-application-prefer-dark-theme=true
EOF

    cat > "$HOME/.config/gtk-4.0/settings.ini" <<EOF
[Settings]
gtk-cursor-theme-name=Bibata-Modern-Classic
gtk-icon-theme-name=Colloid-Dark
gtk-theme-name=adw-gtk3
gtk-application-prefer-dark-theme=true
EOF

    log_substep "gtk settings configured"

    log_info "applying cursor theme"

    # create legacy fallback so X11/XWayland apps find cursor
    mkdir -p "$HOME/.local/share/icons/default"
    cat > "$HOME/.local/share/icons/default/index.theme" <<EOF
[Icon Theme]
Name=Default
Comment=Default Cursor Theme
Inherits=Bibata-Modern-Classic
EOF
    log_substep "created default cursor index.theme"

    if command -v hyprctl &>/dev/null && [[ -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]]; then
        hyprctl setcursor Bibata-Modern-Classic 18 >/dev/null 2>&1 && \
            log_substep "cursor applied live via hyprctl" || \
            log_warn "hyprctl setcursor failed"
    else
        log_info "hyprland not active - cursor applies on next login"
    fi

    log_info "applying icon theme"
    gsettings set org.gnome.desktop.interface icon-theme 'Colloid-Dark' 2>/dev/null || true
    log_substep "icon theme set: Colloid-Dark"

    log_substep "setting dark mode preference"
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' 2>/dev/null || true
    gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark' 2>/dev/null || true
    log_info "dark mode preference set"

    log_info "configuring Qt theme"

    mkdir -p "$HOME/.config/qt5ct" "$HOME/.config/qt6ct"
    cat > "$HOME/.config/qt5ct/qt5ct.conf" <<EOF
[Appearance]
color_scheme_path=$HOME/.config/matugen/generated/qt5ct-colors.conf
custom_palette=true
icon_theme=Colloid-Dark
standard_dialogs=default
style=Fusion
EOF

    cat > "$HOME/.config/qt6ct/qt6ct.conf" <<EOF
[Appearance]
color_scheme_path=$HOME/.config/matugen/generated/qt6ct-colors.conf
custom_palette=true
icon_theme=Colloid-Dark
standard_dialogs=xdgdesktopportal
style=Fusion
EOF

    log_substep "qt configured (Fusion + matugen colors)"

    if [[ ! -f "$HOME/.config/environment.d/qt.conf" ]]; then
        mkdir -p "$HOME/.config/environment.d"
        cat > "$HOME/.config/environment.d/qt.conf" <<EOF
QT_QPA_PLATFORMTHEME=qt6ct
EOF
        log_substep "qt environment variables set"
    fi

    # matugen post-hooks symlink
    log_substep "creating matugen target directories"
    mkdir -p \
        "$HOME/.config/matugen/generated" \
        "$HOME/.config/matugen/papirus-folders" \
        "$HOME/.config/cava/themes" \
        "$HOME/.config/fastfetch" \
        "$HOME/.config/btop/themes" \
        "$HOME/.cache/wal"

    log_info "generating initial theme"

    if ! check_command matugen; then
        log_warn "matugen not found, skipping"
        log_warn "theme generated on first wallpaper change"
    else
        log_substep "generating initial theme"

        if matugen --source-color-index 0 color hex 000000 >/dev/null 2>&1; then
            log_success "initial theme generated"
        else
            log_warn "failed to generate theme"
            log_warn "change wallpaper to regenerate (Ctrl+Space)"
        fi
    fi

    log_success "theming complete"
}

main "$@"
