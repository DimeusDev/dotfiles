local home   = os.getenv("HOME")
local colors = dofile(home .. "/.config/hypr/source/hyprland-colors.lua")

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})

hl.window_rule({
    name  = "hyprsunset_slider.sh",
    match = { title = "^(Hyprsunset)$" },
    float = true,
    pin   = true,
    move  = "(monitor_w/2-210) (monitor_h/2-220)",
    size  = "420 120",
})

hl.window_rule({
    name  = "brightness_slider.sh",
    match = { title = "^(Brightness)$" },
    float = true,
    pin   = true,
    move  = "(monitor_w/2-210) (monitor_h/2-60)",
    size  = "420 120",
})

hl.window_rule({
    name  = "volume_slider.sh",
    match = { title = "^(Volume)$" },
    float = true,
    pin   = true,
    move  = "(monitor_w/2-210) (monitor_h/2+100)",
    size  = "420 120",
})

hl.window_rule({
    name  = "float-firefox-about",
    match = { title = "^(About Mozilla Firefox)$" },
    float = true,
})

hl.window_rule({
    name  = "float-firefox-library",
    match = { class = "^(firefox)$", title = "^(Library)$" },
    float = true,
})

hl.window_rule({
    name    = "opaque-browsers-youtube",
    match   = { class = "^(firefox|zen|helium-browser)$", title = ".*YouTube.*" },
    opaque  = true,
    no_dim  = true,
})

hl.window_rule({
    name   = "opaque-firefox-figma",
    match  = { class = "^(firefox)$", title = ".*Figma.*" },
    opaque = true,
})

hl.window_rule({
    name   = "opaque-firefox-pixabay",
    match  = { class = "^(firefox)$", title = ".*Pixabay.*" },
    opaque = true,
})

hl.window_rule({
    name   = "float-mpv",
    match  = { class = "^(mpv)$" },
    float  = true,
    opaque = true,
    size   = "640 360",
    center = true,
})

hl.window_rule({
    name   = "float_qbittorrent_all",
    match  = { class = "^(org.qbittorrent.qBittorrent)$" },
    float  = true,
    center = true,
    size   = "650 450",
})

hl.window_rule({
    name  = "tile_qbittorrent_main",
    match = { class = "^(org.qbittorrent.qBittorrent)$", title = "^(qBittorrent v).*$" },
    float = false,
})

-- games and game launchers

hl.window_rule({
    name  = "PrismLauncher",
    match = { class = "org.prismlauncher.PrismLauncher" },
    float = true,
})

hl.window_rule({
    name   = "Minecraft",
    match  = { class = "com.mojang.minecraft.java-edition" },
    opaque = true,
})

hl.window_rule({
    name   = "Tetr.io",
    match  = { class = "tetrio-desktop" },
    opaque = true,
})

hl.window_rule({
    name   = "SuperTuxKart",
    match  = { class = "supertuxkart" },
    opaque = true,
})

hl.window_rule({
    name   = "ROBLOX",
    match  = { class = "org.vinegarhq.Sober" },
    opaque = true,
})

hl.window_rule({
    name   = "steam-general",
    match  = { class = "^(steam)$" },
    float  = true,
    opaque = true,
})

hl.window_rule({
    name   = "steam-main-window",
    match  = { class = "^(steam)$", title = "^(Steam)$" },
    size   = "1100 600",
    center = true,
})

hl.window_rule({
    name = "steam-friends",
    match = { class = "^(steam)$", title = "^(Friends List)$" },
    size  = "460 580",
})

hl.window_rule({
    name          = "steam-idle",
    match         = { class = "^(steam)$" },
    idle_inhibit  = "fullscreen",
})

hl.window_rule({
    name  = "showmethekey-floating",
    match = { class = "^(showmethekey-gtk)$", title = "^(Floating Window - Show Me The Key)$" },
    float = true,
    pin   = true,
    size  = "470 50",
    move  = "((monitor_w-window_w)/2) (monitor_h-window_h-20)",
    no_dim      = true,
    border_size = 0,
    opaque      = true,
})

