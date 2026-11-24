-- Workspace rules
-- name: "Default"
-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Monitor assignments: workspaces 1-4 on the built-in display, 5-8 on the external
-- for i = 1, 4 do
--     hl.workspace_rule({ workspace = tostring(i), monitor = "eDP-1" })
-- end
-- for i = 5, 8 do
--     hl.workspace_rule({ workspace = tostring(i), monitor = "DP-2" })
-- end

-- Example rules (uncomment to use):
-- hl.workspace_rule({ workspace = "3",             rounding = false, decorate = false })
-- hl.workspace_rule({ workspace = "name:coding",   rounding = false, decorate = false, gaps_in = 0, gaps_out = 0, border = false, monitor = "DP-1" })
-- hl.workspace_rule({ workspace = "8",             border_size = 8 })
-- hl.workspace_rule({ workspace = "name:Hello",    monitor = "DP-1", default = true })
-- hl.workspace_rule({ workspace = "name:gaming",   monitor = "desc:Chimei Innolux Corporation 0x150C", default = true })
-- hl.workspace_rule({ workspace = "5",             on_created_empty = "firefox" }) -- float modifier goes in window rule

-- Special workspaces
hl.workspace_rule({
    workspace  = "special:Spotify",
    persistent = true,
})

hl.on("workspace.created", function(ws)
    if ws.is_empty and ws.name == "special:Spotify" then
        hl.exec_cmd("spotify")
    end
end)

hl.workspace_rule({
    workspace  = "special:Godot1",
    persistent = true,
    monitor    = "eDP-1",
})

hl.workspace_rule({
    workspace = "special:Godot2",
    persistent = true,
    monitor = "HDMI-A-1"
})
