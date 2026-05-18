local v = require("vars")

-- 1. Workspace Rules
local workspace_rules = {
    { workspace = "1",                 monitor = v.MON_PRIMARY.output,   persistent = true },
    { workspace = "2",                 monitor = v.MON_PRIMARY.output,   persistent = true },
    { workspace = "3",                 monitor = v.MON_PRIMARY.output,   persistent = true },
    { workspace = "4",                 monitor = v.MON_SECONDARY.output, persistent = true },
    { workspace = "5",                 monitor = v.MON_SECONDARY.output, persistent = true },
    { workspace = "special:scratchpad" },
    { workspace = "special:media" }
}

-- 2. Window Rules
local window_rules = {

    -- General
    { match = { class = ".*" },          suppress_event = "maximize" },
    -- Scratchpad
    { match = { class = "^Scratchpad" }, workspace = "special:scratchpad", float = true, size = "56% 65%", center = true },

    -- Kitty
    {
        match = { class = "^kittyfetch" },
        workspace = 1,
        float = true,
        size = "732 452",
        monitor = v.MON_PRIMARY.output
    },

    { match = { class = "^(" .. v.TERM .. ")$" }, float = false, size = "56% 65%" },

    -- Antigravity
    { match = { class = "^antigravity" }, workspace = 2 },

    -- Dolphin
    { match = { title = "^(.*Dolphin)$" }, size = "65% 76%" },

    -- Steam
    { match = { title = "^steam" }, workspace = 1, center = true, tile = true },

    -- Battle.net
    { match = { title = "^Battle.net" }, workspace = 1, center = true, tile = true },

    -- World of Warcraft
    { match = { title = "^World of Warcraft" }, workspace = 1 },

    -- WowUp
    { match = { title = "^WowUp" }, workspace = 3 },

    -- PortProton
    { match = { title = "^PortProton" }, workspace = 1 },

    -- Vesktop
    { match = { title = "^" .. v.DISCORD }, workspace = 4 },

    -- Spotify
    { match = { class = "^" .. v.MUSIC }, workspace = "special:media" },

    -- Audible Webplayer
    { match = { title = "^Audible Cloud Player — Zen Browser" }, workspace = "special:media" },

    -- XWaylandVideoBridge
    {
        match            = { class = "^(xwaylandvideobridge)$" },
        opacity          = "0.0 override",
        animation        = "popin",
        no_blur          = true,
        max_size         = "1 1",
        no_initial_focus = true,
        no_focus         = true,
    },

    -- qBittorrent
    { match = { title = "^(.*qBittorrent.*)$" }, tile = true },

}

-- 3. Layer Rules
local layer_rules = {
    { match = { namespace = "notifications" }, blur = true, ignore_alpha = 1 },
    { match = { namespace = "vicinae" },       blur = true, ignore_alpha = 0 },
}

for _, rule in ipairs(workspace_rules) do
    hl.workspace_rule(rule)
end

for _, rule in ipairs(window_rules) do
    hl.window_rule(rule)
end

for _, rule in ipairs(layer_rules) do
    hl.layer_rule(rule)
end
