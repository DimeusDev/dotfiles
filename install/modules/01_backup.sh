#!/usr/bin/env bash
# backup existing config to ~/.local/old-config/

set -euo pipefail


SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ ! -f "${SCRIPT_DIR}/../lib/common.sh" ]]; then
    echo "[01_backup.sh] ERROR: common.sh not found!" >&2
    exit 1
fi

source "${SCRIPT_DIR}/../lib/common.sh"

BACKUP_DIR="$HOME/.local/old-config"
readonly BACKUP_TIMESTAMP=$(date +%Y%m%d_%H%M%S)
readonly SIZE_LIMIT_MB=2048 # 2GB

main() {
    log_step "Configuration Backup"

    if ! check_command rsync; then
        log_error "rsync not installed"
        log_error "Install it with: sudo pacman -S rsync"
        exit 1
    fi

    mkdir -p "$BACKUP_DIR"

    log_info "backup location: $BACKUP_DIR"
    log_info "timestamp: $BACKUP_TIMESTAMP"

    if [[ -d "$BACKUP_DIR/.config" ]] || [[ -d "$BACKUP_DIR/.local" ]]; then
        log_warn "previous backup found"
        if ask_yes_no "Overwrite previous backup?" "n"; then
            log_substep "removing old backup"
            rm -rf "$BACKUP_DIR"/*
        else
            log_info "keeping existing backup, creating timestamped"
            BACKUP_DIR="$HOME/.local/old-config-$BACKUP_TIMESTAMP"
            mkdir -p "$BACKUP_DIR"
        fi
    fi

    local total_size=0
    local backed_up=0
    local skipped=0

    local -a BACKUP_ITEMS=(
        "$HOME/.config"
        "$HOME/.local/bin"
        "$HOME/.local/share/applications"
        "$HOME/.zshrc"
        "$HOME/.zprofile"
        "$HOME/.bashrc"
        "$HOME/.profile"
    )

    log_info "backing up important files"

    for item in "${BACKUP_ITEMS[@]}"; do
        if [[ ! -e "$item" ]]; then
            continue
        fi

        local item_name="$(basename "$item")"
        local rel_path="${item#$HOME/}"

        local item_size
        if [[ "$item" == *"/.config" ]]; then
            item_size=$(du -sm --exclude='cache' --exclude='Cache' --exclude='*.log' "$item" 2>/dev/null | awk '{print $1}')
            item_size="${item_size:-0}"
        else
            item_size=$(get_dir_size_mb "$item")
        fi

        if (( total_size + item_size > SIZE_LIMIT_MB )); then
            log_warn "skipping $rel_path: size limit exceeded"
            ((++skipped))
            continue
        fi

        log_substep "backing up: $rel_path (${item_size}MB)"

        local backup_path="$BACKUP_DIR/$rel_path"
        local backup_parent="$(dirname "$backup_path")"

        mkdir -p "$backup_parent"

        if [[ "$item" == *".config" ]]; then
            rsync -a --info=progress2 --exclude='cache' --exclude='Cache' --exclude='*.log' "$item/" "$backup_path/"
        else
            cp -a "$item" "$backup_path"
        fi

        echo ""

        ((++backed_up))
        total_size=$((total_size + item_size))
    done

    cat > "$BACKUP_DIR/BACKUP_INFO.txt" <<EOF
Dimeus Dotfiles backup
Date: $(date)
Timestamp: $BACKUP_TIMESTAMP
System: $(uname -a)
User: $USER
Home: $HOME

Total Size: ${total_size}MB
Items Backed Up: $backed_up
Items Skipped: $skipped
EOF

    log_success "backup complete"
    log_info "location: $BACKUP_DIR"
    log_info "total size: ${total_size}MB"
    log_info "files backed up: $backed_up"

    if (( skipped > 0 )); then
        log_warn "skipped $skipped item(s) due to size limit"
    fi

    # export backup location for other modules
    export INSTALLER_BACKUP_DIR="$BACKUP_DIR"
}

main "$@"
