local v = require("vars")

-- 1. Monitors
hl.monitor({
    output = v.MON_PRIMARY.output,
    mode = v.MON_PRIMARY.mode,
    position = v.MON_PRIMARY.position,
    scale = v.MON_PRIMARY.scale
})
hl.monitor({
    output = v.MON_SECONDARY.output,
    mode = v.MON_SECONDARY.mode,
    position = v.MON_SECONDARY.position,
    scale = v.MON_SECONDARY.scale,
    transform = v.MON_SECONDARY.transform
})

-- 2. General Configuration
hl.config({
    input      = {
        kb_layout          = "us",
        kb_variant         = "",
        kb_model           = "",
        kb_options         = "",
        kb_rules           = "",
        follow_mouse       = 1,
        scroll_method      = "on_button_down",
        scroll_button      = 274,
        sensitivity        = 0.4,
        numlock_by_default = true,
        touchpad           = { natural_scroll = false },
    },
    general    = {
        gaps_in       = 2,
        gaps_out      = 10,
        border_size   = 1,
        col           = {
            active_border   = "rgba(474951FF)",
            inactive_border = "rgba(474961CF)",
        },
        allow_tearing = true,
        layout        = "dwindle",
    },
    decoration = {
        rounding         = 12,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        shadow           = {
            enabled        = true,
            range          = 24,
            render_power   = 3,
            offset         = "0 3",
            color          = "rgba(00000088)",
            color_inactive = "rgba(0000006F)",
        },
        blur             = {
            enabled           = true,
            size              = 25,
            passes            = 3,
            contrast          = 1.0,
            brightness        = 0.8172,
            vibrancy          = 0.1696,
            vibrancy_darkness = 0.2,
            ignore_opacity    = true,
        },
    },
    animations = { enabled = true },
    master     = { new_on_top = true },
    misc       = {
        vrr                        = 0,
        disable_hyprland_logo      = true,
        disable_splash_rendering   = true,
        layers_hog_keyboard_focus  = true,
        middle_click_paste         = false,
        allow_session_lock_restore = true,
    },
    xwayland   = { force_zero_scaling = true },
    debug      = { disable_logs = false },
})

-- 3. Curves
local curves = {
    { "linear",        { type = "bezier", points = { { 0, 0 }, { 1, 1 } } } },
    { "md3_standard",  { type = "bezier", points = { { 0.2, 0 }, { 0, 1 } } } },
    { "md3_decel",     { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } } },
    { "md3_accel",     { type = "bezier", points = { { 0.3, 0 }, { 0.8, 0.15 } } } },
    { "overshot",      { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.1 } } } },
    { "crazyshot",     { type = "bezier", points = { { 0.1, 1.5 }, { 0.76, 0.92 } } } },
    { "hyprnostretch", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.0 } } } },
    { "menu_decel",    { type = "bezier", points = { { 0.1, 1 }, { 0, 1 } } } },
    { "menu_accel",    { type = "bezier", points = { { 0.38, 0.04 }, { 1, 0.07 } } } },
    { "easeInOutCirc", { type = "bezier", points = { { 0.85, 0 }, { 0.15, 1 } } } },
    { "easeOutCirc",   { type = "bezier", points = { { 0, 0.55 }, { 0.45, 1 } } } },
    { "easeOutExpo",   { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } } },
    { "softAcDecel",   { type = "bezier", points = { { 0.26, 0.26 }, { 0.15, 1 } } } },
    { "md2",           { type = "bezier", points = { { 0.4, 0 }, { 0.2, 1 } } } },
}

for _, curve in ipairs(curves) do
    hl.curve(curve[1], curve[2])
end

-- 4. Animations
local animations = {
    { leaf = "windows",          enabled = true, speed = 2,   bezier = "md3_decel",  style = "popin 60%" },
    { leaf = "windowsIn",        enabled = true, speed = 2,   bezier = "md3_decel",  style = "popin 60%" },
    { leaf = "windowsOut",       enabled = true, speed = 2,   bezier = "md3_accel",  style = "popin 60%" },
    { leaf = "border",           enabled = true, speed = 10,  bezier = "default" },
    { leaf = "fade",             enabled = true, speed = 3,   bezier = "md3_decel" },
    { leaf = "layersIn",         enabled = true, speed = 0.8, bezier = "menu_decel", style = "slide" },
    { leaf = "layersOut",        enabled = true, speed = 1.8, bezier = "menu_accel" },
    { leaf = "fadeLayersIn",     enabled = true, speed = 0.6, bezier = "menu_decel" },
    { leaf = "fadeLayersOut",    enabled = true, speed = 2.0, bezier = "menu_accel" },
    { leaf = "workspaces",       enabled = true, speed = 4.0, bezier = "md3_decel",  style = "slide" },
    { leaf = "specialWorkspace", enabled = true, speed = 3,   bezier = "md3_decel",  style = "slidevert" },
}

for _, animation in ipairs(animations) do
    hl.animation(animation)
end
