#!/usr/bin/env bash
# shared functions for all installer modules

# colors & formatting
if [[ -t 1 ]] && command -v tput &>/dev/null; then
    if (( $(tput colors 2>/dev/null || echo 0) >= 8 )); then
        export RED=$(tput setaf 1)
        export GREEN=$(tput setaf 2)
        export YELLOW=$(tput setaf 3)
        export BLUE=$(tput setaf 4)
        export MAGENTA=$(tput setaf 5)
        export CYAN=$(tput setaf 6)
        export BOLD=$(tput bold)
        export RESET=$(tput sgr0)
    fi
fi

# fallback if tput fails
RED="${RED:-}"
GREEN="${GREEN:-}"
YELLOW="${YELLOW:-}"
BLUE="${BLUE:-}"
MAGENTA="${MAGENTA:-}"
CYAN="${CYAN:-}"
BOLD="${BOLD:-}"
RESET="${RESET:-}"

# logging

log_info() {
    printf "${BLUE}[INFO]${RESET} %s\n" "$*"
}

log_success() {
    printf "${GREEN}[OK]${RESET}   %s\n" "$*"
}

log_warn() {
    printf "${YELLOW}[WARN]${RESET} %s\n" "$*"
}

log_error() {
    printf "${RED}[ERROR]${RESET} %s\n" "$*" >&2
}

log_step() {
    printf "\n${BOLD}${CYAN}%s${RESET}\n" "$*"
}

log_substep() {
    printf "  ${MAGENTA}→${RESET} %s\n" "$*"
}

# user interaction

ask_yes_no() {
    local question="$1"
    local default="${2:-n}"
    local prompt_suffix="[y/N]"

    if [[ "$default" == "y" ]]; then
        prompt_suffix="[Y/n]"
    fi

    while true; do
        printf "${YELLOW}[?]${RESET} %s %s " "$question" "$prompt_suffix" >&2
        read -r response </dev/tty

        if [[ -z "$response" ]]; then
            response="$default"
        fi

        case "${response,,}" in
            y|yes) return 0 ;;
            n|no) return 1 ;;
            *) log_warn "Please answer yes or no" ;;
        esac
    done
}

ask_choice() {
    local question="$1"
    shift
    local options=("$@")
    local default="$1"

    # all prompts go to stderr so they stay visible when called inside $()
    printf "${YELLOW}[?]${RESET} %s\n" "$question" >&2

    local i=1
    for option in "${options[@]}"; do
        printf "  ${CYAN}%d)${RESET} %s\n" "$i" "$option" >&2
        ((++i))
    done

    while true; do
        printf "${YELLOW}Enter choice [1-%d, default=1]:${RESET} " "${#options[@]}" >&2
        read -r choice </dev/tty

        if [[ -z "$choice" ]]; then
            echo "$default"
            return 0
        fi

        if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#options[@]} )); then
            echo "${options[$((choice-1))]}"
            return 0
        fi

        log_warn "invalid choice (1-${#options[@]})" >&2
    done
}

# system detection

is_laptop() {
    # compgen expands globs; [[ -d ]] does not expand BAT*
    compgen -G "/sys/class/power_supply/BAT*" > /dev/null 2>&1 || \
    [[ -d /sys/class/power_supply/battery ]]
}

get_cpu_vendor() {
    local vendor=$(grep -m1 "vendor_id" /proc/cpuinfo | awk '{print $3}')
    echo "$vendor"
}

# package management

# global arrays to track installation results
declare -ga PKG_INSTALLED=()
declare -ga PKG_SKIPPED=()
declare -ga PKG_FAILED=()
declare -ga PKG_FAILED_REASONS=()

check_command() {
    command -v "$1" &>/dev/null
}

# check if package exists in repos
pkg_exists() {
    pacman -Si "$1" &>/dev/null
}

# check if package is already installed
pkg_installed() {
    pacman -Qi "$1" &>/dev/null
}

# install single package (one by one so script cant fail)
install_package_safe() {
    local package="$1"
    local output
    local exit_code

    if pkg_installed "$package"; then
        PKG_SKIPPED+=("$package")
        return 0
    fi

    if ! pkg_exists "$package"; then
        PKG_FAILED+=("$package")
        PKG_FAILED_REASONS+=("$package: not found in repositories")
        log_warn "Package not found: $package"
        return 0
    fi

    printf "  ${MAGENTA}→${RESET} Installing ${CYAN}%s${RESET}..." "$package"

    output=$(sudo pacman -S --noconfirm --needed "$package" 2>&1)
    exit_code=$?

    if [[ $exit_code -eq 0 ]]; then
        if echo "$output" | grep -q "is up to date"; then
            printf " ${YELLOW}already installed${RESET}\n"
            PKG_SKIPPED+=("$package")
        else
            printf " ${GREEN}done${RESET}\n"
            PKG_INSTALLED+=("$package")
        fi
        return 0
    fi

    # retry with --overwrite for split packages
    output=$(sudo pacman -S --noconfirm --needed --overwrite '*' "$package" 2>&1)
    exit_code=$?

    if [[ $exit_code -eq 0 ]]; then
        printf " ${GREEN}done${RESET} (with overwrite)\n"
        PKG_INSTALLED+=("$package")
        return 0
    fi

    local reason
    local error_detail=""

    if echo "$output" | grep -q "could not satisfy dependencies"; then
        reason="dependency conflict"
        error_detail=$(echo "$output" | grep -E "^\s*::" | head -1 | sed 's/^.*:: //' | cut -c1-100)
    elif echo "$output" | grep -q "conflicting files"; then
        reason="file conflict"
        error_detail=$(echo "$output" | grep -i "exists in filesystem" | head -1 | cut -c1-100)
    elif echo "$output" | grep -q "target not found"; then
        reason="not found in repositories"
    elif echo "$output" | grep -q "failed to retrieve"; then
        reason="download failed"
    else
        reason="installation failed"
        error_detail=$(echo "$output" | grep -iE "(error|failed)" | tail -1 | cut -c1-100)
    fi

    printf " ${RED}FAILED${RESET}\n"

    if [[ -n "$error_detail" ]]; then
        printf "    ${RED}└─${RESET} %s\n" "$error_detail"
    fi

    PKG_FAILED+=("$package")
    if [[ -n "$error_detail" ]]; then
        PKG_FAILED_REASONS+=("$package: $reason → $error_detail")
    else
        PKG_FAILED_REASONS+=("$package: $reason")
    fi

    return 0
}

