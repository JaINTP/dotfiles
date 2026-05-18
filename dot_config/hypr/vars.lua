-- vars.lua — single source of truth for all configurable values
-- Loaded first in hyprland.lua; every other module does: local v = require("vars")

local M        = {}
local helpers  = require("scripts.helpers")
local hostname = helpers.get_hostname()


local laptop_monitor  = { output = "eDP-1", mode = "preferred", position = "0x0", scale = "1" }
local monitors        = {
    -- Desktop PC (galdheim)
    galdheim = {
        primary   = { output = "DP-3", mode = "5120x1440@240", position = "0x0", scale = "1" },
        secondary = { output = "HDMI-A-1", mode = "1920x1080@75", position = "5120x0", scale = "1", transform = 3 },
    },
    -- Laptop (valkyrja)
    valkyrja = {
        primary   = laptop_monitor,
        secondary = laptop_monitor,
    },
}

-- ── Monitors ──────────────────────────────────────────────────────────────────
local active_monitors = monitors[hostname] or monitors.galdheim
M.MON_PRIMARY         = active_monitors.primary
M.MON_SECONDARY       = active_monitors.secondary

-- ── Terminal ──────────────────────────────────────────────────────────────────
M.TERM                = "kitty"

-- ── Applications ──────────────────────────────────────────────────────────────
M.FILE_MAN            = "dolphin"
-- M.WALLPAPER     = "random-wallpaper"
M.SCREENSHOT          = "hyprsnap"
M.COLOR_PICKER        = "hyprpicker"
M.DISCORD             = "vesktop"
M.MUSIC               = "spotify"
M.BREAK_TIMER         = "ianny"
M.AUDIO_FX            = "easyeffects"
M.GAMING              = "awww-daemon"
M.SUNSHINE            = "sunshine"

-- ── Launcher (vicinae) ────────────────────────────────────────────────────────
M.LAUNCHER            = "/usr/bin/vicinae"
M.CALC                = M.LAUNCHER .. " vicinae://launch/calculator/history?toggle=true"
M.RUNNER              = M.LAUNCHER .. " vicinae://launch/system/run?toggle=true"
M.POWER_MENU          = M.LAUNCHER .. " vicinae://launch/power/menu?toggle=true"
M.CLIPBOARD           = M.LAUNCHER .. " vicinae://launch/clipboard/history?toggle=true"
M.EMOJI               = M.LAUNCHER .. " vicinae://launch/core/search-emojis"

-- ── Paths ─────────────────────────────────────────────────────────────────────
M.SCRIPT_DIR          = "/home/jaintp/.local/bin"
M.BAR                 = "wayle panel start"

-- ── Cursor / Theme ────────────────────────────────────────────────────────────
M.CURSOR_THEME        = "HyprCatppuccinMochaDark"
M.CURSOR_SIZE         = "20"

return M
