-- Keybinds
-- name: "Default"
-- See https://wiki.hypr.land/Configuring/Basics/Binds/

local mainMod     = "SUPER"
local copilotKey  = "code:201"
local HYPRSCRIPTS = os.getenv("HOME") .. "/.config/hypr/scripts"

local function resetSubmap()
    hl.dispatch(hl.dsp.submap("reset"))
end

-----------------------
---- MISC / SYSTEM ----
-----------------------

-- Use of copilot key
hl.bind(copilotKey, hl.dsp.submap("appLauncher"))

hl.define_submap("appLauncher", function()
    hl.bind("S", function()
        hl.exec_cmd("steam")
        resetSubmap()
    end)
    hl.bind("W", function()
        hl.exec_cmd("kitty")
        resetSubmap()
    end)
    hl.bind("Q", function()
        hl.exec_cmd("qs")
        resetSubmap()
    end)
    hl.bind("Tab", function()
        hl.exec_cmd("pkill qs")         -- This is for everything but nix
        hl.exec_cmd("pkill quickshell") -- This is for nix
        resetSubmap()
    end)
    hl.bind("I", function()
        hl.exec_cmd("iwgtk")
        resetSubmap()
    end)
    hl.bind(copilotKey, function()
        hl.exec_cmd("amane ipc call launcher toggle")
        resetSubmap()
    end)
    hl.bind("M", function()
        -- Spawn 6 firefox windows with different links.
        resetSubmap()
    end)
    hl.bind("A", function()
        hl.exec_cmd("amane run")
        resetSubmap()
    end)
    hl.bind("E", function()
        hl.exec_cmd("pkill amane")
        resetSubmap()
    end)
    hl.bind("catchall", hl.dsp.submap("reset"))
end)

hl.bind(mainMod .. " + ALT + T", hl.dsp.submap("pseudo-lock"))

hl.define_submap("pseudo-lock", function()
    hl.bind(mainMod .. " + SHIFT + ALT + CTRL + L", function()
        hl.notification.create({ text = "Hi", duration = 500 })
    end)
    hl.bind("catchall", hl.dsp.submap("reset"))
end)


---------------------
---- APPLICATIONS ----
---------------------

hl.bind(mainMod .. " + RETURN", function()
    --local title : string = hl.get_active_window().title
    if hl.get_active_window() ~= nil then
        if string.find(hl.get_active_window().title, "Lumina") ~= nil then
            -- Kitty in directory of game
            hl.exec_cmd("kitty ~/PlatformFighterFinal")
        elseif string.find(hl.get_active_window().title, "Survival") ~= nil then
            hl.exec_cmd("kitty ~/cool-epic-game-3606769420")
        else
            hl.exec_cmd("kitty")
        end
    else
        hl.exec_cmd("kitty")
    end

    -- hl.exec_cmd("kitty")
    -- Terminal
end)
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("firefox")) -- Browser
-- hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("thunar"))  -- File manager


---------------------
---- DISPLAY ZOOM ----
---------------------

-- Increase / decrease / reset display zoom via cursor:zoom_factor
hl.bind(mainMod .. " + SHIFT + mouse_down", hl.dsp.exec_cmd(
    [[hyprctl keyword cursor:zoom_factor $(awk "BEGIN {print $(hyprctl getoption cursor:zoom_factor | grep 'float:' | awk '{print $2}') + 0.5}")]]
))
hl.bind(mainMod .. " + SHIFT + mouse_up", hl.dsp.exec_cmd(
    [[hyprctl keyword cursor:zoom_factor $(awk "BEGIN {print $(hyprctl getoption cursor:zoom_factor | grep 'float:' | awk '{print $2}') - 0.5}")]]
))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor 1"))


---------------------
---- WINDOWS ----
---------------------

hl.bind(mainMod .. " + Q", hl.dsp.window.close())                      -- Kill active window
hl.bind(mainMod .. " + SHIFT + Q",
    hl.dsp.exec_cmd(                                                   -- Kill window and all its instances
        "hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = 0 }))     -- Fullscreen
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = 1 }))     -- Maximize
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" })) -- Toggle float
hl.bind(mainMod .. " + V", hl.dsp.window.pin())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))               -- Toggle split (dwindle)
hl.bind(mainMod .. " + H", hl.dsp.group.toggle())                      -- Toggle window group. I never use this so its bind is changing from g to h.
hl.bind(mainMod .. " + K", hl.dsp.layout("swapsplit"))                 -- Swap split (dwindle)

