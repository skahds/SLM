lp.defineSlot("forge:anvil_button", {
    name = "Anvil Button",
    description = "Press to forge from the three slots below, items must be of same rarity!",
    rarity = lp.rarities.EPIC,

    image = "anvil_up",
    activateAnimation = {
        activate = "anvil_down",
        idle = "anvil_up",
        duration = 0.25
    },
    baseMaxActivations = 5,
    buttonSlot = true,
    onActivate = function (ent)
        local selfPos = lp.getPos(ent)
        local downPos = selfPos:down(1)
        local item1 = lp.posToItem(downPos)
        local item2 = lp.posToItem(downPos:left())
        local item3 = lp.posToItem(downPos:right())
        if item1 and item2 and item3 and item1.rarity and item2.rarity and item3.rarity then
            if item1.rarity.id == item2.rarity.id and item2.rarity.id == item3.rarity.id then
                local rarity = item1.rarity

                lp.destroy(lp.posToItem(downPos))
                lp.destroy(lp.posToItem(downPos:left()))
                lp.destroy(lp.posToItem(downPos:right()))

                local etype = lp.rarities.randomItemOfRarity(lp.rarities.shiftRarity(rarity, 1))
                    or server.entities[lp.FALLBACK_NULL_ITEM]
                lp.trySpawnItem(selfPos:up(), etype, ent.lootplotTeam)
            end
        end
    
    end
})

lp.defineSlot("forge:forge_tile", {
    name = "Forge Tile",
    image = "forge_tile",
    description = "Items on it won't activate.",
    rarity = lp.rarities.COMMON,
    triggers = {"PULSE"},
    dontPropagateTriggerToItem = true,
    isItemListenBlocked = true,
})

lp.defineSlot("forge:forge_result", {
    name = "Forge Result",
    image = "forge_result",
    description = "Items on it won't activate.",
    rarity = lp.rarities.COMMON,
    triggers = {"PULSE"},
    dontPropagateTriggerToItem = true,
    isItemListenBlocked = true,
})