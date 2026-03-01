#!/usr/bin/env bash
# install all required packages based on user config

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../lib/common.sh"

readonly CONFIG_FILE="/tmp/dotfiles-install-config.env"
if [[ -f "$CONFIG_FILE" ]]; then
    source "$CONFIG_FILE"
fi

declare -ga AUR_INSTALLED=()
declare -ga AUR_FAILED=()
declare -ga AUR_FAILED_REASONS=()

# install aur packages
install_aur_safe() {
    local package="$1"
    local aur_cmd="${AUR_HELPER:-paru}"
    local output
    local exit_code

    if pkg_installed "$package"; then
        printf "  ${MAGENTA}→${RESET} ${CYAN}%s${RESET} (AUR)... ${YELLOW}already installed${RESET}\n" "$package"
        return 0
    fi

    printf "  ${MAGENTA}→${RESET} Installing ${CYAN}%s${RESET} (AUR)..." "$package"

    output=$($aur_cmd -S --noconfirm "$package" 2>&1)
    exit_code=$?

    if [[ $exit_code -eq 0 ]]; then
        if echo "$output" | grep -q "is up to date"; then
            printf " ${YELLOW}already installed${RESET}\n"
        else
            printf " ${GREEN}done${RESET}\n"
            AUR_INSTALLED+=("$package")
        fi
        return 0
    fi

    printf " ${RED}FAILED${RESET}\n"
    AUR_FAILED+=("$package")

    local reason
    local error_detail=""

    if echo "$output" | grep -qi "could not find"; then
        reason="not found in AUR"
    elif echo "$output" | grep -qi "failed to build"; then
        reason="build failed"
        error_detail=$(echo "$output" | grep -iE "(error:|failed|cannot|undefined|fatal)" | tail -3 | tr '\n' ' ' | sed 's/  */ /g' | cut -c1-120)
    elif echo "$output" | grep -qi "could not satisfy dependencies"; then
        reason="dependency conflict"
        error_detail=$(echo "$output" | grep -E "^\s*::" | head -1 | sed 's/^.*:: //' | cut -c1-100)
    elif echo "$output" | grep -qi "conflicting files"; then
        reason="file conflict"
        error_detail=$(echo "$output" | grep -i "conflicting" | head -1 | cut -c1-100)
    elif echo "$output" | grep -qi "PKGBUILD does not exist"; then
        reason="PKGBUILD not found"
    elif echo "$output" | grep -qi "failed to retrieve"; then
        reason="download failed"
    else
        reason="installation failed"
        error_detail=$(echo "$output" | grep -iE "(error|failed|cannot)" | tail -1 | cut -c1-120)
    fi

    if [[ -n "$error_detail" ]]; then
        AUR_FAILED_REASONS+=("$package: $reason → $error_detail")
    else
        AUR_FAILED_REASONS+=("$package: $reason")
    fi

    if [[ -n "$error_detail" ]]; then
        printf "    ${RED}└─${RESET} %s\n" "$error_detail"
    fi

    return 0
}