hl.window_rule({
    name   = "uGet",
    match  = { title = "^(uGet)$" },
    float  = true,
    size   = "889 505",
    center = true,
})

hl.window_rule({
    name   = "float-calculator",
    match  = { class = "^(org.gnome.Calculator)$" },
    float  = true,
    size   = "360 616",
    center = true,
})

hl.window_rule({
    name   = "gnome-camera",
    match  = { class = "^(org.gnome.Snapshot)$" },
    float  = true,
    size   = "528 298",
    center = true,
})

hl.window_rule({
    name   = "float-cameractrls-viewfinder",
    match  = { class = "^(hu.irl.cameractrls)$", title = "^(/dev/.*)$" },
    float  = true,
    size   = "624 353",
    center = true,
})

hl.window_rule({
    name   = "float-loupe",
    match  = { class = "^(org.gnome.Loupe)$" },
    float  = true,
    size   = "900 600",
    center = true,
    opaque = true,
})

hl.window_rule({
    name   = "float-clocks",
    match  = { class = "^(org.gnome.clocks)$" },
    float  = true,
    size   = "602 297",
    center = true,
})

hl.window_rule({
    name   = "gparted",
    match  = { class = "^(GParted)$" },
    float  = true,
    size   = "652 431",
    center = true,
})

hl.window_rule({
    name   = "grsync",
    match  = { class = "^(grsync)$" },
    float  = true,
    size   = "650 458",
    center = true,
})

hl.window_rule({
    name   = "float-blueman",
    match  = { class = "^(blueman-manager)$" },
    float  = true,
    size   = "530 313",
    center = true,
})

hl.window_rule({
    name   = "handbrake",
    match  = { class = "^(fr.handbrake.ghb)$" },
    float  = true,
    size   = "970 698",
    center = true,
})

hl.window_rule({
    name   = "seahorse",
    match  = { class = "^(org.gnome.seahorse.Application)$" },
    float  = true,
    size   = "827 632",
    center = true,
})

hl.window_rule({
    name   = "bluetui",
    match  = { class = "^(bluetui)$" },
    float  = true,
    size   = "551 362",
    center = true,
})

hl.window_rule({
    name   = "airmon_ng",
    match  = { class = "^(airmon_ng.sh)$" },
    float  = true,
    size   = "775 450",
    center = true,
})

hl.window_rule({
    name   = "iphone_vnc.sh",
    match  = { class = "^(iphone_vnc.sh)$" },
    float  = true,
    size   = "650 423",
    center = true,
})

hl.window_rule({
    name   = "btrfs_zstd_compression_stats.sh",
    match  = { class = "^(btrfs_zstd_compression_stats.sh)$" },
    float  = true,
    size   = "650 423",
    center = true,
})

hl.window_rule({
    name   = "tailscale_setup",
    match  = { class = "^(tailscale_setup)$" },
    float  = true,
    size   = "775 450",
    center = true,
})

hl.window_rule({
    name   = "tailscale_uninstall",
    match  = { class = "^(tailscale_uninstall)$" },
    float  = true,
    size   = "775 450",
    center = true,
})

hl.window_rule({
    name   = "kew",
    match  = { class = "^(kew)$" },
    float  = true,
    size   = "652 576",
    center = true,
})

hl.window_rule({
    name   = "file_manager_switcher",
    match  = { class = "^(file_manager_switch.sh)$" },
    float  = true,
    size   = "652 576",
    center = true,
})

hl.window_rule({
    name   = "ftp_setup_arch.sh",
    match  = { class = "^(ftp_setup_arch.sh)$" },
    float  = true,
    size   = "652 576",
    center = true,
})

hl.window_rule({
    name   = "change_ftp_directory_server.sh",
    match  = { class = "^(change_ftp_directory_server.sh)$" },
    float  = true,
    size   = "652 576",
    center = true,
})

