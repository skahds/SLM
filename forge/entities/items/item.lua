local anvil_shape = {
    name = "ANVIL",
    relativeCoords = {
        {1, 1},
        {0, 1},
        {-1, 1},
        {0, -1},
    }
}

lp.defineItem("forge:floating_anvil", {
    name = "Floating Anvil",
    description = "Spawns the forge in its place, will spawn on target slots",
    image = "floating_anvil",
    rarity = lp.rarities.EPIC,
    canItemFloat = true,
    basePrice = 10,

    triggers = {"PULSE"},
    shape = anvil_shape,
    target = {
        type = "NO_SLOT",
        activate = function(selfEnt, ppos)
            local selfPos = lp.getPos(selfEnt)
            lp.trySpawnSlot(ppos, server.entities.forge_tile, selfEnt.lootplotTeam)
            if lp.posToSlot(selfPos) == nil or lp.posToSlot(selfPos).name ~= "Anvil Button" then
                lp.forceSpawnSlot(selfPos, server.entities.anvil_button, selfEnt.lootplotTeam)
                lp.forceSpawnSlot(selfPos:up(1), server.entities.forge_result, selfEnt.lootplotTeam)
            end
        end
    }
})