#!/usr/bin/env bash
# restore config files from a previous backup

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../../lib/common.sh"

# returns all backup dirs sorted newest first
discover_backups() {
    local -a found=()

    [[ -d "$HOME/.local/old-config" ]] && found+=("$HOME/.local/old-config")

    while IFS= read -r dir; do
        found+=("$dir")
    done < <(find "$HOME/.local" -maxdepth 1 -name "old-config-*" -type d 2>/dev/null | sort -r)

    printf '%s\n' "${found[@]}"
}

# let user pick which backup to restore from
pick_backup() {
    local -a backups
    mapfile -t backups < <(discover_backups)

    if [[ ${#backups[@]} -eq 0 ]]; then
        log_error "no backups found in ~/.local/"
        return 1
    fi

    if [[ ${#backups[@]} -eq 1 ]]; then
        echo "${backups[0]}"
        return 0
    fi

    local chosen
    chosen=$(printf '%s\n' "${backups[@]}" | fzf \
        --prompt "backup > " \
        --header "select backup to restore from" \
        --no-multi)

    if [[ -z "$chosen" ]]; then
        log_info "cancelled"
        return 1
    fi

    echo "$chosen"
}

complete_restore() {
    local backup_dir="$1"

    log_warn "overwrites current config with backup contents"
    ask_yes_no "continue?" "n" || return 0

    local -a items=(".config" ".local/bin" ".local/share/applications" ".zshrc" ".zprofile")

    for item in "${items[@]}"; do
        local src="$backup_dir/$item"
        local dst="$HOME/$item"

        [[ -e "$src" ]] || continue

        log_substep "restoring: $item"
        mkdir -p "$(dirname "$dst")"

        if [[ -d "$src" ]]; then
            rsync -a --delete "$src/" "$dst/"
        else
            cp -a "$src" "$dst"
        fi
    done

    log_success "complete restore done"
}

selective_restore() {
    local backup_dir="$1"

    log_info "scanning for changed files..."

    local tmpfile
    tmpfile=$(mktemp)

    # find differing files in .config backup
    while IFS= read -r bak_file; do
        local rel="${bak_file#"$backup_dir/"}"
        local cur="$HOME/$rel"

        if [[ ! -f "$cur" ]]; then
            printf '%s\t[new]\n' "$rel"
        elif ! diff -q "$bak_file" "$cur" &>/dev/null; then
            printf '%s\t[modified]\n' "$rel"
        fi
    done < <(find "$backup_dir/.config" -type f 2>/dev/null) > "$tmpfile"

    # also check root-level files
    for item in .zshrc .zprofile .bashrc .profile; do
        local bak="$backup_dir/$item"
        local cur="$HOME/$item"
        if [[ -f "$bak" ]]; then
            if [[ ! -f "$cur" ]]; then
                printf '%s\t[new]\n' "$item"
            elif ! diff -q "$bak" "$cur" &>/dev/null; then
                printf '%s\t[modified]\n' "$item"
            fi
        fi
    done >> "$tmpfile"

    if [[ ! -s "$tmpfile" ]]; then
        log_info "no differences found between backup and current config"
        rm -f "$tmpfile"
        return 0
    fi

    log_info "use Tab to add files to your list, Enter to confirm selection"
    echo ""

    # fzf multi-select
    local raw_selection
    raw_selection=$(fzf \
        --multi \
        --prompt "file > " \
        --header "Tab = add/remove  |  Ctrl-A = select all  |  Enter = confirm list" \
        --bind "ctrl-a:select-all" \
        --with-nth 1,2 \
        < "$tmpfile")

    rm -f "$tmpfile"

    if [[ -z "$raw_selection" ]]; then
        log_info "nothing selected"
        return 0
    fi

    # extract path
    local -a selected_files
    mapfile -t selected_files < <(awk '{print $1}' <<< "$raw_selection")

    # show confirmation list
    echo ""
    printf "  ${BOLD}${CYAN}files to restore (${#selected_files[@]}):${RESET}\n"
    printf "  ${BLUE}────────────────────────────────────────${RESET}\n"
    for f in "${selected_files[@]}"; do
        printf "  ${MAGENTA}→${RESET} %s\n" "$f"
    done
    printf "  ${BLUE}────────────────────────────────────────${RESET}\n"
    echo ""

    ask_yes_no "restore these ${#selected_files[@]} file(s)?" "y" || return 0

    for rel in "${selected_files[@]}"; do
        local src="$backup_dir/$rel"
        local dst="$HOME/$rel"

        [[ -f "$src" ]] || continue

        mkdir -p "$(dirname "$dst")"
        cp -a "$src" "$dst"
        log_substep "restored: $rel"
    done

    log_success "selective restore done"
}

main() {
    log_step "Restore Backup"

    local backup_dir
    backup_dir=$(pick_backup) || return 1

    log_info "backup: $backup_dir"

    local mode
    mode=$(ask_choice "restore mode:" \
        "Selective - pick specific files" \
        "Complete - restore everything")

    case "$mode" in
        "Selective"*) selective_restore "$backup_dir" ;;
        "Complete"*)  complete_restore  "$backup_dir" ;;
    esac
}

main "$@"
