--[[
    j0k3r-pomade :: Configuration File (v1.2.0)
    --------------------------------------------
    The animation, prop and hat handling are all done by the in-game
    APPLY_POMADE interaction native, so there's nothing to configure
    on that side. Just tell the script which items should trigger it.

    Author : J0K3R-Scripts
    Discord: https://discord.gg/DH8tW6vSxV
]]

Config = {}

-- =====================================================================
-- USABLE ITEMS
-- =====================================================================
-- Every item name here must already exist in your `items` table inside
-- the vorp_inventory database, with `usable = 1`. Run install.sql once
-- to insert the default `pomade` item.
-- =====================================================================

Config.PomadeItems = {
    'j0k3r_pomade',
    -- 'pomade_premium',
    -- 'pomade_lavender',
}

-- =====================================================================
-- GENERAL
-- =====================================================================

-- Locale used by the script (must match a key in Config.Locales below)
Config.Locale = 'en'

-- Print debug info in the server / client console.
Config.Debug = false

-- =====================================================================
-- DISCORD WEBHOOK (optional, server-side only)
-- =====================================================================

Config.Webhook = {
    enabled = false,
    url     = '', -- e.g. "https://discord.com/api/webhooks/xxx/yyy"
    botName = 'j0k3r-pomade',
    color   = 10181046, -- 0x9b59b6 purple
    avatar  = '',
}

-- =====================================================================
-- LOCALES
-- =====================================================================

Config.Locales = {
    ['en'] = {
        title    = 'Hair Pomade',
        success  = 'Your hair is now slick and tidy.',
    },

    ['de'] = {
        title    = 'Haarpomade',
        success  = 'Deine Haare sitzen jetzt perfekt.',
    },

    ['es'] = {
        title    = 'Pomada Capilar',
        success  = 'Tu cabello luce impecable.',
    },

    ['fr'] = {
        title    = 'Pommade Capillaire',
        success  = 'Vos cheveux sont parfaitement coiffés.',
    },
}
