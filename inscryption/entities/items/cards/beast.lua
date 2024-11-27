local cards = {}


local loc = localization.localize
local interp = localization.newInterpolator
local TEXT_MAX_WIDTH = 200

local function printCenterWithOutline(text, x, y, rot, sx, sy, oy, kx, ky)
    local r, g, b, a = love.graphics.getColor()
    local ox = TEXT_MAX_WIDTH / 2

    love.graphics.setColor(0, 0, 0, a)
    for outY = -1, 1 do
        for outX = -1, 1 do
            if not (outX == 0 and outY == 0) then
                love.graphics.printf(text, x + outX * sx, y + outY * sy, TEXT_MAX_WIDTH, "center", rot, sx, sy, ox, oy, kx, ky)
            end
        end
    end

    love.graphics.setColor(r, g, b, a)
    love.graphics.printf(text, x, y, TEXT_MAX_WIDTH, "center", rot, sx, sy, ox, oy, kx, ky)
end


local ATTACK_HEALTH_TEXT = interp("%{attack} - %{insHP}")
local HEALTH_COLOR = objects.Color.fromByteRGBA(252, 5, 3)
local NAME_TEXT = interp("%{name}")
local SACRRIFICE_REQUIRED_TEXT = interp("%{name}/%{sacrificeRequired}")
local WHITE_COLOR = objects.Color.fromByteRGBA(255, 255, 255)

local function drawItemAttackHealth(itemEnt)
    if itemEnt.insHP and itemEnt.attack then
        love.graphics.setColor(WHITE_COLOR)
        printCenterWithOutline(ATTACK_HEALTH_TEXT(itemEnt), itemEnt.x, itemEnt.y, 0, 0.75, 0.75, -5, 0, 0)
    end
    if itemEnt.sacrificeRequired and itemEnt.sacrificeRequired > 0 then
        love.graphics.setColor(HEALTH_COLOR)
        printCenterWithOutline(SACRRIFICE_REQUIRED_TEXT(itemEnt), itemEnt.x, itemEnt.y, 0, 0.75, 0.75, 20, 0, 0)
    else
        love.graphics.setColor(HEALTH_COLOR)
        printCenterWithOutline(NAME_TEXT(itemEnt), itemEnt.x, itemEnt.y, 0, 0.75, 0.75, 20, 0, 0)
    end
end


local function defineBeast(id, details)
    details.beast = true

    details.name = details.name or "NO NAME"
    details.image = details.image or "place_holder_card"
    details.rarity = lp.rarities.UNIQUE
    details.description = details.description or "NO DESCRIPTION"
    details.attack = details.attack or 0
    details.insHP = details.insHP or 1
    details.blood = details.blood or 1
    details.sacrificeRequired = details.sacrificeRequired or 0
    details.canItemFloat = true

    details.onDraw = function(ent, x,y, rot, sx,sy)
        drawItemAttackHealth(ent)
    end

    details.shape = details.shape or lp.targets.ABOVE_SHAPE
    details.target = {
        type = "ITEM_OR_SLOT",
        description = "Deals " .. details.attack .. " damage.",
        activate = function (selfEnt, ppos, targetEnt)
        if inscryption.state == "play" then
            if selfEnt.attack and targetEnt then
                if targetEnt.insHP then
                    targetEnt.insHP = targetEnt.insHP - selfEnt.attack
                    if targetEnt.insHP <= 0 then
                        lp.destroy(targetEnt)
                    end
                elseif lp.isSlotEntity(targetEnt) then
                    if selfEnt.lootplotTeam == inscryption.team then
                        lp.addPoints(targetEnt, -selfEnt.attack)
                    elseif selfEnt.lootplotTeam == inscryption.player_team then
                        lp.addPoints(targetEnt, selfEnt.attack)
                    end
                end
            end
        end
    end}

    local sigils = details.sigils or {}
    for i, sigil in pairs(sigils) do
        inscryption.giveSigilEffect(details, sigil)
    end
    details.sigils = details.sigils or {}

    cards[id] = details
    print(#details.sigils)
    table.insert(inscryption.beasts, id)
end

defineBeast("squirrel", {
    image="squirrel",
    name ="Squirrel"
})

defineBeast("stoat", {
    name = "Stoat",
    description = "We gotta get outa this plot!",
    attack = 1,
    insHP = 3,
    sacrificeRequired = 1
})

defineBeast("raven", {
    name = "Raven",
    description = "Fly!",
    attack = 2,
    insHP = 3,
    sacrificeRequired = 2,
    sigils = {"Airborne"}
})

for id, card in pairs(cards) do
    lp.defineItem("inscryption:" .. id, card)
end

