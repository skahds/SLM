local loc = localization.newLocalizer()
botanicLib = {}

function botanicLib.forceSpawnItem(ppos, itemEType, team)
    local itemEnt = itemEType()
    itemEnt.lootplotTeam = team or "?"
    local prevItem = lp.posToItem(ppos)
    if prevItem then
        prevItem:delete()
    end
    
    ppos:set(itemEnt)
    return nil
end

local function isInTable(table, element)
    if table == nil then return false end
    for i=1, #table do
        if element == table[i] then
            return true
        end
    end
end

function botanicLib.addBotanicTableForSpawnedItem(ent, oldEnt)
    local newGrowthTable = oldEnt.botanicGrowth
    table.remove(newGrowthTable, 1)
    ent.botanicGrowth = newGrowthTable
    ent.age = oldEnt.age
    -- needs to sync!
    -- the server has the age and botanic growth correctly handled, the client seems to not know about it
end

umg.on("lootplot:entitySpawned", function(ent)
    if lp.isSlotEntity(ent) and isInTable(ent.baseTraits, "lootplot.content.s0:BOTANIC") then
        ent.growSpeed = 1
    end
    if lp.isItemEntity(ent) and ent.botanicGrowth then
        if ent.age == nil then
            ent.age = 0
        end
    end
end)

