
umg.on("lootplot:entityActivated", function (ent)
    if lp.isSlotEntity(ent) and ent.growSpeed then
        local itemEnt = lp.slotToItem(ent)
        if itemEnt and itemEnt.botanicGrowth and lp.getPos(itemEnt)then
            itemEnt.age = itemEnt.age + ent.growSpeed
            
            local botanicTableNS = itemEnt.botanicGrowth

            table.sort(botanicTableNS, function (a, b)
                return a.requiredAge < b.requiredAge
            end)

            local botanicTable = botanicTableNS[1]
            if itemEnt.age >= botanicTable.requiredAge then
                    local newItem = server.entities[botanicTable.transformTo]
                    botanicLib.forceSpawnItem(lp.getPos(itemEnt), newItem, itemEnt.lootplotTeam) 
                    local spawnedItem = lp.posToItem(lp.getPos(ent))
                    lp.rarities.setEntityRarity(spawnedItem, itemEnt.rarity)

                    if itemEnt.botanicKeepGrowth == true then
                        botanicLib.addBotanicTableForSpawnedItem(spawnedItem, itemEnt)
                    end
            end
        end
    end    
end)
