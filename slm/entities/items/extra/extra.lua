local loc = localization.localize


lp.defineItem("slm:rocket", {
    image = "rocket",
    name = loc("Rocket"),
    rarity = lp.rarities.COMMON,

    pointM = 10,
    baseBuyPrice = 3,
    baseMaxActivations = 20,
    description = loc("{lp_targetColor}Generates points based on total flight amount"),
    onActivate = function (selfEnt)
        local ppos = lp.getPos(selfEnt)
        if lp.posToSlot(ppos:up(1)) then
        lp.swapItems(ppos, ppos:up(1))
        end
        lp.addPoints(selfEnt, selfEnt.pointM)
        if selfEnt.pointM < 100 then selfEnt.pointM = selfEnt.pointM + 8
        elseif selfEnt.pointM < 1000 then selfEnt.pointM = selfEnt.pointM + 1.05 + 10
        else selfEnt.pointM = selfEnt.pointM * 1.01 end
    end
})


lp.defineItem("slm:dark_mirror", {
    image = "dark_mirror",
    name = loc("Dark mirror"),
    rarity = lp.rarities.COMMON,

    itemStored = {},
    shape = lp.targets.KING_SHAPE,
    target = {
        type = "SLOT",
        description = loc("{lp_targetColor}Stores item inside of it"),
        activate = function (selfEnt, ppos, targetEnt)
            local targetItemEnt = lp.slotToItem(targetEnt)
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
                local slotIndex = lp.getPos(targetEnt).slot
                selfEnt.itemStored[slotIndex] = copyEnt
                lp.destroy(targetItemEnt)
            end
        end
    }
})


lp.defineItem("slm:glass_flute", {
    image = "glass_flute",
    name = loc("Glass flute"),
    rarity = lp.rarities.UNCOMMON,
    baseMaxActivations = 7,
    doomCount = 1,
    shape = lp.targets.KING_SHAPE,
    target = {
        type = "ITEM",
        description = loc("{lp_targetColor}Triggers all surroundding item and giving them +1 max activation"),
        activate = function(selfEnt, ppos, targetEnt)
            lp.tryTriggerEntity("PULSE", targetEnt)
            lp.modifierBuff(targetEnt, "maxActivations", 1, selfEnt)
        end
    }
})
-- local torchShape = {
--     name = "Below Fan",
--     relativeCoords = {
--         {-1, 1},
--         {0, 1},
--         {1, 1}
--     }
-- }
-- lp.defineItem("slm:torch", {
--     image = "torch",
--     name = loc("Torch"),
--     rarity = lp.rarities.RARE,

--     baseMaxActivations = 1,
--     description = loc("Destroys item directly above it"),
--     shape = torchShape,
--     target = {
--     type = "ITEM_OR_SLOT",
--     description = loc("{lp_targetColor}If above item gets destroyed, first of the target item gets {c r=0.4 g=0.4}+2{/c} point generation and +1 max activation"),
--     activate = function (selfEnt, ppos, targetEnt)
--         local selfPpos = lp.getPos(selfEnt)
--         if selfPpos then
--         if lp.posToItem(selfPpos:up(1)) then
--             lp.destroy(lp.posToItem(selfPpos:up(1)))
--             lp.tryTriggerEntity("PULSE", targetEnt)
--             lp.modifierBuff(targetEnt, "pointsGenerated", 2, selfEnt)
--             lp.modifierBuff(targetEnt, "maxActivations", 1, selfEnt)
--         end
--         end 
--     end
--     }
-- })

--[[
lp.defineItem("slm:dual_sword", {
    image = "dual_sword",
    name = loc("Dual Sword"),
    


    targetType = "SLOT",
    targetShape = lp.targets.BishopShape(3),
    targetActivationDescription = loc("Chance to destroy target item/plot. buffs target item/plot"),
    targetActivate = function (selfEnt, ppos, targetSlot)
        local targetEnt = lp.slotToItem(targetSlot) or targetSlot
        if love.math.random() > 0.5 then
            lp.destroy(targetEnt)
        end
        if love.math.random() > 0.5 then
            lp.modifierBuff(targetEnt, "pointsGenerated", 3)
        else
            lp.multiplierBuff(targetEnt, "pointsGenerated", 1.5)
        end
    end
})
]]

-- lp.craft = {}
-- ---@param name string
-- ---@param itemType table<string, any>
-- ---@param ... table contains relativeCoords and itemName
-- function lp.defineCraft(name, itemType, ...)
--     local recipe = {items={}, result=name}
--     for i, item in ipairs(...) do
--         table.insert(recipe.items, {item.relativeCoords, item.name})
--     end
--     itemType.rarity = itemType.rarity or lp.rarities.UNIQUE
--     lp.defineItem(name, itemType)
-- end

-- -- example item.relativeCoords = {1, 2}
-- umg.defineEvent("slm:craftSlotActivate")
-- umg.on("slm:craftSlotActivate", function (slotPos)
--     local targetItem = lp.posToItem(slotPos)
--     local targetSlot = lp.posToSlot(slotPos)
--     local result = nil
--     if targetSlot and targetSlot.craft and not targetSlot.craft.craftFail then

--     local match = false
--     for _, recipe in lp.craft do
--         local allFound = true
--         for _, relativeCoords in recipe.relativeCoords do
--             local found = false
--             -- BFS? found = true
--             if not found then
--                 allFound = false
--                 break
--             end
--         end
--         if allFound then
--             match = true
--             result = recipe.result
--             break
--         end
--     end
--     if match and result then
--         lp.trySetItem(slotPos, result)    
--     end

--     end
-- end)
