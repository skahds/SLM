local loc = localization.localize

lp.defineItem("slm:rocket", {
    image = "rocket",
    name = loc("Rocket"),
    rarity = lp.rarities.RARE,

    pointM = 10,
    minimumLevelToSpawn = 3,
    baseBuyPrice = 3,
    baseMaxActivations = 20,
    description = loc("{lp_targetColor}Generates points based on total flight amount"),
    onActivate = function (selfEnt)
        local ppos = lp.getPos(selfEnt)
        if lp.posToSlot(ppos:up(1)) then
        if lp.canSwap(selfEnt, lp.posToSlot(ppos:up(1))) then
        lp.swapItems(selfEnt, lp.posToSlot(ppos:up(1)))
        end
        end
        lp.addPoints(selfEnt, selfEnt.pointM)
        if selfEnt.pointM < 100 then selfEnt.pointM = selfEnt.pointM + 8
        elseif selfEnt.pointM < 1000 then selfEnt.pointM = selfEnt.pointM + 1.05 + 10
        else selfEnt.pointM = selfEnt.pointM * 1.01 end
    end
})

--[[
lp.defineItem("slm:dark_mirror", {
    image = "dark_mirror",
    name = loc("Dark mirror"),

    itemStored = {},
    targetType = "SLOT",
    targetActivationDescription = loc("{lp_targetColor}Stores item inside of it"),
    targetShape = lp.targets.ABOVE_SHAPE,

    targetActivate = function (selfEnt, ppos, slotEnt)
        local targetItemEnt = lp.posToItem(ppos)
        if targetItemEnt then
            table.insert(selfEnt.itemStored, {TargetItemEnt, ppos})
            lp.destroy(targetItemEnt)
        else
            -- if selfEnt.itemStored ~= nil then
            --     for i, item in ipairs(selfEnt.itemStored) do
            --         lp.trySpawnItem(item[2], item[1],  "team yeah")
            --     end
            -- end
        end
    end
})
]]

lp.defineItem("slm:glass_flute", {
    image = "glass_flute",
    name = loc("Glass flute"),
    rarity = lp.rarities.UNCOMMON,
    doomCount = 1,
    targetType = "ITEM",
    baseMaxActivations = 7,
    targetShape = lp.targets.KING_SHAPE,
    targetActivationDescription = loc("{lp_targetColor}Triggers all surroundding item and giving them +1 max activation"),
    targetActivate = function(selfEnt, ppos, targetEnt)
        lp.tryTriggerEntity("PULSE", targetEnt)
        lp.modifierBuff(targetEnt, "maxActivations", 1, selfEnt)
    end
})
local torchShape = {
    name = "Below Fan",
    relativeCoords = {
        {-1, 1},
        {0, 1},
        {1, 1}
    }
}
lp.defineItem("slm:torch", {
    image = "torch",
    name = loc("Torch"),
    minimumLevelToSpawn = 2,
    rarity = lp.rarities.RARE,

    baseMaxActivations = 1,
    description = loc("Destroys item directly above it"),
    targetType = "ITEM",
    targetShape = torchShape,
    targetActivationDescription = loc("{lp_targetColor}If above item gets destroyed, one of the target item gets {c r=0.4 g=0.4}+2{/c} point generation and +1 max activation"),
    targetActivate = function (selfEnt, ppos, targetEnt)
        local selfPpos = lp.getPos(selfEnt)
        if selfPpos then
        if lp.posToItem(selfPpos:up(1)) then
            lp.destroy(lp.posToItem(selfPpos:up(1)))
            
            lp.tryTriggerEntity("PULSE", targetEnt)
            lp.modifierBuff(targetEnt, "pointsGenerated", 2, selfEnt)
            lp.modifierBuff(targetEnt, "maxActivations", 1, selfEnt)
        end
        end 
    end
})