-- Focus
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Move/resize with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Resize with keyboard
-- hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ delta = { 100, 0 } }))
-- hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.resize({ delta = { -100, 0 } }))
-- hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.resize({ delta = { 0, 100 } }))
-- hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.resize({ delta = { 0, -100 } }))

-- Swap tiled windows
hl.bind(mainMod .. " + ALT + left", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + ALT + up", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + ALT + down", hl.dsp.window.swap({ direction = "down" }))

-- Cycle through windows (ALT+Tab behaviour)
hl.bind("ALT + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.bring_to_top())
end, { repeating = true })


---------------------
---- ACTIONS ----
---------------------

hl.bind(mainMod .. " + CTRL + R", hl.dsp.exec_cmd("hyprctl reload"))                                 -- Reload config
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/toggle-animations.sh"))          -- Toggle animations
hl.bind(mainMod .. " + ALT + F", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/screenshot.sh --instant"))         -- Instant fullscreen screenshot
hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/screenshot.sh --instant-area"))    -- Instant area screenshot
hl.bind(mainMod .. " + CTRL + Q", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/nic4k/wlogout.sh")) -- Wlogout
hl.bind(mainMod .. " + ALT + W", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/wallpaper-automation.sh"))         -- Random wallpaper

-- App launcher (qs ipc, falls back to rofi)
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("qs ipc call launcher toggle"))
-- #pkill rofi || rofi -show drun -replace -i"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("qs ipc call dashboard toggle"))
hl.bind(mainMod .. " + ALT + D", hl.dsp.exec_cmd("qs ipc call settings toggle"))

-- notification center toggle
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("qs ipc call notifications toggle"))

-- Waybar toggle
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("pkill waybar || waybar"))

-- Screenshots via hyprshot
-- NOTE: SUPER+PRINT is bound twice below (script vs hyprshot). Comment out one.
-- hl.bind(mainMod .. " + PRINT",    hl.dsp.exec_cmd(HYPRSCRIPTS .. "/screenshot.sh"))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window")) -- Screenshot window
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output"))               -- Screenshot monitor
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region"))       -- Screenshot region

-- Power menu
hl.bind(mainMod .. " + ESCAPE", function()
    hl.dispatch(hl.dsp.exec_cmd("qs ipc call power toggle"))
    hl.dispatch(hl.dsp.exec_cmd("amane ipc call power toggle"))
end)


-----------------------
---- WORKSPACES ----
-----------------------

-- Switch to workspace
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))

-- Move active window to workspace
for i = 1, 9 do
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Relative workspace navigation
hl.bind(mainMod .. " + MINUS", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + EQUAL", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + Tab", hl.dsp.focus({ workspace = "m+1" }))           -- Next workspace on monitor
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "m-1" }))   -- Prev workspace on monitor
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))    -- Scroll next
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))      -- Scroll prev
hl.bind(mainMod .. " + CTRL + down", hl.dsp.focus({ workspace = "empty" })) -- Next empty workspace

-- Move window to workspace (relative)
hl.bind(mainMod .. " + SHIFT + MINUS", hl.dsp.window.move({ workspace = "-1" }))
hl.bind(mainMod .. " + SHIFT + EQUAL", hl.dsp.window.move({ workspace = "+1" }))

-- Special workspaces
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("Spotify"))
hl.bind(mainMod .. " + N", hl.dsp.workspace.toggle_special())
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:Spotify" }))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.window.move({ workspace = "special" }))

-- Window switcher / workspace switcher (qs)
hl.bind(mainMod .. " + BACKSLASH", hl.dsp.exec_cmd("qs ipc call switcher toggleWorkspace"))
hl.bind(mainMod .. " + SHIFT + BACKSLASH", hl.dsp.exec_cmd("qs ipc call switcher toggleMove"))


---------------------
---- FN KEYS ----
---------------------

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -q s +10%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -q s 10%-"))

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"))
-- hl.bind("XF86Lock", hl.dsp.exec_cmd("hyprlock"))

-- Volume (pw-volume + notify waybar)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pw-volume change +2.5%; pkill -RTMIN+8 waybar"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pw-volume change -2.5%; pkill -RTMIN+8 waybar"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pw-volume mute toggle; pkill -RTMIN+8 waybar"))

-- Spotify controls
--TODO make this use playerctl
--So apparently i dont feel like getting spotify control on nix since its not in the packages. Now itll work with playerctl
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("playerctl -p spotify play-pause"))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("playerctl -p spotify next"))
hl.bind(mainMod .. " + CTRL + P", hl.dsp.exec_cmd("playerctl -p spotify previous"))

-- KEYBIND TESTING GROUNDS --

hl.bind(mainMod .. " + I", hl.dsp.window.pseudo())
