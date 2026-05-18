local v        = require("vars")
local mod      = "SUPER"

local keybinds = {
    -- 1. Essential Commands
    { mod .. " + RETURN",              hl.dsp.exec_cmd(v.TERM) },
    --{ mod .. " + B",      hl.dsp.exec_cmd(v.WALLPAPER) },
    { mod .. " + E",                   hl.dsp.exec_cmd(v.FILE_MAN) },
    { mod .. " + SHIFT + P",           hl.dsp.exec_cmd(v.COLOR_PICKER .. " -a") },
    -- 2. Launcher
    { mod .. " + space",               hl.dsp.exec_cmd(v.LAUNCHER .. " toggle") },
    { mod .. " + SHIFT + V",           hl.dsp.exec_cmd(v.CALC) },
    { mod .. " + SHIFT + space",       hl.dsp.exec_cmd(v.RUNNER) },
    { mod .. " + SHIFT + X",           hl.dsp.exec_cmd(v.POWER_MENU) },
    { mod .. " + V",                   hl.dsp.exec_cmd(v.CLIPBOARD) },
    { mod .. " + CONTROL + E",         hl.dsp.exec_cmd(v.EMOJI) },
    -- 3. System
    { mod .. " + M",                   hl.dsp.exit() },
    { mod .. " + Q",                   hl.dsp.window.close() },
    { mod .. " + X",                   hl.dsp.exec_cmd("WAYLAND_DEBUG=1 hyprlock &> ~/hyprlock.txt 2>&1") },
    -- 4. Layout
    { mod .. " + P",                   hl.dsp.layout("pseudo") },
    { mod .. " + T",                   hl.dsp.layout("togglesplit") },
    { mod .. " + SHIFT + F",           hl.dsp.window.float({ action = "toggle" }) },
    { mod .. " + F",                   hl.dsp.window.fullscreen({ state = 0 }) },
    { mod .. " + SHIFT + C",           hl.dsp.window.center() },

    -- Offset window
    { mod .. " + CONTROL + SHIFT + L", hl.dsp.exec_cmd(v.SCRIPT_DIR .. "/offset-window.sh left") },
    { mod .. " + CONTROL + SHIFT + R", hl.dsp.exec_cmd(v.SCRIPT_DIR .. "/offset-window.sh right") },

    -- 5. Screenshot
    -- { "Print",                         hl.dsp.exec_cmd(v.SCREENSHOT) },

    -- 6. Focus
    { mod .. " + H",                   hl.dsp.focus({ direction = "left" }) },
    { mod .. " + L",                   hl.dsp.focus({ direction = "right" }) },
    { mod .. " + K",                   hl.dsp.focus({ direction = "up" }) },
    { mod .. " + J",                   hl.dsp.focus({ direction = "down" }) },

    -- 7. Move Windows
    { mod .. " + SHIFT + H",           hl.dsp.window.move({ direction = "l" }) },
    { mod .. " + SHIFT + L",           hl.dsp.window.move({ direction = "r" }) },
    { mod .. " + SHIFT + K",           hl.dsp.window.move({ direction = "u" }) },
    { mod .. " + SHIFT + J",           hl.dsp.window.move({ direction = "d" }) },

    -- 8. Resize Windows (repeating)
    { mod .. " + CONTROL + L",         hl.dsp.window.resize({ x = "10", y = "0" }),                       { repeating = true } },
    { mod .. " + CONTROL + H",         hl.dsp.window.resize({ x = "-10", y = "0" }),                      { repeating = true } },
    { mod .. " + CONTROL + K",         hl.dsp.window.resize({ x = "0", y = "-10" }),                      { repeating = true } },
    { mod .. " + CONTROL + J",         hl.dsp.window.resize({ x = "0", y = "10" }),                       { repeating = true } },

    -- 9. Workspaces
    { mod .. " + TAB",                 hl.dsp.focus({ workspace = "previous" }) },

    -- Special workspaces
    { mod .. " + S",                   hl.dsp.workspace.toggle_special("scratchpad") },
    { mod .. " + SHIFT + S",           hl.dsp.window.move({ workspace = "special:scratchpad" }) },
    { mod .. " + Z",                   hl.dsp.workspace.toggle_special("media") },
    { mod .. " + SHIFT + Z",           hl.dsp.window.move({ workspace = "special:media" }) },

    -- Mouse
    { mod .. " + mouse_down",          hl.dsp.focus({ workspace = "e+1" }) },
    { mod .. " + mouse_up",            hl.dsp.focus({ workspace = "e-1" }) },
    { mod .. " + mouse:272",           hl.dsp.window.drag(),                                              { mouse = true } },
    { mod .. " + mouse:273",           hl.dsp.window.resize(),                                            { mouse = true } },

    -- 10. Brightness (repeating)
    { "XF86MonBrightnessUp",           hl.dsp.exec_cmd(v.SCRIPT_DIR .. "/brightness up"),                 { repeating = true } },
    { "XF86MonBrightnessDown",         hl.dsp.exec_cmd(v.SCRIPT_DIR .. "/brightness down"),               { repeating = true } },

    -- 11. Audio (locked / locked+repeating)
    { "XF86AudioMicMute",              hl.dsp.exec_cmd(v.SCRIPT_DIR .. "/volume mic"),                    { locked = true } },
    { "XF86AudioMute",                 hl.dsp.exec_cmd(v.SCRIPT_DIR .. "/volume mute-toggle"),            { locked = true } },
    { "XF86AudioRaiseVolume",          hl.dsp.exec_cmd(v.SCRIPT_DIR .. "/volume vol-up"),                 { repeating = true, locked = true } },
    { "XF86AudioLowerVolume",          hl.dsp.exec_cmd(v.SCRIPT_DIR .. "/volume vol-down"),               { repeating = true, locked = true } },
    { "XF86AudioPlay",                 hl.dsp.exec_cmd(v.SCRIPT_DIR .. "/media play-pause"),              { repeating = true, locked = true } },
    { "XF86AudioNext",                 hl.dsp.exec_cmd(v.SCRIPT_DIR .. "/media next"),                    { repeating = true, locked = true } },
    { "XF86AudioPrev",                 hl.dsp.exec_cmd(v.SCRIPT_DIR .. "/media previous"),                { repeating = true, locked = true } }
}

for i = 1, 10 do
    local key = i % 10
    table.insert(keybinds, { mod .. " + " .. key, hl.dsp.focus({ workspace = i }) })
    table.insert(keybinds, { mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }) })
end

for _, keybind in ipairs(keybinds) do
    hl.bind(keybind[1], keybind[2], keybind[3])
end
