local loc = localization.newLocalizer()

local function isInTable(table, element)
    if table == nil then return false end
    for i=1, #table do
        if element == table[i] then
            return true
        end
    end
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

umg.on("lootplot:entityActivated", function (ent)
    if lp.isSlotEntity(ent) and ent.growSpeed then
        local itemEnt = lp.slotToItem(ent)
        if itemEnt and itemEnt.botanicGrowth then
            itemEnt.age = itemEnt.age + ent.growSpeed
            for i, botanicTable in ipairs(itemEnt.botanicGrowth) do
                if itemEnt.age > botanicTable.requiredAge then

                    if server then
                        lp.forceSpawnItem(lp.getPos(itemEnt), server.entities.ruby_axe, itemEnt.lootplotTeam)     
                        print (server.entities.ruby_axe)
                    end
                    

                
                    break
                end
            end
        end
    end    
end)