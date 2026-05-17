-- keyboard & language
hl.config({
    input = {
        kb_layout = "us",

        kb_options = "",

        resolve_binds_by_sym = false,
        numlock_by_default   = true,

        repeat_rate  = 35,
        repeat_delay = 250,

        -- mouse & pointer acceleration
        follow_mouse = 1,
        sensitivity  = 0,

        accel_profile = "flat",

        --raw input
        force_no_accel = false,

        left_handed  = false,
        mouse_refocus = true,

        -- scrolling
        natural_scroll = false,

        -- for trackpad
        scroll_method = "2fg",

        -- touchpad
        touchpad = {
            natural_scroll      = true,
            disable_while_typing = true,
            tap_to_click        = true,
            clickfinger_behavior = false,
            drag_lock           = false,
        },
    },

    -- cursor
    cursor = {
        sync_gsettings_theme     = true,
        no_hardware_cursors      = 2,
        use_cpu_buffer           = 2,
        -- hide the cursor when typing
        hide_on_key_press        = false,
        -- hide cursor after time (0=never)
        inactive_timeout         = 0,
        warp_on_change_workspace = 0,
        no_break_fs_vrr          = 2,
        zoom_factor              = 1.0,
    },

    gestures = {
        workspace_swipe_distance     = 300,
        workspace_swipe_cancel_ratio = 0.5,
        workspace_swipe_invert       = true,
        workspace_swipe_create_new   = true,
        workspace_swipe_forever      = false,
    },
})

-- gesture var
local osdclient = "swayosd-client"

-- 3-finger up swipe -> hyprexpo-toggle
hl.gesture({ fingers = 3, direction = "up",       action = function() hl.exec_cmd("hyprctl dispatch hyprexpo:expo toggle") end })
-- 3-finger left swipe -> swaync panal
hl.gesture({ fingers = 3, direction = "left",     action = function() hl.exec_cmd("swaync-client -t") end })

-- 3-finger down/right swipe -> mute/pause-play
hl.gesture({ fingers = 3, direction = "down",     action = function() hl.exec_cmd(osdclient .. " --output-volume mute-toggle") end })
hl.gesture({ fingers = 3, direction = "right",    action = function() hl.exec_cmd(osdclient .. " --playerctl play-pause") end })

-- 4-finger horizontal swipe -> brightness change
hl.gesture({ fingers = 4, direction = "left",     action = function() hl.exec_cmd(osdclient .. " --brightness -10") end })
hl.gesture({ fingers = 4, direction = "right",    action = function() hl.exec_cmd(osdclient .. " --brightness +10") end })

-- 4-finger vertical swipe -> volume change
hl.gesture({ fingers = 4, direction = "up",       action = function() hl.exec_cmd(osdclient .. " --output-volume +10 --max-volume 95") end })
hl.gesture({ fingers = 4, direction = "down",     action = function() hl.exec_cmd(osdclient .. " --output-volume -10 --max-volume 95") end })

-- 3-finger pinch in -> Lock screen
hl.gesture({ fingers = 3, direction = "pinchout", action = function() hl.exec_cmd("hyprlock --immediate") end })
-- 3-finger pinch out -> screenshot
hl.gesture({ fingers = 3, direction = "pinchin",  action = function() hl.exec_cmd("slurp | grim -g - - | swappy -f -") end })
-- 2-finger pinch out -> screenshot
hl.gesture({ fingers = 4, direction = "pinchout", action = function() hl.exec_cmd("swaync-client -t") end })