hl.window_rule({
    name   = "arp_scan.sh",
    match  = { class = "^(arp_scan.sh)$" },
    float  = true,
    size   = "652 576",
    center = true,
})

hl.window_rule({
    name   = "02_openssh_setup.sh",
    match  = { class = "^(02_openssh_setup.sh)$" },
    float  = true,
    size   = "652 576",
    center = true,
})

hl.window_rule({
    name   = "clipboard_persistance",
    match  = { class = "^(clipboard_persistance.sh)$" },
    float  = true,
    size   = "589 529",
    center = true,
})

hl.window_rule({
    name   = "cache_purge",
    match  = { class = "^(cache_purge.sh)$" },
    float  = true,
    size   = "589 529",
    center = true,
})

hl.window_rule({
    name   = "mouse_button_reverse",
    match  = { class = "^(mouse_button_reverse.sh)$" },
    float  = true,
    size   = "589 529",
    center = true,
})

hl.window_rule({
    name   = "new_github_repo",
    match  = { class = "^(new_github_repo_to_backup.sh)$" },
    float  = true,
    size   = "726 689",
    center = true,
})

hl.window_rule({
    name   = "relink_github_repo",
    match  = { class = "^(reconnect_and_push_new_changes_to_github.sh)$" },
    float  = true,
    size   = "726 689",
    center = true,
})

hl.window_rule({
    name   = "io_monitor.sh",
    match  = { class = "^(io_monitor.sh)$" },
    float  = true,
    size   = "943 247",
    center = true,
})

hl.window_rule({
    name     = "terminal_clipboard",
    match    = { class = "^(terminal_clipboard.sh)$" },
    float    = true,
    no_anim  = true,
    size     = "680 460",
    center   = true,
})

hl.window_rule({
    name   = "asusctl.sh",
    match  = { class = "^(asusctl.sh)$" },
    float  = true,
    size   = "730 454",
    center = true,
})

hl.window_rule({
    name   = "fastfetch",
    match  = { class = "^(fastfetch)$" },
    float  = true,
    size   = "943 393",
    center = true,
})

hl.window_rule({
    name   = "dysk",
    match  = { class = "^(dysk)$" },
    float  = true,
    size   = "1005 298",
    center = true,
})

hl.window_rule({
    name   = "performance.sh",
    match  = { class = "^(performance.sh)$" },
    float  = true,
    size   = "566 569",
    center = true,
})

hl.window_rule({
    name   = "kokoro",
    match  = { class = "^(kokoro)$" },
    float  = true,
    pin    = true,
    size   = "254 90",
    move   = "(monitor_w-window_w-8) (monitor_h-window_h-8)",
    no_dim = true,
    opaque = true,
})

hl.window_rule({
    name   = "peaclock",
    match  = { class = "^(peaclock)$" },
    float  = true,
    center = true,
    size   = "406 179",
})

hl.window_rule({
    name   = "wifitui_float",
    match  = { class = "^(wifitui)$" },
    float  = true,
    size   = "511 323",
    center = true,
})

hl.window_rule({
    name   = "nmcli_wifi",
    match  = { class = "^(nmcli_wifi.sh)$" },
    float  = true,
    size   = "639 495",
    center = true,
})

hl.window_rule({
    name   = "tray-tui",
    match  = { class = "^(tray-tui)$" },
    float  = true,
    size   = "791 488",
    center = true,
})

hl.window_rule({
    name   = "cava",
    match  = { class = "^(cava)$" },
    float  = true,
    size   = "1000 280",
    center = true,
})

hl.window_rule({
    name   = "tty-clock",
    match  = { class = "^(tty-clock)$" },
    float  = true,
    size   = "410 160",
    center = true,
})

hl.window_rule({
    name   = "lyrics",
    match  = { class = "^(lyrics)$" },
    float  = true,
    size   = "1285 535",
    center = true,
})

