local loc = localization.localize
local lootplot = lp

ef.defineEnemy("efxample:slime", {
    image = "slime",
    name = loc("Slime"),
    rarity = lp.rarities.ENEMY,

    baseMaxActivations = 1,
    shape = lp.targets.ABOVE_SHAPE,
    description = loc("Destroys item directly above it"),
    target = {
        type = "ITEM_OR_SLOT",
        description = loc("destroy"),
        activate = function (selfEnt, ppos, targetEnt)
            lp.destroy(targetEnt)
        end
    }
})


ef.defineEnemy("efxample:activator", {
    image = "activator",
    name = loc("Activator"),
    rarity = lp.rarities.ENEMY,

    baseMaxActivations = 1,
    shape = lp.targets.KING_SHAPE,
    description = loc("activates nearby enemy"),
    target = {
        type = "ITEM",
        description = loc("activate"),
        activate = function (selfEnt, ppos, targetEnt)
            lp.tryTriggerEntity("ENEMY_PULSE", targetEnt)
        end
    }
})
