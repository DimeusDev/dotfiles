#!/usr/bin/env bash
# set default shell to zsh and install oh-my-zsh + plugins

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../lib/common.sh"

main() {
    log_step "Zsh Configuration"

    if ! check_command zsh; then
        log_error "zsh not installed"
        exit 1
    fi

    local zsh_path=$(which zsh)
    log_info "zsh: $zsh_path"

    local current_shell="$SHELL"
    log_info "current shell: $current_shell"

    if [[ "$current_shell" == "$zsh_path" ]]; then
        log_success "zsh already default shell"
    elif ask_yes_no "Change default shell to Zsh?" "y"; then
        log_substep "changing shell to zsh"

        if ! grep -q "^$zsh_path$" /etc/shells; then
            log_warn "adding zsh to /etc/shells"
            echo "$zsh_path" | sudo tee -a /etc/shells >/dev/null
        fi

        if chsh -s "$zsh_path"; then
            log_success "shell changed to zsh"
            log_info "log out and back in to apply shell change"
        else
            log_error "failed to change shell"
            log_info "change manually: chsh -s $zsh_path"
        fi
    else
        log_info "keeping current shell: $current_shell"
        log_info "change to zsh later: chsh -s $zsh_path"
    fi

    log_info "setting up oh-my-zsh"

    local omz_dir="$HOME/.config/oh-my-zsh"

    if [[ -d "$omz_dir" ]]; then
        log_success "oh-my-zsh already installed"
    else
        log_substep "installing oh-my-zsh"
        # ZSH=       → custom install location (XDG-friendly, not ~/.oh-my-zsh)
        # RUNZSH=no  → don't exec zsh after install (we are in the installer)
        # KEEP_ZSHRC=yes → do NOT overwrite existing .zshrc
        if ZSH="$omz_dir" RUNZSH=no KEEP_ZSHRC=yes \
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; then
            log_success "oh-my-zsh installed"
        else
            log_error "failed to install oh-my-zsh"
            log_info "Install manually: ZSH=~/.config/oh-my-zsh RUNZSH=no KEEP_ZSHRC=yes sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""
        fi
    fi

    # link system-installed plugins into OMZ custom plugins dir
    local omz_custom="$omz_dir/custom/plugins"
    mkdir -p "$omz_custom"

    for plugin in zsh-autosuggestions zsh-syntax-highlighting; do
        local src="/usr/share/zsh/plugins/$plugin"
        local dst="$omz_custom/$plugin"
        if [[ -d "$src" ]]; then
            ln -snf "$src" "$dst"
            log_info "linked $plugin"
        else
            log_warn "system plugin not found: $src"
        fi
    done

    # zsh-shift-select: clone from github repo
    if [[ -d "$omz_custom/zsh-shift-select" ]]; then
        log_info "zsh-shift-select already present, skipping"
    else
        log_substep "installing zsh-shift-select"
        if git clone --depth=1 https://github.com/jirutka/zsh-shift-select.git \
            "$omz_custom/zsh-shift-select" 2>/dev/null; then
            log_success "zsh-shift-select installed"
        else
            log_warn "failed to clone zsh-shift-select"
        fi
    fi
}

main "$@"
