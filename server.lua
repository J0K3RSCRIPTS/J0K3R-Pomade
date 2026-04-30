--[[
    j0k3r-pomade :: Server Logic (v1.2.0)
    --------------------------------------
    Author : J0K3R-Scripts
    Discord: https://discord.gg/DH8tW6vSxV
]]

-- We use the legacy VORP inventory API (vorp_inventoryApi)
-- exposes consistently, including older builds where the modern
-- `exports.vorp_inventory:registerUsableItem` snake_case method may
-- not be linked yet.
local VORPInv = exports.vorp_inventory:vorp_inventoryApi()

local function dprint(...)
    if Config.Debug then
        print('^5[j0k3r-pomade]^7', ...)
    end
end

-- ---------------------------------------------------------------------
-- Discord webhook (optional)
-- ---------------------------------------------------------------------

local function sendWebhook(playerName, src, itemName)
    if not Config.Webhook.enabled or Config.Webhook.url == '' then return end

    local embed = {
        {
            ['title']  = 'Pomade Used',
            ['color']  = Config.Webhook.color,
            ['fields'] = {
                { name = 'Player',    value = tostring(playerName), inline = true },
                { name = 'Source ID', value = tostring(src),        inline = true },
                { name = 'Item used', value = tostring(itemName),   inline = true },
            },
            ['footer'] = { ['text'] = os.date('%Y-%m-%d %H:%M:%S') },
        }
    }

    PerformHttpRequest(Config.Webhook.url, function(_err, _text, _headers) end, 'POST', json.encode({
        username   = Config.Webhook.botName,
        avatar_url = Config.Webhook.avatar ~= '' and Config.Webhook.avatar or nil,
        embeds     = embed,
    }), { ['Content-Type'] = 'application/json' })
end

-- ---------------------------------------------------------------------
-- Register every configured pomade item as usable.
-- — that's what works.
-- ---------------------------------------------------------------------

for _, item in pairs(Config.PomadeItems) do
    VORPInv.RegisterUsableItem(item, function(data)
        local src = data.source

        dprint(('Player %s used item: %s'):format(src, item))

        -- Close the inventory and remove one item right away. The
        -- `TaskItemInteraction` native on the client takes care of the
        -- animation, the pomade jar prop, and the hair material change
        -- automatically — no confirm step needed.
        VORPInv.CloseInv(src)
        VORPInv.subItem(src, item, 1)

        TriggerClientEvent('j0k3r-pomade:applyPomade', src, item)

        -- Discord log (best effort, name lookup wrapped so it never
        -- blocks the actual pomade flow)
        pcall(function()
            local name = GetPlayerName(src) or ('source #%d'):format(src)
            sendWebhook(name, src, item)
        end)
    end)

    print(('^5[j0k3r-pomade]^7 ^2Registered usable item:^7 %s'):format(item))
end

-- ---------------------------------------------------------------------
-- Pretty startup banner
-- ---------------------------------------------------------------------

CreateThread(function()
    print('^5+--------------------------------------------+^7')
    print('^5|^7        ^4j0k3r-pomade^7 by ^3J0K3R-Scripts^7         ^5|^7')
    print('^5|^7   Discord: https://discord.gg/DH8tW6vSxV   ^5|^7')
    print('^5|^7        Free script, contributions welcome  ^5|^7')
    print('^5+--------------------------------------------+^7')
end)
