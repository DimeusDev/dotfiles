-- Hyprland main configuration
local home = os.getenv("HOME")
local function source(file)
    dofile(home .. "/.config/hypr/" .. file)
end

-- monitors
source("source/monitors.lua")

-- programs & environment
source("source/environment_variables.lua")

-- plugins (if any)
source("source/plugins.lua")

-- input devices
source("source/input.lua")

-- appearance
source("source/appearance.lua")

-- window rules & workspaces
source("source/window_rules.lua")

-- keybindings
source("source/keybinds.lua")

-- autostart
source("source/autostart.lua")

-- power mode override
source("source/power_mode.lua")

-- personal stuffs you can remove:
hl.device({
    name    = "wacom-hid-517d-finger",
    enabled = false,
})

hl.device({
    name    = "wacom-hid-517d-pen",
    enabled = false,
})
