local loc = localization.localize
local lootplot = lp
local ef = ef

ef.defineEnemy("efxample:slime", {
    image = "slime",
    name = loc("slime"),
    rarity = lp.rarities.ENEMY,

    baseMaxActivations = 1,
    shape = lp.targets.ABOVE_SHAPE,
    ai = ef.ai.attack,
    target = {
        type = "ITEM",
        description = loc("Destroys items"),
        activate = function (selfEnt, ppos, targetEnt)
            lp.destroy(targetEnt)
        end
    }
})


ef.defineEnemy("efxample:activator", {
    image = "activator",
    name = loc("Activator"),
    rarity = lp.rarities.ENEMY,
    ai = ef.ai.support,
    baseMaxActivations = 1,
    shape = lp.targets.KING_SHAPE,
    target = {
        type = "ITEM",
        description = loc("Activates other enemy"),
        activate = function (selfEnt, ppos, targetEnt)
            lp.tryTriggerEntity("ENEMY_PULSE", targetEnt)
        end
    }
})

-- ef.defineEnemy("efxample:god", {
--     image = "g",
--     name = loc("nameless deity"),
--     rarity = lp.rarities.ENEMY,
--     ai = ef.ai.nothing,
--     baseMaxActivations = 1,
--     lives = 9999999999999999999,
--     drawDepth = 200,
--     shape = lp.targets.UnionShape(lp.targets.QueenShape(10), lp.targets.LARGE_KING_SHAPE, "INF"),
--     target = {
--         type = "ITEM_OR_SLOT",
--         description = loc(" DECIMATE "),
--         activate = function (selfEnt, ppos, targetEnt)
--             if lp.isItemEntity(targetEnt) then
--                 lp.destroy(targetEnt)
--                 if lp.itemToSlot(targetEnt) then
--                     lp.destroy(lp.itemToSlot(targetEnt))
--                 end
--             end
--             lp.destroy(targetEnt)
--             lp.setPoints(selfEnt, -9999999999999999999)
--             lp.setMoney(selfEnt, -9999999999999999999)
            
--         end
--     }  
-- })