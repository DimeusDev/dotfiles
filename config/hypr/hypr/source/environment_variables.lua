-- HYPRLAND SPECIFIC VARIABLES ARE TO BE SET IN ~/.config/uwsm/env-hyprland
-- and compositor indifferent variables in ~/.config/uwsm/env

-- Environment variables for Hyprland
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("__GL_MaxFramesAllowed", "1")

-- Cursor theme (used by XWayland / legacy apps)
hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("XCURSOR_SIZE", "18")
