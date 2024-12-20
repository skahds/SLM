local loc = localization.localize
local interp = localization.newInterpolator


---@type generation.Generator
local itemGen

local function generateItem(ent)
    local itemName
    local activated = false
    if #setqueue.list > 0 then
        for _, itemAndRound in ipairs(setqueue.list) do
            if lp.getAttribute("ROUND", ent) == (itemAndRound[2]) then
                itemName = itemAndRound[1]
                activated = true
                break
            end
        end
    end
    if activated == false then
        itemGen = itemGen or lp.newItemGenerator()
        itemName = itemGen
            :query(function(entityType)
                return lp.getDynamicSpawnChance(entityType, ent)
            end)
        -- itemName = "iron_sword"
    else
        table.remove(setqueue.list, 1)
    end
    return itemName or lp.FALLBACK_NULL_ITEM
end

---@param ent Entity
---@param bool boolean
local function setItemLock(ent, bool)
    ent.itemLock = bool
    sync.syncComponent(ent, "itemLock")
end

local BUY_TEXT = interp("BUY ($%{price})")

---@param slotEnt Entity
local function buyServer(slotEnt)
    local itemEnt = lp.slotToItem(slotEnt)
    if itemEnt then
        lp.subtractMoney(slotEnt, itemEnt.price)
        lp.tryTriggerEntity("BUY", itemEnt)
        setItemLock(slotEnt, false)
    end
end

local function buyClient(slotEnt)
    lp.deselectItem()
    local itemEnt = lp.slotToItem(slotEnt)
    if itemEnt then
        lp.selectItem(itemEnt, true)
    end
end


local shopButton = {
    action = function(ent, clientId)
        if server then
            buyServer(ent)
        elseif client then
            buyClient(ent)
        end
    end,
    canDisplay = function(ent, clientId)
        return ent.itemLock
    end,
    canClick = function(ent, clientId)
        local itemEnt = lp.slotToItem(ent)
        if itemEnt and ent.itemLock then
            return lp.getMoney(itemEnt) >= itemEnt.price
        end
    end,
    text = function(ent)
        local itemEnt = lp.slotToItem(ent)
        if not itemEnt then
            return ""
        end
        return BUY_TEXT(itemEnt)
    end,
    color = objects.Color(0.39,0.66,0.24),
}




---@param ent Entity
---@param bool boolean
local function setRerollLock(ent, bool)
    ent.rerollLock = bool
    sync.syncComponent(ent, "rerollLock")
end

local LOCK_TEXT = loc("Lock reroll")
local UNLOCK_TEXT = loc("Unlock reroll")

local lockRerollButton = {
    action = function(ent, clientId)
        if server then
            setRerollLock(ent, not ent.rerollLock)
        end
    end,
    canDisplay = function(ent, clientId)
        return lp.slotToItem(ent)
    end,
    canClick = function(ent, clientId)
        return lp.slotToItem(ent)
    end,
    text = function(ent)
        if ent.rerollLock then
            return UNLOCK_TEXT
        else
            return LOCK_TEXT
        end
    end,
    color = objects.Color(0.7,0.7,0.7),
}



local TEXT_MAX_WIDTH = 200
---@param text string
---@param x number
---@param y number
---@param rot number
---@param sx number
---@param sy number
---@param oy number
---@param kx number
---@param ky number
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


local PRICE_TEXT = interp("$%{price}")
local PRICE_COLOR = objects.Color.fromByteRGBA(252, 211, 3)
local GREEN_PRICE_COLOR = objects.Color.fromByteRGBA(100, 252, 30)

local function drawItemPrice(selfEnt, itemEnt)
    if selfEnt.itemLock and itemEnt.price then
        if itemEnt.price > 0 then
            love.graphics.setColor(PRICE_COLOR)
        else
            love.graphics.setColor(GREEN_PRICE_COLOR)
        end
        printCenterWithOutline(PRICE_TEXT(itemEnt), itemEnt.x, itemEnt.y, 0, 0.75, 0.75, 20, 0, 0)
    end
end



lp.defineSlot("setqueue:shop_slot", {
    itemLock = true,
    image = "shop_slot",

    name = loc("Shop slot"),
    activateDescription = loc("Spawns a random item."),

    triggers = {"REROLL", "PULSE"},

    itemSpawner = generateItem,
    itemReroller = generateItem,

    baseCanSlotPropagate = false,
    baseMaxActivations = 100,

    canPlayerAccessItemInSlot = function(slotEnt, itemEnt)
        return not slotEnt.itemLock
    end,
    onActivate = function(slotEnt)
        setItemLock(slotEnt, true)
    end,
    onItemDraw = function(selfEnt, itemEnt)
        drawItemPrice(selfEnt, itemEnt)
    end,
    actionButtons = {
        shopButton
    }
})
