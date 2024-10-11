local loc = localization.newLocalizer()
local botanicLib = {}



---check if it an item can grow or not
---@param itemEnt any
function botanicLib.tryGrow(itemEnt)

    if itemEnt.botanicGrowth then

    if lp.getPos(itemEnt) then
        -- if the item has a special grow condition
        if type(itemEnt.canGrow) == "function" then
            if itemEnt.canGrow(itemEnt) ~= true then
                return false
            end
        end

        -- the not-shuffled table
        local botanicTableNS = itemEnt.botanicGrowth

        table.sort(botanicTableNS, function (a, b)
            return a.requiredAge < b.requiredAge
        end)

        local botanicTable = botanicTableNS[1]
    
        if itemEnt.age >= botanicTable.requiredAge then
            -- initialize the spawnedItem
            local spawnedItem = nil
            if server then
                local newItem = server.entities[botanicTable.transformTo]
                spawnedItem = lp.forceSpawnItem(lp.getPos(itemEnt), newItem, itemEnt.lootplotTeam) 
            end

            
            if itemEnt.botanicKeepGrowth == true then
                spawnedItem.botanicKeepGrowth = true
                local newGrowthTable = itemEnt.botanicGrowth
                table.remove(newGrowthTable, 1)
    
                spawnedItem.botanicGrowth = newGrowthTable
                spawnedItem.age = itemEnt.age
    
    
                -- need to check if this is server since its serverside only
                if server then
                    lp.rarities.setEntityRarity(spawnedItem, itemEnt.rarity)
                end
            end
        end
    end
    end
end

umg.expose("botanicLib", botanicLib)