hl.window_rule({
    name   = "lavat",
    match  = { class = "^(lavat)$" },
    float  = true,
    size   = "580 710",
    center = true,
})

hl.window_rule({
    name   = "rmpc",
    match  = { class = "^(rmpc)$" },
    float  = true,
    size   = "860 460",
    center = true,
})

hl.window_rule({
    name   = "htop",
    match  = { class = "^(htop)$" },
    float  = true,
    size   = "1080 607",
    center = true,
})

hl.window_rule({
    name   = "dgop",
    match  = { class = "^(dgop)$" },
    float  = true,
    size   = "1080 607",
    center = true,
})

hl.window_rule({
    name   = "btop",
    match  = { class = "^(btop)$" },
    float  = true,
    size   = "1080 607",
    center = true,
})

hl.window_rule({
    name   = "nvim",
    match  = { class = "^(nvim)$" },
    float  = true,
    size   = "455 549",
    center = true,
})

hl.window_rule({
    name   = "org.gnome.TextEditor",
    match  = { class = "^(org.gnome.TextEditor)$" },
    float  = true,
    size   = "(monitor_w*0.65) (monitor_h*0.92)",
    move   = "(monitor_w*0.05) (monitor_h*0.05)",
    center = true,
})

hl.window_rule({
    name   = "errands",
    match  = { title = "^(Errands)$" },
    float  = true,
    size   = "519 614",
    center = true,
})

hl.window_rule({
    name   = "disks",
    match  = { title = "^(Disks)$", class = "^(org.gnome.DiskUtility)$" },
    float  = true,
    size   = "890 512",
    center = true,
})

hl.window_rule({
    name   = "baobab",
    match  = { class = "^(org.gnome.baobab)$" },
    float  = true,
    size   = "1152 648",
    center = true,
})

hl.window_rule({
    name  = "float_thunar_rename",
    match = { class = "Thunar", title = "^Rename.*$" },
    float = true,
})

hl.window_rule({
    name   = "sysbench_benchmark.sh",
    match  = { class = "^(sysbench_benchmark.sh)$" },
    float  = true,
    size   = "567 658",
    center = true,
})

hl.window_rule({
    name   = "ntfs_fix.sh",
    match  = { class = "^(ntfs_fix.sh)$" },
    float  = true,
    size   = "766 485",
    center = true,
})

hl.window_rule({
    name   = "power_saver.sh",
    match  = { class = "^(power_saver.sh)$" },
    float  = true,
    size   = "568 456",
    center = true,
})

hl.window_rule({
    name   = "power_saver_off.sh",
    match  = { class = "^(power_saver_off.sh)$" },
    float  = true,
    size   = "568 456",
    center = true,
})

hl.window_rule({
    name   = "009_aur_paru_fallback_yay.sh",
    match  = { class = "^(009_aur_paru_fallback_yay.sh)$" },
    float  = true,
    size   = "567 658",
    center = true,
})

hl.window_rule({
    name  = "ORCHESTRA.sh",
    match = { class = "^(ORCHESTRA.sh)$" },
    float = true,
    size  = "(monitor_w*0.9) (monitor_h*0.9)",
    move  = "(monitor_w*0.05) (monitor_h*0.05)",
})

hl.window_rule({
    name  = "deploy_dotfiles.sh",
    match = { class = "^(deploy_dotfiles.sh)$" },
    float = true,
    size  = "(monitor_w*0.9) (monitor_h*0.9)",
    move  = "(monitor_w*0.05) (monitor_h*0.05)",
})

hl.window_rule({
    name   = "restore_stash.sh",
    match  = { class = "^(restore_stash.sh)$" },
    float  = true,
    size   = "1192 710",
    center = true,
})

hl.window_rule({
    name   = "send_logs.sh",
    match  = { class = "^(send_logs.sh)$" },
    float  = true,
    size   = "500 250",
    center = true,
})

