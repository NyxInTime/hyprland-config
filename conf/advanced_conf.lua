local mainMod = "SUPER"

local function focusDefault()
    hl.dispatch(hl.dsp.focus({ monitor = "eDP-1" }))
end
local function focusOther()
    hl.dispatch(hl.dsp.focus({ monitor = --[["HDMI-A-1"]] "DP-9" }))
end
local function toggleGodot1()
    hl.dispatch(hl.dsp.workspace.toggle_special("Godot1"))
end
local function toggleGodot2()
    hl.dispatch(hl.dsp.workspace.toggle_special("Godot2"))
end
local function focus(monitor)
    hl.dispatch(hl.dsp.focus({ monitor = monitor }))
end



hl.on("window.open", function(w)
    -- hl.notification.create({ text = "Hi", duration = 2000 })
    -- local title = hl.get_active_special_workspace()
    -- title = title.config_name
    -- hl.notification.create({ text = "The value is " .. title, duration = 2000 })
    local active_s_workspace = hl.get_active_special_workspace()

    if w.initial_title == "Godot" and w.initial_class ~= "Godot" and w.initial_class ~= "org.godotengine.ProjectManager" and w.initial_class ~= "org.godotengine.Editor" and w.initial_class ~= "Survival Game" then
        local setBackTo = hl.get_active_monitor()
        -- hl.notification.create({ text = "The amount is " .. workspace_win_count, duration = 2000 })
        if #hl.get_workspace_windows("special:Godot1") == 0 then
            hl.dispatch(hl.dsp.window.move({ workspace = "special:Godot1", window = w }))
            hl.dispatch(hl.dsp.window.fullscreen({ mode = "fullscreen", window = w }))
        else
            hl.dispatch(hl.dsp.window.move({ workspace = "special:Godot2", window = w }))
        end
        focus(setBackTo)
        hl.dispatch(hl.dsp.window.fullscreen({ mode = "fullscreen" }))
    elseif active_s_workspace ~= nil then
        local active_s_workspace_title = active_s_workspace.config_name
        hl.dsp.no_op()
        if w.initial_title ~= "Godot" and 1 == 1 and active_s_workspace_title == "special:Godot1" or active_s_workspace_title == "special:Godot2" then
            hl.notification.create({ text = "Hi im here", duration = 2000 })
            hl.dispatch(hl.dsp.window.move({ workspace = "special", window = w }))
        end
    end
end)
hl.bind(mainMod .. " + G", function()
    local setBackTo = hl.get_active_monitor()
    focusDefault()
    if hl.get_active_special_workspace() == nil then
        --m1 is nil. Focus m1
        focusOther()
        if hl.get_active_special_workspace() == nil then
            --m1 and m2 are nil. Focus m2
            focusDefault()
            toggleGodot1()
            focusOther()
            toggleGodot2()
        elseif hl.get_active_special_workspace().config_name ~= "special:Godot1" then
            -- m1 nil m2 special. Focus m2
            focusDefault()
            toggleGodot1()
            focusOther()
            toggleGodot2()
        else
            --m1 nil m2 godot. Focus m2
            hl.dsp.no_op()
        end
    elseif hl.get_active_special_workspace().config_name ~= "special:Godot1" then
        -- m1 special. Focus m1
        focusOther()
        if hl.get_active_special_workspace() == nil then
            --m1 special m2 nil. Focus m2
            focusDefault()
            toggleGodot1()
            focusOther()
            toggleGodot2()
        elseif hl.get_active_special_workspace().config_name ~= "special:Godot2" then
            -- m1 and m2 special. Focus m2
            focusDefault()
            toggleGodot1()
            focusOther()
            toggleGodot2()
        else
            --m1 special m2 godot. Focus m2
            hl.dsp.no_op()
        end
    else
        -- m1 godot. Focus m1
        focusOther()
        if hl.get_active_special_workspace() == nil then
            -- m1 godot m2 nil. Focus m2
            hl.dsp.no_op()
        elseif hl.get_active_special_workspace().config_name ~= "special:Godot2" then
            -- m1 godot m2 special. Focus m2
            hl.dsp.no_op()
        else
            -- m1 and m2 godot. Focus m2
            hl.dsp.no_op()
            toggleGodot2()
            focusDefault()
            toggleGodot1()
        end

        hl.dsp.no_op()
    end
    focus(setBackTo)
end)

--TODO make this keybind close or open the current monitors godot special, since i want to be able to both close and open both at the same time or not
hl.bind(mainMod .. " + SHIFT + G", function()
    -- Note this does not work
    hl.notification.create({ text = "The name is" .. hl.get_active_monitor().name .. "aj", duration = 20000 })
    if hl.get_active_monitor().name == "eDP-1" then
        hl.dsp.workspace.toggle_special("Godot1")
    else
        hl.dsp.workspace.toggle_special("Godot2")
    end
end)
