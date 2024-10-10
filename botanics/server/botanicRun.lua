
umg.on("lootplot:entityActivated", function (ent)
    if lp.isSlotEntity(ent) and ent.growSpeed then
        local itemEnt = lp.slotToItem(ent)
        if itemEnt and itemEnt.botanicGrowth and lp.getPos(itemEnt)then
            itemEnt.age = itemEnt.age + ent.growSpeed
            for i, botanicTable in ipairs(itemEnt.botanicGrowth) do
                if itemEnt.age > botanicTable.requiredAge then
                        local newItem = server.entities[botanicTable.transformTo]
                        botanicLib.forceSpawnItem(lp.getPos(itemEnt), newItem, itemEnt.lootplotTeam) 
                        local spawnedItem = lp.posToItem(lp.getPos(ent))
                        lp.rarities.setEntityRarity(spawnedItem, itemEnt.rarity)
                    break
                end
            end
        end
    end    
end)