hl.window_rule({
    name      = "ollama_terminal.sh",
    match     = { class = "^(ollama_terminal.sh)$" },
    float     = true,
    size      = "(monitor_w*0.28) (monitor_h*0.88)",
    animation = "slide left",
    rounding  = 9,
    move      = "(monitor_w*0.038) (monitor_h*0.5 - window_h*0.5)",
})

hl.window_rule({
    name   = "music_recognition.sh",
    match  = { class = "^(music_recognition.sh)$" },
    float  = true,
    size   = "409 147",
    center = true,
})

hl.window_rule({
    name   = "float-zathura",
    match  = { class = "^(org.pwmt.zathura)$" },
    float  = true,
    size   = "655 526",
    center = true,
})

hl.window_rule({
    name   = "float-waypaper",
    match  = { class = "^(waypaper)$" },
    float  = true,
    size   = "786 492",
    center = true,
})

hl.window_rule({
    name   = "float-share-picker",
    match  = { class = "^(hyprland-share-picker)$" },
    float  = true,
    size   = "500 300",
    center = true,
})

hl.window_rule({
    name   = "float-nwg-look",
    match  = { class = "^(nwg-look)$" },
    float  = true,
    size   = "627 464",
    center = true,
})

hl.window_rule({
    name   = "float-kvantum",
    match  = { class = "^(kvantummanager)$" },
    float  = true,
    size   = "585 512",
    center = true,
})

hl.window_rule({
    name   = "float-qt6ct",
    match  = { class = "^(qt6ct)$" },
    float  = true,
    size   = "700 609",
    center = true,
})

hl.window_rule({
    name   = "float-qt5ct",
    match  = { class = "^(qt5ct)$" },
    float  = true,
    size   = "636 665",
    center = true,
})

hl.window_rule({
    name   = "float-guifetch",
    match  = { class = "^(guifetch)$" },
    float  = true,
    size   = "800 500",
    center = true,
})

hl.window_rule({
    name   = "float-pavucontrol",
    match  = { class = "^(pavucontrol|org.pulseaudio.pavucontrol)$" },
    float  = true,
    size   = "643 422",
    center = true,
})

hl.window_rule({
    name   = "float-nm-editor",
    match  = { class = "^(nm-connection-editor)$" },
    float  = true,
    size   = "432 423",
    center = true,
})

hl.window_rule({
    name   = "float_vm_viewer",
    match  = { class = "^(virt-manager)$", title = "^(.* on QEMU/KVM)$" },
    float  = true,
    center = true,
    size   = "1043 634",
})

hl.window_rule({
    name  = "pip-global",
    match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" },

    -- set state
    float = true,
    pin   = true,

    -- set size first (approx 360p)
    size = "248 140",

    -- move to bottom-right
    move = "(monitor_w-window_w-20) (monitor_h-window_h-20)",

    -- visuals
    no_dim = true,
    opaque = true,
})

hl.window_rule({
    name  = "style-pinned-windows",
    match = { pin = true },

    -- prevent dimming
    no_dim = true,

    -- visual distinction (green border)
    border_color = "rgb(328E6E)",

    -- thicker border
    border_size = 5,
})

-- floating windows remember their size when reopened.
hl.window_rule({
    name            = "global-persistent-size",
    match           = { float = true },
    persistent_size = true,
})