# install multiple packages one by one
install_packages() {
    local packages=("$@")
    if [[ ${#packages[@]} -eq 0 ]]; then
        return 0
    fi

    log_info "installing ${#packages[@]} packages"

    for pkg in "${packages[@]}"; do
        install_package_safe "$pkg"
    done
}

# reset tracking arrays
reset_package_tracking() {
    PKG_INSTALLED=()
    PKG_SKIPPED=()
    PKG_FAILED=()
    PKG_FAILED_REASONS=()
}

# file operations

get_dir_size_mb() {
    local dir="$1"
    if [[ -d "$dir" ]]; then
        du -sm "$dir" 2>/dev/null | awk '{print $1}'
    else
        echo "0"
    fi
}

# sudo management

init_sudo() {
    log_info "requesting sudo..."
    if ! sudo -v; then
        log_error "failed to get sudo"
        exit 1
    fi

    # exits when parent dies
    local parent_pid=$$
    ( while kill -0 "$parent_pid" 2>/dev/null; do sudo -n true; sleep 55; done 2>/dev/null ) &
    export SUDO_REFRESH_PID=$!
}

cleanup_sudo() {
    if [[ -n "${SUDO_REFRESH_PID:-}" ]]; then
        kill "$SUDO_REFRESH_PID" 2>/dev/null || true
    fi
}

# multi-select package menu
multi_select() {
    local header="$1"
    shift

    if [[ ! -t 2 ]]; then
        local item
        for item in "$@"; do printf '%s\n' "${item%%:*}"; done
        return 0
    fi

    local pkgs=() descs=()
    local item
    for item in "$@"; do
        pkgs+=("${item%%:*}")
        descs+=("${item#*:}")
    done

    local n=${#pkgs[@]}
    local selected=()
    local i
    for (( i=0; i<n; i++ )); do selected+=("true"); done

    local total_lines=$(( n + 4 ))
    local first_draw=true
    local input="" token idx count=0

    while true; do
        if [[ "$first_draw" != "true" ]]; then
            printf "\033[%dF\033[J" "$total_lines" >&2
        fi
        first_draw=false

        printf "\n${BOLD}${CYAN}  %s${RESET}\n" "$header" >&2
        for (( i=0; i<n; i++ )); do
            if [[ "${selected[$i]}" == "true" ]]; then
                printf "  ${GREEN}[✓]${RESET} %2d. ${CYAN}%-28s${RESET} %s\n" \
                    "$(( i+1 ))" "${pkgs[$i]}" "${descs[$i]}" >&2
            else
                printf "  ${RED}[ ]${RESET} %2d. ${YELLOW}%-28s${RESET} %s\n" \
                    "$(( i+1 ))" "${pkgs[$i]}" "${descs[$i]}" >&2
            fi
        done
        printf "  ${YELLOW}Number(s) to toggle  |  a=all  |  n=none  |  Enter=confirm${RESET}\n" >&2
        printf "  ${BOLD}>>${RESET} " >&2
        read -r input </dev/tty

        [[ -z "$input" ]] && break

        case "$input" in
            a|A) for (( i=0; i<n; i++ )); do selected[$i]="true"; done ;;
            n|N) for (( i=0; i<n; i++ )); do selected[$i]="false"; done ;;
            *)
                for token in ${input//,/ }; do
                    if [[ "$token" =~ ^[0-9]+$ ]] && (( token >= 1 && token <= n )); then
                        idx=$(( token - 1 ))
                        if [[ "${selected[$idx]}" == "true" ]]; then
                            selected[$idx]="false"
                        else
                            selected[$idx]="true"
                        fi
                    fi
                done
                ;;
        esac
    done

    printf "\033[%dF\033[J" "$total_lines" >&2

    for (( i=0; i<n; i++ )); do
        if [[ "${selected[$i]}" == "true" ]]; then
            printf '%s\n' "${pkgs[$i]}"
            count=$(( count + 1 ))
        fi
    done

    printf "  ${GREEN}[OK]${RESET}   Supplemental: ${BOLD}%d${RESET} of ${BOLD}%d${RESET} packages selected\n" \
        "$count" "$n" >&2
}

export -f log_info log_success log_warn log_error log_step log_substep
export -f ask_yes_no ask_choice multi_select
export -f is_laptop get_cpu_vendor
export -f check_command pkg_exists pkg_installed
export -f install_package_safe install_packages
export -f reset_package_tracking
export -f get_dir_size_mb
export -f init_sudo cleanup_sudo
