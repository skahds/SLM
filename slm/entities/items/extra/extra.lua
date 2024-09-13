local loc = localization.localize

lp.defineItem("slm:rocket", {
    image = "rocket",
    name = loc("rocket"),
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