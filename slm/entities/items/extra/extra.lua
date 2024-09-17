local loc = localization.localize

-- local function equals(o1, o2, ignore_mt)
--     if o1 == o2 then return true end
--     local o1Type = type(o1)
--     local o2Type = type(o2)
--     if o1Type ~= o2Type then return false end
--     if o1Type ~= 'table' then return false end

--     if not ignore_mt then
--         local mt1 = getmetatable(o1)
--         if mt1 and mt1.__eq then
--             --compare using built in method
--             return o1 == o2
--         end
--     end

--     local keySet = {}

--     for key1, value1 in pairs(o1) do
--         local value2 = o2[key1]
--         if value2 == nil or equals(value1, value2, ignore_mt) == false then
--             return false
--         end
--         keySet[key1] = true
--     end

--     for key2, _ in pairs(o2) do
--         if not keySet[key2] then return false end
--     end
--     return true
-- end




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

--
lp.defineItem("slm:dark_mirror", {
    image = "dark_mirror",
    name = loc("Dark mirror"),

    itemStored = {},
    targetType = "SLOT",
    targetActivationDescription = loc("{lp_targetColor}Stores item inside of it"),
    targetShape = lp.targets.KING_SHAPE,

    targetActivate = function (selfEnt, ppos, slotEnt)
        local targetItemEnt = lp.posToItem(ppos)
        if selfEnt.itemStored ~= nil then
            if selfEnt.itemStored[ppos.slot] then
                local success = lp.trySetItem(ppos, selfEnt.itemStored[ppos.slot])
                if success then
                    selfEnt.itemStored[ppos.slot] = nil
                end
            end
        end
        if targetItemEnt then
            local copyEnt = lp.clone(targetItemEnt)
            local slotIndex = lp.getPos(slotEnt).slot
            selfEnt.itemStored[slotIndex] = copyEnt
            lp.destroy(targetItemEnt)
        end
    end
})


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

