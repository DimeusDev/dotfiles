#!/usr/bin/env bash
# logout menu - icon-only

readonly THEME="$HOME/.config/rofi/logout.rasi"
SHUTDOWN=''
REBOOT=''
LOCK=''
SUSPEND='󰤄'
LOGOUT='󰗽'

YES=''
NO=''

rofi_cmd() {
    rofi -dmenu -sync -theme "$THEME"
}

confirm_cmd() {
    rofi \
        -theme "$THEME" \
        -theme-str 'window  { location: center; anchor: center; width: 320px; border-radius: 20px; border: 0px; }' \
        -theme-str 'mainbox { padding: 20px; children: [ "message", "listview" ]; spacing: 12px; }' \
        -theme-str 'listview { columns: 2; lines: 1; spacing: 10px; fixed-height: false; border-radius: 12px; background-color: @surface-container-high; }' \
        -theme-str 'element  { padding: 12px 20px; border-radius: 10px; }' \
        -theme-str 'element-text { horizontal-align: 0.5; font: "JetBrainsMono Nerd Font Propo Bold 12"; }' \
        -theme-str 'textbox { horizontal-align: 0.5; }' \
        -mesg 'Are you sure?' \
        -dmenu \
        -sync
}

confirm_exit() {
    printf '%s\n%s\n' "$YES" "$NO" | confirm_cmd
}

run_rofi() {
    printf '%s\n%s\n%s\n%s\n%s\n' "$LOCK" "$SUSPEND" "$LOGOUT" "$REBOOT" "$SHUTDOWN" | rofi_cmd
}

run_cmd() {
    local selected
    selected="$(confirm_exit)"
    [[ -n "$selected" && "$selected" == "$YES" ]] || return
    case "$1" in
        --shutdown) systemctl poweroff ;;
        --reboot)   systemctl reboot ;;
        --suspend)  systemctl suspend ;;
        --logout)   uwsm stop ;;
    esac
}

chosen="$(run_rofi)"
[[ -z "$chosen" ]] && exit 0
case "$chosen" in
    "$LOCK")
        sleep 0.1
        "$HOME/.local/bin/lock.sh"
        ;;
    "$SUSPEND")
        run_cmd --suspend
        ;;
    "$LOGOUT")
        run_cmd --logout
        ;;
    "$REBOOT")
        run_cmd --reboot
        ;;
    "$SHUTDOWN")
        run_cmd --shutdown
        ;;
esac
