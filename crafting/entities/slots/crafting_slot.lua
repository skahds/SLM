local loc = localization.localize

-- where items get "sacrificed"
lp.defineSlot("crafting:crafting_slot", {
    image = "crafting_slot",
    name = loc("Crafting Slot"),

    activateDescription = loc("Crafts (STILL IN WIP)"),
    baseMaxActivations = 100,
    triggers = {"PULSE"},
    baseCanSlotPropagate = false
})

--where item output
lp.defineSlot("crafting:crafting_heart_slot", {
    image = "crafting_heart_slot",
    name = loc("Crafting Heart Slot"),

    activateDescription = loc("Heart of crafting (STILL IN WIP)"),
    baseMaxActivations = 100,
    triggers = {"PULSE"},
    baseCanSlotPropagate = false,
    storageList = {},


    onActivate = function(slotEnt)
        local selfPos = lp.getPos(slotEnt)
        local targ = lp.targets.KING_SHAPE
        for i, coord in ipairs(targ.relativeCoords) do
            local targetSlotPos = selfPos:move(coord[1], coord[2])
            if targetSlotPos and lp.posToSlot(targetSlotPos)  then
                local targetSlot = lp.posToSlot(targetSlotPos)
                if targetSlot.image == "crafting_slot" then
                    local targetItem = lp.slotToItem(targetSlot)
                    if targetItem then
                        if slotEnt.storageList[targetItem.name] == nil then
                            slotEnt.storageList[targetItem.name]= 1
                        else
                            slotEnt.storageList[targetItem.name] = slotEnt.storageList[targetItem.name] + 1
                        end

                        lp.destroy(targetItem)
                    end
                end
            end
        end
        for i, recipe in pairs(craftingLib.recipes) do
            local craftingFinished = true

            for ingredient, amount in pairs(recipe.ingredient) do
                local sacrificedItem = slotEnt.storageList[ingredient]
                if sacrificedItem and sacrificedItem >= amount then

                else
                    craftingFinished = false
                    break
                end
            end

            if craftingFinished then
                if lp.trySpawnItem(selfPos, server.entities[recipe.result], slotEnt.lootplotTeam) then
                    for ingredient, amount in pairs(recipe.ingredient) do
                        local sacrificedItem = slotEnt.storageList[ingredient]
                        sacrificedItem = sacrificedItem - amount
                    end
                end
            end
            break
        end
    end
})

