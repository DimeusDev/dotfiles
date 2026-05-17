hl.on("hyprland.start", function()
    hl.exec_cmd("hyprlock --immediate-render")
    -- autologin ^

    hl.exec_cmd("hyprpm reload")

    hl.exec_cmd("uwsm-app -- xhost +si:localuser:root")

    hl.exec_cmd("uwsm-app -- awww-daemon")

    hl.exec_cmd("systemctl --user start hypridle")
    hl.exec_cmd("uwsm-app -- swayosd-server")

    hl.exec_cmd("uwsm-app -- wl-paste --type text --watch cliphist store")
    hl.exec_cmd("uwsm-app -- wl-paste --type image --watch cliphist store")
    hl.exec_cmd("uwsm-app -- $HOME/.local/bin/waybar_autostart.sh")

    hl.exec_cmd("systemctl --user import-environment $(env | cut -d'=' -f 1)")
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
end)
