-- hyprland keybindings

local terminal    = "kitty"
local fileManager = "nautilus"
local browser     = "firefox"
local textEditor  = "kitty -e nvim"

-- script path
local scripts     = os.getenv("HOME") .. "/.local/bin"

-- main key
local mainMod     = "SUPER"

-- gesture var (also used for hardware key binds)
local osdclient   = "swayosd-client"

-- application launchers (using uwsm)
hl.bind(mainMod .. " + semicolon",   hl.dsp.exec_cmd("uwsm-app -- " .. terminal),   { description = "Launch Terminal" })
hl.bind(mainMod .. " + N",           hl.dsp.exec_cmd("uwsm-app -- " .. browser),    { description = "Launch Browser" })
hl.bind(mainMod .. " + E",           hl.dsp.exec_cmd("uwsm-app -- " .. fileManager),{ description = "File Manager" })
hl.bind(mainMod .. " + M",           hl.dsp.exec_cmd(textEditor),                   { description = "Open Text Editor" })

-- rofi menus (toggle_rofi.sh make them toggle on/off on key presses)
hl.bind("ALT + SPACE",               hl.dsp.exec_cmd('uwsm-app -- ' .. scripts .. '/toggle_rofi.sh rofi -show drun -theme ~/.config/rofi/minimal.rasi -run-command "uwsm app -- {cmd}"'), { description = "Launch Apps Menu" })
hl.bind("CTRL + SHIFT + SPACE",      hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/toggle_rofi.sh " .. scripts .. "/keybindings.sh"),           { description = "Show Keybinds" })
hl.bind(mainMod .. " + CTRL + SPACE",hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/toggle_rofi.sh " .. scripts .. "/emoji.sh"),                  { description = "Search Emojis" })
hl.bind(mainMod .. " + CTRL + V",    hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/toggle_rofi.sh " .. scripts .. "/icons.sh"),                  { description = "Icon Picker" })
hl.bind("CTRL + SPACE",              hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/toggle_rofi.sh " .. scripts .. "/rofi_wallpaper_selector.sh"),{ description = "Rofi Wallpaper Selector" })
hl.bind("CTRL + ALT + SPACE",        hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/toggle_rofi.sh " .. scripts .. "/refresh_wallpaper_cache.sh"),{ description = "Wallpaper Cache Refresh" })
-- hl.bind("ALT + 1",               hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/toggle_rofi.sh uuctl"), { description = "UWSM uuctl" })

-- power menu
hl.bind("ALT + SHIFT + SPACE",       hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/toggle_rofi.sh rofi -show power-menu -modi power-menu:" .. scripts .. "/powermenu.sh -theme ~/.config/rofi/newui.rasi"), { description = "Power Menu" })

-- system monitor
hl.bind("CTRL + SHIFT + escape",     hl.dsp.exec_cmd("uwsm-app -- " .. terminal .. " --class dgop -e dgop"), { description = "System Monitor" })

-- ssh manager (config in sessions.conf)
hl.bind(mainMod .. " + CTRL + S",    hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/toggle_rofi.sh " .. scripts .. "/ssh_manager.sh"), { description = "SSH/RDP Manager" })

-- system utilities

-- game mode (mostly useless xd)
hl.bind(mainMod .. " + F12", hl.dsp.submap("game"))
hl.define_submap("game", function()
    hl.bind(mainMod .. " + F12",    hl.dsp.submap("reset"))
    hl.bind(mainMod .. " + escape", hl.dsp.submap("reset"))
end)

hl.define_submap("eww-panel", function()
    hl.bind("escape", hl.dsp.exec_cmd("eww close-all && hyprctl dispatch submap reset"))
end)

-- waybar stop start
hl.bind("ALT + 9",                   hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/waybar_autostart.sh"), { description = "Start Waybar" })
hl.bind("ALT + 0",                   hl.dsp.exec_cmd("pkill waybar"),                                      { locked = true, description = "Kill Waybar" })

-- logout menu
hl.bind(mainMod .. " + escape",      hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/logout.sh"), { description = "Logout Menu" })
hl.bind("ALT + F4",                  hl.dsp.exec_cmd("wlogout"),                                 { description = "Logout Menu" })

-- hyprland reload
hl.bind("ALT + R",                   hl.dsp.exec_cmd("hyprctl reload"), { locked = true, description = "Reload Hyprland" })

-- sliders
hl.bind("ALT + H",                   hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/hyprsunset_slider.sh"), { description = "Hyprsunset Slider" })
hl.bind("ALT + V",                   hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/volume_slider.sh"),     { description = "Volume Slider" })
hl.bind("ALT + B",                   hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/brightness_slider.sh"), { description = "Brightness Slider" })

-- screenshot & clipboard

-- clipboard history
hl.bind(mainMod .. " + V",           hl.dsp.exec_cmd('pkill -x rofi || uwsm-app -- rofi -show clipboard -modes "clipboard:' .. scripts .. '/rofi_cliphist.sh" -theme ~/.config/rofi/config.rasi'), { description = "Clipboard History" })

-- color picker
hl.bind(mainMod .. " + B",           hl.dsp.exec_cmd("pkill hyprpicker || hyprpicker -a"), { description = "Color Picker" })

-- screenshots
hl.bind(mainMod .. " + S",           hl.dsp.exec_cmd("pgrep slurp || (slurp | grim -g - - | wl-copy -t image/png)"),                             { description = "Quick Screenshot" })
hl.bind("SHIFT + Print",             hl.dsp.exec_cmd('grim - | wl-copy && notify-send "Fullscreen Screenshot in Clipboard"'),                      { description = "Full Screen Quick Screenshot" })
hl.bind(mainMod .. " + SHIFT + S",   hl.dsp.exec_cmd("slurp | grim -g - - | uwsm-app -- swappy -f -"),                                           { description = "Screenshot and Annotation" })
hl.bind("Print",                     hl.dsp.exec_cmd("grim - | uwsm-app -- swappy -f -"),                                                         { description = "Fullscreen Screenshot and Annotation" })

-- OCR (gud feature)
hl.bind(mainMod .. " + T",           hl.dsp.exec_cmd("pgrep tesseract || (slurp | grim -g - - | tesseract stdin stdout -l eng | wl-copy)"), { description = "OCR Selection" })
hl.bind(mainMod .. " + SHIFT + T",   hl.dsp.exec_cmd("grim - | tesseract stdin stdout -l eng | wl-copy"),                                   { description = "OCR Fullscreen" })

-- notifications & screen lock

-- notifications
hl.bind("ALT + equal",               hl.dsp.exec_cmd("uwsm-app -- swaync-client -t"), { description = "Open Notifications" })
hl.bind("ALT + D",                   hl.dsp.exec_cmd("swaync-client -C"),             { locked = true, description = "Dismiss Notifications" })

-- lock screen
hl.bind(mainMod .. " + L",           hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/lock.sh"), { description = "Lock Screen" })

-- window management

-- window actions
hl.bind(mainMod .. " + Q",           hl.dsp.window.close(),            { description = "Close Window" })
hl.bind(mainMod .. " + F",           hl.dsp.exec_cmd(
    "if hyprctl -j activewindow | jq -e '.floating | not'; then " ..
    'hyprctl --batch "dispatch togglefloating; dispatch resizeactive exact 90% 90%; dispatch centerwindow"; ' ..
    "else hyprctl dispatch togglefloating; fi"
), { description = "Toggle Floating" })
hl.bind(mainMod .. " + SHIFT + F",   hl.dsp.window.fullscreen(),       { description = "Window Fullscreen" })
hl.bind(mainMod .. " + G",           hl.dsp.layout("togglesplit"),     { description = "Toggle Split" })

-- window switching
hl.bind(mainMod .. " + left",        hl.dsp.focus({ direction = "left"  }), { description = "Move Focus Left" })
hl.bind(mainMod .. " + right",       hl.dsp.focus({ direction = "right" }), { description = "Move Focus Right" })
hl.bind(mainMod .. " + up",          hl.dsp.focus({ direction = "up"    }), { description = "Move Focus Up" })
hl.bind(mainMod .. " + down",        hl.dsp.focus({ direction = "down"  }), { description = "Move Focus Down" })

-- window moving
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left"  }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up"    }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down"  }))

-- window resizing
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x =  30, y =   0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.resize({ x = -30, y =   0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + up",    hl.dsp.window.resize({ x =   0, y = -30, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + down",  hl.dsp.window.resize({ x =   0, y =  30, relative = true }), { repeating = true })

-- workspace management

-- switch workspaces
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }),        { description = "Workspace " .. i })
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- scroll through workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- special workspace (scratchpad)
hl.bind(mainMod .. " + code:49",         hl.dsp.workspace.toggle_special("magic"),               { description = "Toggle Special Workspace" })
hl.bind(mainMod .. " + SHIFT + code:49", hl.dsp.window.move({ workspace = "special:magic" }))

-- mouse bindings

-- move/resize windows with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- hardware keys (media, audio, brightness)

-- volume control
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd(osdclient .. " --output-volume raise"),       { locked = true, description = "Volume Up" })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd(osdclient .. " --output-volume lower"),       { locked = true, description = "Volume Down" })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd(osdclient .. " --output-volume mute-toggle"), { locked = true, description = "Toggle Mute" })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd(osdclient .. " --input-volume mute-toggle"),  { locked = true, description = "Toggle Mic Mute" })

-- brightness control
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(osdclient .. " --brightness raise"), { locked = true, description = "Brightness Up" })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(osdclient .. " --brightness lower"), { locked = true, description = "Brightness Down" })

-- media controls
hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd(osdclient .. " --playerctl play-pause"), { locked = true, description = "Play/Pause" })
hl.bind("XF86AudioNext",         hl.dsp.exec_cmd("playerctl next"),                       { locked = true, description = "Next Track" })
hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd("playerctl previous"),                   { locked = true, description = "Previous Track" })
hl.bind(mainMod .. " + P",       hl.dsp.exec_cmd(osdclient .. " --playerctl play-pause"), { locked = true, description = "Toggle Pause" })
hl.bind("ALT + P",               hl.dsp.exec_cmd(osdclient .. " --output-volume mute-toggle"), { locked = true, description = "Mute Audio" })