main() {
    log_step "Package Installation"

    init_sudo
    reset_package_tracking

    log_info "installing mandatory packages"

    # gui & fonts
    local pkgs_gui_fonts=(
        "qt5-wayland" "qt6-wayland" "gtk3" "gtk4" "nwg-look" "qt5ct" "qt6ct"
        "qt6-svg" "qt6-multimedia-ffmpeg" "kvantum" "adw-gtk-theme" "matugen"
        "otf-font-awesome" "ttf-jetbrains-mono-nerd" "noto-fonts-emoji" "sassc"
    )

    # desktop
    local pkgs_desktop=(
        "waybar" "swww" "hyprlock" "hypridle" "hyprsunset" "hyprpicker"
        "swaync" "swayosd" "rofi" "brightnessctl" "pamixer" "wlogout"
        "wtype"
        "xorg-xhost"
    )

    # wayland session & portals
    local pkgs_wayland=(
        "uwsm"
        "xdg-desktop-portal-hyprland"
        "xdg-desktop-portal-gtk"
        "xdg-utils"
        "pipewire" "wireplumber" "pipewire-pulse"
    )

    # audio
    local pkgs_audio=(
        "playerctl" "pavucontrol"
    )

    # terminal & shell
    local pkgs_terminal=(
        "kitty" "zsh" "zsh-syntax-highlighting" "zsh-autosuggestions"
        "starship" "fastfetch" "bat" "eza" "fd" "tealdeer" "yazi"
        "gum" "man-db" "tree" "fzf" "zoxide" "less" "ripgrep" "libqalculate"
    )

    # multimedia
    local pkgs_multimedia=(
        "ffmpeg" "mpv" "mpv-mpris" "swappy" "swayimg" "resvg" "imagemagick"
        "libheif" "ffmpegthumbnailer" "grim" "slurp" "wl-clipboard" "cliphist"
        "tesseract" "tesseract-data-eng"
    )

    # system
    local pkgs_sysadmin=(
        "btop" "libsecret" "yad" "polkit" "hyprpolkitagent"
        "network-manager-applet"
    )

    # dev
    local pkgs_dev=(
        "neovim" "git"
        "nodejs" "npm"
        "make"
    )

    # music
    local pkgs_music=(
        "cava" "termusic"
    )

    # network & utils
    local pkgs_network=(
        "openssh" "wget" "curl" "rsync" "bc" "socat" "inotify-tools" "gdu"
    )

    local all_mandatory=(
        "${pkgs_gui_fonts[@]}"
        "${pkgs_desktop[@]}"
        "${pkgs_wayland[@]}"
        "${pkgs_audio[@]}"
        "${pkgs_terminal[@]}"
        "${pkgs_multimedia[@]}"
        "${pkgs_sysadmin[@]}"
        "${pkgs_dev[@]}"
        "${pkgs_music[@]}"
        "${pkgs_network[@]}"
    )

    log_info "installing mandatory packages (${#all_mandatory[@]} total)"
    install_packages "${all_mandatory[@]}"
    log_success "mandatory packages installed"

    # bluetooth
    if [[ "${USE_BLUETOOTH:-false}" == "true" ]]; then
        log_info "installing bluetooth packages"
        local pkgs_bluetooth=(
            "bluez" "bluez-utils" "blueman"
        )
        install_packages "${pkgs_bluetooth[@]}"
    fi

    # btrfs
    if [[ "${USE_BTRFS:-false}" == "true" ]]; then
        log_info "installing BTRFS utilities"
        local pkgs_btrfs=(
            "btrfs-progs" "compsize"
        )
        install_packages "${pkgs_btrfs[@]}"
    fi

    # power management
    if [[ "${POWER_MANAGER:-ppd}" == "tlp" ]]; then
        log_info "installing TLP"
        sudo systemctl disable --now power-profiles-daemon.service 2>/dev/null || true
        sudo pacman -Rns --noconfirm power-profiles-daemon 2>/dev/null || true
        install_packages "tlp" "tlp-rdw"
    else
        log_info "installing power-profiles-daemon"
        sudo systemctl disable --now tlp.service     2>/dev/null || true
        sudo systemctl disable --now tlp-rdw.service 2>/dev/null || true
        sudo pacman -Rns --noconfirm tlp tlp-rdw 2>/dev/null || true
        install_package_safe "power-profiles-daemon"
    fi

    # file manager
    case "${FILE_MANAGER:-}" in
        "Nautilus")
            log_info "installing Nautilus"
            install_packages "nautilus" "nautilus-image-converter"
            ;;
        "Thunar")
            log_info "installing Thunar"
            install_packages "thunar" "thunar-archive-plugin" "thunar-volman" "tumbler"
            ;;
        *)
            log_info "skipping file manager"
            ;;
    esac

    # browser
    case "${BROWSER:-}" in
        "Firefox")
            log_info "installing Firefox"
            install_package_safe "firefox"
            ;;
        "Zen Browser")
            log_warn "Zen Browser is AUR-only, will be installed later"
            ;;
        "Brave")
            log_warn "Brave is AUR-only, will be installed later"
            ;;
        "Helium")
            log_warn "Helium is AUR-only, will be installed later"
            ;;
        *)
            log_info "skipping browser"
            ;;
    esac

    # text editor
    case "${TEXT_EDITOR:-}" in
        "Neovim")
            log_info "Neovim in mandatory packages"
            ;;
        "VSCodium")
            log_warn "VSCodium is AUR-only, will be installed later"
            ;;
        "Kate")
            log_info "installing Kate"
            install_package_safe "kate"
            ;;
        *)
            log_info "skipping text editor"
            ;;
    esac

    # aur helper
    if [[ -n "${AUR_HELPER:-}" ]]; then
        if ! check_command "$AUR_HELPER"; then
            log_info "installing AUR helper: $AUR_HELPER"
            install_aur_helper "$AUR_HELPER"
        else
            log_success "AUR helper already installed: $AUR_HELPER"
        fi
    fi

    # aur packages
    if check_command paru || check_command yay; then
        log_info "installing AUR packages"

        install_aur_safe "bibata-cursor-theme"

        # colloid icon theme
        if find "$HOME/.local/share/icons" /usr/share/icons \
                -maxdepth 1 -name "Colloid*" -type d 2>/dev/null | grep -q .; then
            log_success "colloid icon theme already installed"
        else
            log_substep "colloid icon theme (from GitHub)"
            local colloid_tmp="/tmp/colloid-icon-theme-$$"
            if git clone --depth=1 https://github.com/vinceliuice/Colloid-icon-theme.git "$colloid_tmp" 2>/dev/null; then
                if bash "$colloid_tmp/install.sh" -s default -t all 2>/dev/null; then
                    log_success "colloid icon theme installed"
                else
                    log_warn "failed to run colloid install script"
                    AUR_FAILED+=("colloid-icon-theme")
                    AUR_FAILED_REASONS+=("colloid-icon-theme: install script failed")
                fi
                rm -rf "$colloid_tmp"
            else
                log_warn "failed to clone colloid icon theme"
                AUR_FAILED+=("colloid-icon-theme")
                AUR_FAILED_REASONS+=("colloid-icon-theme: git clone failed")
            fi
        fi

        install_aur_safe "caffeine-ng"

        log_substep "Google Sans Flex font"
        if ! fc-list | grep -qi "Google Sans Flex"; then
            local font_dir="$HOME/.local/share/fonts/google-sans-flex"
            local gsf_zip="/tmp/google-sans-flex-$$.zip"
            local gsf_tmp="/tmp/google-sans-flex-$$"
            mkdir -p "$font_dir" "$gsf_tmp"

            if curl -fsSL "https://api.fontsource.org/v1/download/google-sans-flex" \
                    -o "$gsf_zip" 2>/dev/null \
                && unzip -o "$gsf_zip" -d "$gsf_tmp" 2>/dev/null \
                && find "$gsf_tmp" \( -name "*.ttf" -o -name "*.otf" \) \
                    -exec cp {} "$font_dir/" \; 2>/dev/null; then
                fc-cache -f "$font_dir" 2>/dev/null
                log_success "Google Sans Flex installed"
            else
                log_warn "failed to install Google Sans Flex"
                AUR_FAILED+=("google-sans-flex-font")
                AUR_FAILED_REASONS+=("google-sans-flex-font: download or install failed")
            fi

            rm -rf "$gsf_zip" "$gsf_tmp" 2>/dev/null || true
        else
            log_success "Google Sans Flex already installed"
        fi

        # browser (aur)
        case "${BROWSER:-}" in
            "Zen Browser")
                install_aur_safe "zen-browser-bin"
                ;;
            "Brave")
                install_aur_safe "brave-bin"
                ;;
            "Helium")
                install_aur_safe "helium-browser-bin"
                ;;
        esac

        install_aur_safe "eww"

        case "${TEXT_EDITOR:-}" in
            "VSCodium")
                install_aur_safe "vscodium-bin"
                ;;
        esac
    fi

    log_step "Supplemental Packages (recommended)"
    log_info "type a number to toggle package, then press Enter to confirm"

    local supp_items=(
        "udisks2:Disk management daemon (auto-mount support)"
        "udiskie:Automatic removable drive mounter (tray icon)"
        "expac:Pacman data extractor (used by pkg_hogs alias in zshrc)"
        "git-delta:Enhanced diff viewer - syntax-highlighted git diffs"
        "jq:JSON command-line processor"
        "zathura:Minimal keyboard-driven document viewer"
        "zathura-pdf-mupdf:MuPDF backend for Zathura (PDF/EPUB/CBZ)"
        "file-roller:Archive manager GUI (zip/tar/rar via right-click)"
        "unzip:Extract .zip archives"
        "zip:Create .zip archives"
        "unrar:Extract .rar archives"
        "7zip:7z archive support (replaces p7zip)"
        "zram-generator:Compressed RAM swap - faster than disk, saves SSD writes"
        "lavat-git:Lava lamp terminal screensaver (AUR)"
    )

    # aur-only supplemental packages
    local supp_aur=("lavat-git")

    local selected_supp=()
    while IFS= read -r pkg; do
        [[ -n "$pkg" ]] && selected_supp+=("$pkg")
    done < <(multi_select "Supplemental Packages - toggle numbers to deselect" "${supp_items[@]}")

    if [[ ${#selected_supp[@]} -gt 0 ]]; then
        local selected_pacman=()
        local selected_aur=()
        for pkg in "${selected_supp[@]}"; do
            if printf '%s\n' "${supp_aur[@]}" | grep -qx "$pkg"; then
                selected_aur+=("$pkg")
            else
                selected_pacman+=("$pkg")
            fi
        done

        [[ ${#selected_pacman[@]} -gt 0 ]] && install_packages "${selected_pacman[@]}"

        for pkg in "${selected_aur[@]}"; do
            install_aur_safe "$pkg"
        done
    else
        log_info "no supplemental packages selected"
    fi

    print_full_summary
}

print_full_summary() {
    local total_installed=${#PKG_INSTALLED[@]}
    local total_skipped=${#PKG_SKIPPED[@]}
    local total_failed=${#PKG_FAILED[@]}
    local aur_installed=${#AUR_INSTALLED[@]}
    local aur_failed=${#AUR_FAILED[@]}
    local total_pacman=$((total_installed + total_skipped + total_failed))
    local total_aur=$((aur_installed + aur_failed))
    local all_failed=$((total_failed + aur_failed))

    printf "\n"
    printf "  ${BOLD}${CYAN}package summary${RESET}\n"
    printf "\n"

    printf "  ${BOLD}Official Repositories (pacman):${RESET}\n"
    printf "  ${GREEN}✓ Installed:${RESET}       %3d packages\n" "$total_installed"
    printf "  ${YELLOW}○ Already present:${RESET} %3d packages\n" "$total_skipped"
    printf "  ${RED}✗ Failed:${RESET}          %3d packages\n" "$total_failed"
    printf "  ${BLUE}─────────────────────────────────${RESET}\n"
    printf "  ${BOLD}  Subtotal:${RESET}        %3d packages\n" "$total_pacman"
    printf "\n"

    if [[ $total_aur -gt 0 ]]; then
        printf "  ${BOLD}AUR Packages:${RESET}\n"
        printf "  ${GREEN}✓ Installed:${RESET}       %3d packages\n" "$aur_installed"
        printf "  ${RED}✗ Failed:${RESET}          %3d packages\n" "$aur_failed"
        printf "  ${BLUE}─────────────────────────────────${RESET}\n"
        printf "  ${BOLD}  Subtotal:${RESET}        %3d packages\n" "$total_aur"
        printf "\n"
    fi

    if [[ $all_failed -gt 0 ]]; then
        printf "  ${RED}${BOLD}┌─ Failed Packages ─────────────────────────────────────────┐${RESET}\n"

        if [[ $total_failed -gt 0 ]]; then
            printf "  ${RED}│${RESET} ${BOLD}Pacman:${RESET}\n"
            for reason in "${PKG_FAILED_REASONS[@]}"; do
                printf "  ${RED}│${RESET}   • %s\n" "$reason"
            done
        fi

        if [[ $aur_failed -gt 0 ]]; then
            printf "  ${RED}│${RESET} ${BOLD}AUR:${RESET}\n"
            for reason in "${AUR_FAILED_REASONS[@]}"; do
                printf "  ${RED}│${RESET}   • %s\n" "$reason"
            done
        fi

        printf "  ${RED}${BOLD}└───────────────────────────────────────────────────────────┘${RESET}\n"
        printf "\n"
        printf "  ${YELLOW}${BOLD}How to fix:${RESET}\n"
        printf "  ${YELLOW}1.${RESET} Update your system:  ${CYAN}sudo pacman -Syu${RESET}\n"
        printf "  ${YELLOW}2.${RESET} Retry failed packages manually\n"
        printf "  ${YELLOW}3.${RESET} For dependency conflicts, you may need to:\n"
        printf "     ${CYAN}sudo pacman -S --overwrite '*' <package>${RESET}\n"
        printf "\n"
    else
        printf "  ${GREEN}${BOLD}All packages installed successfully!${RESET}\n"
        printf "\n"
    fi

    if [[ $all_failed -eq 0 ]]; then
        log_success "package installation complete"
    else
        log_warn "package installation: $all_failed failure(s)"
        log_info "installer will continue - fix failed packages later"
    fi
}

install_aur_helper() {
    local helper="$1"

    log_info "building $helper from AUR"

    local build_dir="/tmp/aur-$helper-$$"
    mkdir -p "$build_dir"

    if ! git clone "https://aur.archlinux.org/${helper}.git" "$build_dir/$helper" 2>/dev/null; then
        log_warn "failed to clone $helper from AUR"
        AUR_FAILED+=("$helper")
        AUR_FAILED_REASONS+=("$helper: failed to clone from AUR")
        rm -rf "$build_dir"
        return 0
    fi

    cd "$build_dir/$helper"
    if ! makepkg -si --noconfirm 2>/dev/null; then
        log_warn "failed to build/install $helper"
        AUR_FAILED+=("$helper")
        AUR_FAILED_REASONS+=("$helper: makepkg failed")
        cd "$HOME"
        rm -rf "$build_dir"
        return 0
    fi

    cd "$HOME"
    rm -rf "$build_dir"

    log_success "$helper installed"
    AUR_INSTALLED+=("$helper")
}

main "$@"
