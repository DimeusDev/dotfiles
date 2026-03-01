#!/usr/bin/env bash
# robustly restart waybar for hyprland/uwsm sessions
# uses systemd-run to spawn from a clean user environment,
# avoiding XDG_ACTIVATION_TOKEN inheritance issues

set -euo pipefail

readonly APP_NAME="waybar"
readonly TIMEOUT_SEC=5

# terminal-aware colors (stderr only)
if [[ -t 2 ]]; then
    readonly C_RED=$'\033[0;31m'
    readonly C_GREEN=$'\033[0;32m'
    readonly C_BLUE=$'\033[0;34m'
    readonly C_RESET=$'\033[0m'
else
    readonly C_RED=''
    readonly C_GREEN=''
    readonly C_BLUE=''
    readonly C_RESET=''
fi

log_info()    { printf '%s[INFO]%s %s\n' "${C_BLUE}" "${C_RESET}" "$*" >&2; }
log_success() { printf '%s[OK]%s %s\n' "${C_GREEN}" "${C_RESET}" "$*" >&2; }
log_err()     { printf '%s[ERROR]%s %s\n' "${C_RED}" "${C_RESET}" "$*" >&2; }

launch_fallback() {
    log_info "fallback launch (setsid)"
    (
        unset XDG_ACTIVATION_TOKEN DESKTOP_STARTUP_ID
        setsid "${APP_NAME}" "$@" </dev/null >/dev/null 2>&1 &
    )
    log_success "${APP_NAME} launched (fallback)"
}

(( EUID != 0 )) || { log_err "do not run as root"; exit 1; }
command -v "${APP_NAME}" >/dev/null 2>&1 || { log_err "${APP_NAME} binary not found"; exit 1; }
[[ -d ${XDG_RUNTIME_DIR:-} ]] || { log_err "XDG_RUNTIME_DIR not set"; exit 1; }

readonly LOCK_FILE="${XDG_RUNTIME_DIR}/${APP_NAME}_manager.lock"

# fd 9 holds the lock until the script exits
exec 9>"${LOCK_FILE}"
flock -n 9 || { log_err "already running"; exit 1; }

log_info "managing ${APP_NAME} instances"

if pgrep -x "${APP_NAME}" >/dev/null 2>&1; then
    log_info "stopping existing instances"
    pkill -x "${APP_NAME}" >/dev/null 2>&1 || true

    for (( i = 0; i < TIMEOUT_SEC * 10; i++ )); do
        pgrep -x "${APP_NAME}" >/dev/null 2>&1 || break
        sleep 0.1
    done

    if pgrep -x "${APP_NAME}" >/dev/null 2>&1; then
        log_err "process hung, sending SIGKILL"
        pkill -9 -x "${APP_NAME}" >/dev/null 2>&1 || true
        sleep 0.2
    fi
    log_success "cleanup complete"
else
    log_info "no running instance found"
fi

log_info "starting ${APP_NAME}"

if command -v systemd-run >/dev/null 2>&1; then
    # add $$ to unit name to prevent collision on rapid re-runs
    unit_name="${APP_NAME}-mgr-${EPOCHSECONDS}-$$"

    # '--' prevents flag injection from $@
    if systemd-run --user --quiet --unit="${unit_name}" -- "${APP_NAME}" "$@" >/dev/null 2>&1; then
        log_success "${APP_NAME} launched via systemd unit: ${unit_name}"
    else
        log_err "systemd-run failed, trying fallback"
        launch_fallback "$@"
    fi
else
    launch_fallback "$@"
fi
