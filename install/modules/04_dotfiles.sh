#!/usr/bin/env bash
# deploy dotfiles from repo to ~/.config/ and other locations
# updates some conf with user choices

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../lib/common.sh"

readonly CONFIG_FILE="/tmp/dotfiles-install-config.env"
if [[ -f "$CONFIG_FILE" ]]; then
    source "$CONFIG_FILE"
fi

readonly DOTFILES_DIR="$(cd "${SCRIPT_DIR}/../.." && pwd)"

main() {
    log_step "Dotfiles Deployment"

    if [[ ! -d "$DOTFILES_DIR" ]]; then
        log_error "dotfiles directory not found: $DOTFILES_DIR"
        exit 1
    fi

    log_info "dotfiles location: $DOTFILES_DIR"

    # deploy config directories
    log_info "deploying configuration files"

    local config_dirs=(
        "hypr"
        "waybar"
        "rofi"
        "matugen"
        "kitty"
        "btop"
        "nvim"
        "swaync"
        "wlogout"
        "swayosd"
        "eww"
        "cava"
        "fontconfig"
        "wireplumber"
        "pipewire"
    )

    for dir in "${config_dirs[@]}"; do
        local src="$DOTFILES_DIR/config/$dir"
        local dst="$HOME/.config/$dir"

        if [[ ! -d "$src" ]]; then
            log_warn "Config directory not found: $src (skipping)"
            continue
        fi

        log_substep "deploying: $dir"

        if [[ -d "$dst" ]]; then
            rm -rf "$dst"
        fi

        cp -r "$src" "$dst"
    done

    # set waybar layout
    local waybar_cfg="$HOME/.config/waybar/config.jsonc"
    if [[ -f "$waybar_cfg" ]] && [[ "${SYSTEM_TYPE:-desktop}" == "laptop" ]]; then
        if [[ "${POWER_MANAGER:-ppd}" == "tlp" ]]; then
            sed -i 's|layouts/desktop.jsonc|layouts/laptop-tlp.jsonc|' "$waybar_cfg"
            log_substep "waybar set to laptop-tlp layout"
        else
            sed -i 's|layouts/desktop.jsonc|layouts/laptop.jsonc|' "$waybar_cfg"
            log_substep "waybar set to laptop layout"
        fi
    fi

    # deploy scripts to ~/.local/bin
    log_info "deploying scripts to ~/.local/bin"

    mkdir -p "$HOME/.local/bin"

    if [[ -d "$DOTFILES_DIR/scripts" ]]; then
        while IFS= read -r -d '' script; do
            dest="$HOME/.local/bin/$(basename "$script")"
            cp -f "$script" "$dest"
            chmod +x "$dest"
        done < <(find "$DOTFILES_DIR/scripts" -type f -name "*.sh" -print0)

        log_substep "scripts installed to ~/.local/bin"

        # deploy ssh_manager data directory (icons + sessions.conf)
        local ssh_mgr_src="$DOTFILES_DIR/scripts/rofi/ssh_manager"
        local ssh_mgr_dst="$HOME/.local/bin/rofi/ssh_manager"
        mkdir -p "$ssh_mgr_dst/icons"

        # deploy icons (skip .gitkeep)
        if [[ -d "$ssh_mgr_src/icons" ]]; then
            find "$ssh_mgr_src/icons" -type f ! -name ".gitkeep" \
                -exec cp -f {} "$ssh_mgr_dst/icons/" \;
            log_substep "ssh manager icons deployed"
        fi

        # deploy sessions.conf template with backup if content differs
        local sessions_src="$ssh_mgr_src/sessions.conf"
        local sessions_dst="$ssh_mgr_dst/sessions.conf"
        if [[ -f "$sessions_src" ]]; then
            if [[ -f "$sessions_dst" ]]; then
                if ! diff -q "$sessions_src" "$sessions_dst" &>/dev/null; then
                    local backup="${sessions_dst}.bak.$(date '+%Y%m%d_%H%M%S')"
                    cp "$sessions_dst" "$backup"
                    log_substep "backed up existing sessions.conf → $(basename "$backup")"
                    cp "$sessions_src" "$sessions_dst"
                    log_substep "deployed new sessions.conf template"
                else
                    log_substep "sessions.conf unchanged (skipped)"
                fi
            else
                cp "$sessions_src" "$sessions_dst"
                log_substep "created sessions.conf from template"
            fi
        fi
    fi

    # deploy desktop files
    log_info "installing .desktop files"

    mkdir -p "$HOME/.local/share/applications"

    # remove stale .desktop files from previous installs
    local stale_desktop=("powermode.desktop")
    for f in "${stale_desktop[@]}"; do
        rm -f "$HOME/.local/share/applications/$f"
    done

    if [[ -d "$DOTFILES_DIR/config/applications" ]]; then
        while IFS= read -r -d '' desktop; do
            cp -f "$desktop" "$HOME/.local/share/applications/"
        done < <(find "$DOTFILES_DIR/config/applications" -name "*.desktop" -print0)
        log_substep "desktop files installed to ~/.local/share/applications"
    fi

    # deploy zsh config
    log_info "deploying zsh configuration"

    if [[ -f "$DOTFILES_DIR/zsh/.zshrc" ]]; then
        cp "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
        log_substep "copied .zshrc"
    fi

    if [[ -f "$DOTFILES_DIR/zsh/.zprofile" ]]; then
        cp "$DOTFILES_DIR/zsh/.zprofile" "$HOME/.zprofile"
        log_substep "copied .zprofile"
    fi

    # update keybinds with user choices
    log_info "updating keybinds with your preferences"

    local keybinds_file="$HOME/.config/hypr/source/keybinds.conf"

    if [[ ! -f "$keybinds_file" ]]; then
        log_warn "Keybinds file not found: $keybinds_file"
    else
        case "${FILE_MANAGER:-Nautilus}" in
            "Nautilus")
                sed -i 's/^\$fileManager[[:space:]]*=.*/\$fileManager = nautilus/' "$keybinds_file"
                ;;
            "Thunar")
                sed -i 's/^\$fileManager[[:space:]]*=.*/\$fileManager = thunar/' "$keybinds_file"
                ;;
        esac

        case "${BROWSER:-Firefox}" in
            "Firefox")
                sed -i 's/^\$browser[[:space:]]*=.*/\$browser = firefox/' "$keybinds_file"
                ;;
            "Zen Browser")
                sed -i 's/^\$browser[[:space:]]*=.*/\$browser = zen-browser/' "$keybinds_file"
                ;;
            "Brave")
                sed -i 's/^\$browser[[:space:]]*=.*/\$browser = brave/' "$keybinds_file"
                ;;
            "Helium")
                sed -i 's/^\$browser[[:space:]]*=.*/\$browser = helium-browser/' "$keybinds_file"
                ;;
        esac

        case "${TEXT_EDITOR:-Neovim}" in
            "Neovim")
                sed -i 's/^\$textEditor[[:space:]]*=.*/\$textEditor = kitty -e nvim/' "$keybinds_file"
                ;;
            "VSCodium")
                sed -i 's/^\$textEditor[[:space:]]*=.*/\$textEditor = codium/' "$keybinds_file"
                ;;
            "Kate")
                sed -i 's/^\$textEditor[[:space:]]*=.*/\$textEditor = kate/' "$keybinds_file"
                ;;
        esac

        log_substep "updated keybinds.conf with your preferences"
    fi

    # set default applications (XDG MIME)
    log_info "setting default applications (XDG MIME)"

    local browser_desktop=""
    case "${BROWSER:-}" in
        "Firefox")    browser_desktop="firefox.desktop" ;;
        "Zen Browser") browser_desktop="zen-browser.desktop" ;;
        "Brave")      browser_desktop="brave-browser.desktop" ;;
        "Helium")     browser_desktop="helium.desktop" ;;
    esac

    if [[ -n "$browser_desktop" ]]; then
        xdg-settings set default-web-browser "$browser_desktop" 2>/dev/null || true
        xdg-mime default "$browser_desktop" x-scheme-handler/http x-scheme-handler/https 2>/dev/null || true
        log_substep "Browser default: $browser_desktop"
    fi

    case "${FILE_MANAGER:-}" in
        "Nautilus")
            xdg-mime default org.gnome.Nautilus.desktop inode/directory 2>/dev/null || true
            log_substep "File manager default: org.gnome.Nautilus.desktop"
            ;;
        "Thunar")
            xdg-mime default thunar.desktop inode/directory 2>/dev/null || true
            log_substep "File manager default: thunar.desktop"
            ;;
    esac

    local editor_desktop=""
    case "${TEXT_EDITOR:-}" in
        "Neovim")   editor_desktop="nvim.desktop" ;;
        "VSCodium") editor_desktop="codium.desktop" ;;
        "Kate")     editor_desktop="org.kde.kate.desktop" ;;
    esac

    if [[ -n "$editor_desktop" ]]; then
        xdg-mime default "$editor_desktop" text/plain text/x-shellscript 2>/dev/null || true
        log_substep "Text editor default: $editor_desktop"
    fi

    # wallpapers
    if [[ "${INSTALL_WALLPAPERS:-false}" == "true" ]]; then
        log_info "downloading wallpapers"

        if ! check_command git; then
            log_error "git not installed"
            log_error "Install it with: sudo pacman -S git"
            exit 1
        fi

        local wallpapers_dir="$HOME/Pictures/wallpapers"

        if [[ -d "$wallpapers_dir" ]] && [[ $(ls -A "$wallpapers_dir" | wc -l) -gt 5 ]]; then
            log_success "wallpapers already present"
        else
            mkdir -p "$wallpapers_dir"

            log_substep "cloning wallpapers"
            if git clone https://github.com/DimeusDev/wallpapers.git "$wallpapers_dir-tmp"; then
                mv "$wallpapers_dir-tmp"/* "$wallpapers_dir/"
                rm -rf "$wallpapers_dir-tmp"
                log_success "wallpapers downloaded"
            else
                log_warn "failed to clone wallpapers repository"
                log_warn "clone manually: git clone https://github.com/DimeusDev/wallpapers.git ~/Pictures/wallpapers"
            fi
        fi
    else
        log_info "skipping wallpaper download"
    fi

    # create necessary directories
    mkdir -p "$HOME/.cache/matugen"
    mkdir -p "$HOME/Pictures"

    log_success "dotfiles deployed"
}

main "$@"
