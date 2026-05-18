local v = require("vars")


-- 1. Environment Variables
local envs = {
    {
        key = "LIBVA_DRIVER_NAME",
        value = "nvidia"
    },
    {
        key = "__GLX_VENDOR_LIBRARY_NAME",
        value = "nvidia"
    },
    {
        key = "NVD_BACKEND",
        value = "direct"
    },
    {
        key = "HYPRCURSOR_THEME",
        value = v.CURSOR_THEME
    },
    {
        key = "HYPRCURSOR_SIZE",
        value = v.CURSOR_SIZE
    },
    {
        key = "XCURSOR_THEME",
        value = v.CURSOR_THEME
    },
    {
        key = "XCURSOR_SIZE",
        value = v.CURSOR_SIZE
    },
    {
        key = "QT_QPA_PLATFORMTHEME",
        value = "qt6ct"
    },
    {
        key = "QT_STYLE_OVERRIDE",
        value = "Kvantum"
    },
    {
        key = "GTK_THEME",
        value = "catppuccin-mocha-mauve-standard+default"
    },
    {
        key = "XDG_SESSION_TYPE",
        value = "wayland"
    },
    {
        key = "GBM_BACKEND",
        value = "nvidia-drm"
    }
}

for _, env in ipairs(envs) do
    hl.env(env.key, env.value)
end

-- 2. Autostart
local auto_starts = {
    -- Essential
    { "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP" },
    { "dbus-update-activation-environment --systemd SSH_AUTH_SOCK" },
    { "gnome-keyring-daemon --start --components=secrets,ssh" },
    { "systemctl --user start " .. v.SUNSHINE },
    -- User apps
    { v.LAUNCHER .. " server" },
    { v.BAR },
    { v.GAMING },
    { v.MUSIC },
    { v.DISCORD },
    -- { "hypridle" },
    { v.BREAK_TIMER },
    { v.AUDIO_FX .. " -gapplication-service" },
    -- Scratchpad terminal (workspace 2, silent)
    { v.TERM .. " --app-id='Scratchpad' --name='Scratchpad' --title='Scratchpad'",
        { workspace = "2 silent" } }
}

hl.on("hyprland.start", function()
    for _, auto_start in ipairs(auto_starts) do
        hl.exec_cmd(auto_start[1], auto_start[2])
    end
end)
