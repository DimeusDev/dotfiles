#!/usr/bin/env bash
# ssh/rdp connection manager for rofi
# supports ssh + rdp via remmina

set -euo pipefail

readonly SESSIONS="$HOME/.local/bin/rofi/ssh_manager/sessions.conf"
readonly ICONS="$HOME/.local/bin/rofi/ssh_manager/icons"
readonly THEME="$HOME/.config/rofi/ssh_manager.rasi"
readonly TERMINAL="${TERMINAL:-kitty}"
readonly LOG_FILE="/tmp/ssh_manager.log"

# temp
readonly MENU_FILE="/tmp/rofi_ssh_menu_$$"
readonly CHOICE_FILE="/tmp/rofi_ssh_choice_$$"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" >> "$LOG_FILE"
}

trim_var() {
  local -n _v=$1
  _v="${_v#"${_v%%[![:space:]]*}"}"
  _v="${_v%"${_v##*[![:space:]]}"}"
}

# ssh agent socket
if [ -z "${SSH_AUTH_SOCK:-}" ]; then
  if [ -n "${XDG_RUNTIME_DIR:-}" ]; then
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
  else
    export SSH_AUTH_SOCK="/run/user/$(id -u)/ssh-agent.socket"
  fi
fi

cleanup() {
  rm -f "$MENU_FILE" "$CHOICE_FILE"
}
trap cleanup EXIT

die() {
  log "ERROR: $1"
  notify-send -u critical "SSH" "$1"
  exit 1
}

check_deps() {
  local missing=()
  for cmd in rofi notify-send; do
    command -v "$cmd" &>/dev/null || missing+=("$cmd")
  done
  if [ ${#missing[@]} -gt 0 ]; then
    die "Missing dependencies: ${missing[*]}"
  fi
}

# array
declare -gA MENU_DATA

build_menu() {
  log "building menu from $SESSIONS"
  > "$MENU_FILE"

  if [ ! -f "$SESSIONS" ]; then
    die "Sessions file not found: $SESSIONS"
  fi

  local count=0

  # format: name | proto | target | auth | key_path | icon
  while IFS='|' read -r name proto target auth key_path icon; do
    [[ "$name" =~ ^[[:space:]]*# ]] && continue
    trim_var name
    [[ -z "$name" ]] && continue

    trim_var proto; trim_var target; trim_var auth; trim_var key_path; trim_var icon

    # defaults
    auth="${auth:-password}"
    key_path="${key_path:-}"
    [[ -z "$key_path" ]] && key_path="-"

    if [[ "$auth" == "key" ]]; then
      local expanded_key="${key_path/#\~/$HOME}"
      if [[ "$expanded_key" == "-" || -z "$expanded_key" ]]; then
        log "auth=key but no key_path for '$name', using password"
        auth="password"
        key_path="-"
      fi
    fi

    # icon
    local icon_suffix=""
    local icon_path="$ICONS/$icon.png"
    if [ -f "$icon_path" ]; then
      icon_suffix="\0icon\x1f${icon_path}"
    else
      log "no icon for '$name'"
    fi

    local auth_badge
    if [[ "$auth" == "key" ]]; then
      auth_badge="󰌋 key"
    else
      auth_badge=" password"
    fi

    MENU_DATA["$name"]="$proto|$target|$auth|$key_path"

    printf "%s&#10;<span size='small'>%s · %s · %s</span>${icon_suffix}\n" \
      "$name" "$proto" "$target" "$auth_badge" >> "$MENU_FILE"

    count=$((count + 1))
  done < "$SESSIONS"

  log "loaded $count connection(s)"

  if [ ! -s "$MENU_FILE" ]; then
    die "No valid sessions found in $SESSIONS"
  fi
}

show_menu() {
  rofi -dmenu \
    -i \
    -markup-rows \
    -show-icons \
    -p "  Connect" \
    -theme "$THEME" \
    -format "s" \
    < "$MENU_FILE" > "$CHOICE_FILE" || return 1

  if [ ! -s "$CHOICE_FILE" ]; then
    return 1
  fi
  return 0
}

parse_selection() {
  local choice
  choice=$(<"$CHOICE_FILE")

  local name
  name=$(echo "$choice" | sed 's/&#10;.*//;s/<[^>]*>//g')
  trim_var name

  local info="${MENU_DATA[$name]:-}"
  if [ -z "$info" ]; then
    die "Could not find session: '$name'"
  fi

  # split
  local proto="${info%%|*}";    local rest="${info#*|}"
  local target="${rest%%|*}";   rest="${rest#*|}"
  local auth="${rest%%|*}"
  local key_path="${rest#*|}"

  printf '%s\n' "$proto" "$target" "$auth" "$key_path"
}

connect_ssh() {
  local target="$1"
  local auth="$2"
  local key_path="$3"

  local ssh_id_flag=""
  if [[ "$auth" == "key" && "$key_path" != "-" && -n "$key_path" ]]; then
    local expanded_key="${key_path/#\~/$HOME}"
    if [[ ! -f "$expanded_key" ]]; then
      die "SSH key not found: $expanded_key"
    fi
    ssh_id_flag="-i \"$expanded_key\""
    log "Using key auth: $expanded_key"
  else
    log "Using password auth for $target"
  fi

  # write a temp connect script
  local temp_script="/tmp/ssh_connect_$$.sh"
  cat > "$temp_script" << EOF
#!/bin/bash
export SSH_AUTH_SOCK="${SSH_AUTH_SOCK:-}"
echo "Connecting to $target..."
echo ""
ssh $ssh_id_flag "$target"
exit_code=\$?
echo ""
if [ \$exit_code -eq 0 ]; then
  echo "Connection closed."
else
  echo "Connection failed (exit code \$exit_code)"
fi
echo ""
echo "Press Enter to close..."
read -r
rm -f "$temp_script"
EOF
  chmod +x "$temp_script"

  if command -v uwsm-app &>/dev/null; then
    uwsm-app -- "$TERMINAL" --detach --class ssh-session -e "$temp_script" &
  else
    "$TERMINAL" --detach --class ssh-session -e "$temp_script" &
  fi
}

connect_rdp() {
  local target="$1"

  if ! command -v remmina &>/dev/null; then
    die "remmina not installed"
  fi

  local rdp_host
  if [[ "$target" =~ @ ]]; then
    rdp_host="${target#*@}"
  else
    rdp_host="$target"
  fi

  local rdp_host_clean="${rdp_host//./-}"

  local profile
  profile=$(find "$HOME/.local/share/remmina" \
    -name "*${rdp_host_clean}*.remmina" -type f 2>/dev/null | head -1)

  if [ -n "$profile" ]; then
    notify-send -u low -t 2000 "RDP" "connecting to $rdp_host"
    remmina -c "$profile" &
  else
    notify-send -u low -t 2000 "RDP" "connecting to $rdp_host"
    if [[ "$target" =~ @ ]]; then
      remmina -c "rdp://${target%@*}@${rdp_host}" &
    else
      remmina -c "rdp://${target}" &
    fi
  fi
}

main() {
  log "started"

  check_deps
  build_menu

  if ! show_menu; then
    log "Cancelled by user"
    exit 0
  fi

  local -a conn_info
  mapfile -t conn_info < <(parse_selection)

  local proto="${conn_info[0]}"
  local target="${conn_info[1]}"
  local auth="${conn_info[2]:-password}"
  local key_path="${conn_info[3]:--}"

  log "protocol=$proto target=$target auth=$auth"

  if [ -z "$proto" ] || [ -z "$target" ]; then
    die "Failed to parse connection details"
  fi

  case "$proto" in
    ssh) connect_ssh "$target" "$auth" "$key_path" ;;
    rdp) connect_rdp "$target" ;;
    *)   die "Unknown protocol: $proto" ;;
  esac

  log "finished"
}

main "$@"