-- forces app to use tiling
hl.window_rule({
    name           = "global-suppress-maximize",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

-- xwayland / phantom window fixes
hl.window_rule({
    name  = "fix-xwayland-phantom",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- fullscreen styling
hl.window_rule({
    name  = "style-fullscreen",
    match = { fullscreen = true },

    border_color = "rgb(E2971F)",
    border_size  = 4,
    rounding     = 0,
})

-- floats windows
hl.window_rule({
    name  = "float-dialogs-title",

    -- regex logic to find dialogs
    match = { title = "^(Open|Open File|Select a File|Choose wallpaper|Open Folder|Save As|Library|File Upload|Authentication Required|Add Folder to Workspace|Choose Files|Confirm to replace files|File Operation Progress)(.*)$|^(.*dialog.*)$" },

    float  = true,
    center = true,
    size   = "816 537",
})

-- floats windows
hl.window_rule({
    name  = "float-dialogs-class",
    match = { class = "^(org.gnome.FileRoller|[Xx]dg-desktop-portal-gtk|.*dialog.*)$" },
    float  = true,
    center = true,
    size   = "816 537",
})

-- swaync rule
hl.layer_rule({
    name      = "swaync_slide",
    match     = { namespace = "swaync-control-center" },
    animation = "slide right",
    dim_around = true,
    blur       = true,
    ignore_alpha = 0.6,
})

-- notification popups
hl.layer_rule({
    name         = "swaync_notifications",
    match        = { namespace = "swaync-notification-window" },
    blur         = true,
    ignore_alpha = 0.8,
})

-- eww control panel
hl.layer_rule({
    name         = "eww_control_panel",
    match        = { namespace = "eww-control-panel" },
    animation    = "slide right",
    blur         = true,
    ignore_alpha = 0.2,
})

-- rofi rule
hl.layer_rule({
    name  = "rofi",
    match = { namespace = "rofi" },
    -- animation = "slide down",
    -- dim_around = true,
})

-- wlogout
hl.layer_rule({
    name         = "logout_dialog_style",
    match        = { namespace = "logout_dialog" },
    blur         = true,
    ignore_alpha = 0.0,
})

-- selection for screenshot
hl.layer_rule({
    name    = "selection_white menu",
    match   = { namespace = "selection" },
    blur    = false,
    no_anim = true,
})

-- waybar
-- hl.layer_rule({
--     name  = "waybar_blur",
--     match = { namespace = "waybar" },
--     blur = true,
--     xray = true,
-- })

-- special workspaces
hl.workspace_rule({ workspace = "special:magic", gaps_out = 20, gaps_in = 6 })

hl.window_rule({
    name         = "style-magic-workspace",
    match        = { workspace = "special:magic" },
    border_color = colors.primary,
    border_size  = 1,
})

-- background apps open in foreground when fullscreened
hl.config({
    misc = {
        on_focus_under_fullscreen  = 2,
        initial_workspace_tracking = 2,
        focus_on_activate          = true,
    },
})

-- file chooser
hl.window_rule({
    name  = "float-file-chooser",
    match = { title = "^(Open|Open File|Open Files|Open Folder|Save|Save As|Choose File|Choose Files|Choose a File|Select File)(.*)$" },
    float  = true,
    center = true,
})

-- nautilus
hl.window_rule({
    name  = "float-nautilus-properties",
    match = { class = "^(org.gnome.Nautilus)$", title = "^(Properties)$" },
    float  = true,
    center = true,
})

hl.window_rule({
    name  = "float-nautilus-dialogs",
    match = { class = "^(org.gnome.Nautilus)$", title = "^(Move|Rename|Copy|Compress|Extract)(.*)$" },
    float  = true,
    center = true,
})

-- gtk alerts etc
hl.window_rule({
    name  = "float-gtk-dialogs",
    match = { class = "^(GtkDialog|gtk_dialog)$" },
    float  = true,
    center = true,
})

-- xdgportal file browser
hl.window_rule({
    name  = "float-xdg-portal",
    match = { class = "^(xdg-desktop-portal-gtk)$" },
    float  = true,
    center = true,
})

-- always transparent windows
hl.window_rule({
    name    = "always-transparent",
    match   = { class = "^(kitty|cava|rmpc|lavat|lyrics|tty-clock|org.gnome.Nautilus)$" },
    opacity = "0.75 0.75",
})

hl.window_rule({
    name         = "zen_browser",
    match        = { class = "^(zen)$" },
    border_color = "rgba(ffffff20)",
    no_shadow    = true,
})
