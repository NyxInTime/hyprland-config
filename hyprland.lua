-- Hyprland Lua config
-- Translated from hyprland.conf
-- Refer to the wiki for more information: https://wiki.hypr.land/Configuring/Start/

-- Split your config into separate files and require them:
-- require("keybinds")
-- require("animations")


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "auto-down",
    scale    = 1,
})

-- Generic 2nd screen forced above. Replace output with a specific name to target one screen.
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto-up",
    scale    = 1,
})

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@144",
    position = "auto-right",
    scale    = 1,
})


---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty"
local fileManager = "thunar"
local menu        = "pkill rofi || rofi -show drun -replace -i"


-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
    hl.exec_cmd("qs")
    hl.exec_cmd("hypridle & systemctl --user start hyprpolkitagent")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("spotify & discord")
    hl.exec_cmd("hyprpaper")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
-- GPU fixes for better behaviour
hl.env("AQ_DRM_DEVICES", "/dev/dri/by-path/pci-0000:05:00.0-card")
hl.env("MESA_VK_DEVICE_SELECT", "1002:1900")


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general    = {
        gaps_in          = 5,
        gaps_out         = 10,

        border_size      = 2,

        col              = {
            active_border   = { colors = { "rgba(9000d9ff)", "rgba(c900b8ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = true,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding         = 10,
        rounding_power   = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow           = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },

        blur             = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
        --[[
        wobble           = {
            enabled = true,
            mesh = 32,
            stiffness = 0.0001,
            intensity = 2,
        }
        ]]
    },

    animations = {
        enabled = true,
    },
})

-- Animations are in a separate file — require("animations") once translated.

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
hl.config({
    dwindle = {
        preserve_split = true,
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/
hl.config({
    master = {
        new_status = "master",
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = 0, -- 0 disables anime mascot
        disable_hyprland_logo   = true,
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout    = "us, ca",
        kb_variant   = "",
        kb_model     = "",
        kb_options   = "grp:win_space_toggle",
        kb_rules     = "",

        follow_mouse = 1,
        sensitivity  = 0,

        touchpad     = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

hl.device({
    name = "logitech-wireless-receiver-mouse",
    sensitivity = 1.0,
})




--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- TODO fix this
hl.window_rule({
    name        = "youtube scroll",
    match       = { title = ".*YouTube.*" },
    border_size = 0,
})

hl.window_rule({
    name      = "discord",
    match     = { initial_class = "discord" },
    workspace = "3 silent",
})

hl.window_rule({
    name      = "steam",
    match     = { initial_class = "steam" },
    workspace = "5 silent",
})

hl.window_rule({
    name       = "rocket league",
    match      = { initial_title = "Rocket League (64-bit, DX11, Cooked)" },
    fullscreen = true,
})

hl.window_rule({
    name             = "IGS",
    match            = { class = "InGameRank", title = "InGameRank" },
    float            = true,
    no_focus         = true,
    no_shadow        = true,
    no_initial_focus = true,
    move             = "0 monitor_h-window_h",
})


hl.window_rule({
    name  = "iwgtk",
    match = { title = "iwgtk" },
    float = true,
})

hl.window_rule({
    name  = "pipewire",
    match = { initial_class = "com.saivert.pwvucontrol" },
    float = true,
})

hl.window_rule({
    name  = "app launcher",
    match = { title = "qs-launcher" },
    float = true,
})

hl.window_rule({
    name  = "personal spotify controller",
    match = { title = "Spotify Control" },
    float = true,
})

--[[
hl.window_rule({
  name       = "fullscreen godot",
  match      = { class = "Godot" },
  fullscreen = true,
})
--]]

hl.window_rule({
    name      = "spotify workspace",
    match     = { initial_class = "Spotify" },
    workspace = "special:Spotify silent",
})

hl.window_rule({
    name       = "idk",
    match      = { initial_class = "steam_app_252950" },
    fullscreen = true,
})

hl.window_rule({
    name       = "genshin maximize",
    match      = { initial_title = "Genshin Impact" },
    fullscreen = true,
})

-- Ignore maximize requests from all apps
hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name     = "nofocus",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

require("conf/animations")
require("conf/keybinds")
require("conf/workspaces")
require("conf/advanced_conf")

-- Temp mouse fix:
hl.config({ cursor = { no_hardware_cursors = 1 } })
