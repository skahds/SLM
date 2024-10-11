local function isInTable(table, element)
    if table == nil then return false end
    for i=1, #table do
        if element == table[i] then
            return true
        end
    end
end

local function defineInteger(compName)
    components.defineComponent(compName)
    sync.autoSyncComponent(compName, {
        type = "number",
        lerp = false,
    })
end

defineInteger("age")


umg.on("lootplot:entityActivated", function (ent)
    if lp.isSlotEntity(ent) and ent.growSpeed then
        local itemEnt = lp.slotToItem(ent)
        if itemEnt and itemEnt.botanicGrowth and lp.getPos(itemEnt)then
            itemEnt.age = itemEnt.age + ent.growSpeed

            botanicLib.tryGrow(itemEnt)
        end
    end    
end)

umg.on("lootplot:entitySpawned", function(ent)
    if lp.isSlotEntity(ent) and isInTable(ent.baseTraits, "lootplot.content.s0:BOTANIC") then
        ent.growSpeed = 1
    end
    if lp.isItemEntity(ent) and ent.botanicGrowth then
        if ent.age == nil then
            ent.age = 0
        end
        local botanicTableNS = ent.botanicGrowth
        table.sort(botanicTableNS, function (a, b)
            return a.requiredAge < b.requiredAge
        end)

    end
end)

