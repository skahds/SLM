
umg.on("lootplot:entityActivated", function (ent)
    if lp.isSlotEntity(ent) and ent.growSpeed then
        local itemEnt = lp.slotToItem(ent)
        if itemEnt and itemEnt.botanicGrowth and lp.getPos(itemEnt)then
            itemEnt.age = itemEnt.age + ent.growSpeed
            -- the not-shuffled table
            local botanicTableNS = itemEnt.botanicGrowth

            table.sort(botanicTableNS, function (a, b)
                return a.requiredAge < b.requiredAge
            end)

            local botanicTable = botanicTableNS[1]
            if itemEnt.age >= botanicTable.requiredAge then
                if server then
                    local newItem = server.entities[botanicTable.transformTo]
                    botanicLib.forceSpawnItem(lp.getPos(itemEnt), newItem, itemEnt.lootplotTeam) 
                end
                
                local spawnedItem = lp.posToItem(lp.getPos(ent))

                if itemEnt.botanicKeepGrowth == true then
                    spawnedItem.botanicKeepGrowth = true
                    local newGrowthTable = itemEnt.botanicGrowth
                    table.remove(newGrowthTable, 1)

                    spawnedItem.botanicGrowth = newGrowthTable
                    spawnedItem.age = itemEnt.age

                    -- need to check if this is server
                    if server then
                        lp.rarities.setEntityRarity(spawnedItem, itemEnt.rarity)
                    end
                end
            end
        end
    end    
end)
