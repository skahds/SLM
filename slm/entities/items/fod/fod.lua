local loc = localization.localize
local lootplot = lp


lp.defineItem("slm:pear",
{
    doomCount = 1,
    image = "pear",
    name = loc("Pear"),
    rarity = lp.rarities.UNCOMMON,
    shape = lp.targets.ON_SHAPE,

    target = {
        type = "SLOT",
        description = loc("{lootplot.targets:COLOR}Converts target slot into Turn Slot"),
        activate = function (selfEnt, ppos)
            local etype = server.entities.turn_slot
            local slotEnt = lp.forceSpawnSlot(ppos, etype, selfEnt.lootplotTeam)
            if slotModifier and slotEnt then
                slotModifier(slotEnt)
            end
        end
    }
})