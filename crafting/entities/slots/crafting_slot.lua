local loc = localization.localize

-- where items get "sacrificed"
lp.defineSlot("crafting:crafting_slot", {
    image = "crafting_slot",
    name = loc("Crafting Slot"),

    activateDescription = loc("Crafts (STILL IN WIP)"),
    baseMaxActivations = 100,
    triggers = {"PULSE"},

    onActivate = function(slotEnt)
        local item = lp.slotToItem(slotEnt)
        if item then

            lp.destroy(item)
        end
    end
})

--where item output
lp.defineSlot("crafting:crafting_heart_slot", {
    image = "crafting_heart_slot",
    name = loc("Crafting Heart Slot"),

    activateDescription = loc("Heart of crafting (STILL IN WIP)"),
    baseMaxActivations = 100,
    triggers = {"PULSE"},

    onActivate = function(slotEnt)
        local item = lp.slotToItem(slotEnt)
        if item then

        end
    end
})

