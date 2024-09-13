local loc = localization.localize
local function defineFood(entName, etype)
    etype.doomCount = etype.doomCount or 1

    lp.defineItem(entName, etype)
end

local function defineSlotSpawner(id_image, name, spawnSlot, spawnSlotName, targetShape, extraComponents, slotModifier)
    local entId = "slm:" .. id_image
    extraComponents = extraComponents or {}

    local etype = {
        image = id_image,
        name = loc(name),

        rarity = extraComponents.rarity or lp.rarities.UNCOMMON,
        minimumLevelToSpawn = 5,

        baseBuyPrice = 5,

        targetType = "NO_SLOT",
        targetActivationDescription = loc("{lp_targetColor}Spawns a " .. spawnSlotName),
        targetShape = targetShape,

        targetActivate = function (selfEnt, ppos)
            local etype = server.entities["lootplot.content.s0:" .. spawnSlot]
            assert(etype, "?")
            lp.trySpawnSlot(ppos, etype, selfEnt.lootplotTeam)
            if slotModifier and slotEnt then
                slotModifier(slotEnt, ppos, selfEnt)
            end
        end
    }

    for k,v in pairs(extraComponents) do
        etype[k] = v
    end

    defineFood(entId, etype)
end
local function defineSlotConverter(id_image, name, spawnSlot, spawnSlotName, targetShape, extraComponents)
    local entId = "slm:" .. id_image
    extraComponents = extraComponents or {}

    local etype = {
        image = id_image,
        name = loc(name),

        targetType = "SLOT",
        targetActivationDescription = loc("{lp_targetColor}Converts target slot into " .. spawnSlotName),
        targetShape = targetShape,

        targetActivate = function (selfEnt, ppos)
            local etype = server.entities["slm:" .. spawnSlot]
            assert(etype, "?")
            lp.forceSpawnSlot(ppos, etype, selfEnt.lootplotTeam)
        end
    }
    for k,v in pairs(extraComponents) do
        etype[k] = v
    end
    defineFood(entId, etype)
end


defineSlotSpawner("gold_apple", "God Apple", "golden_slot", "Golden Slot", lp.targets.UnionShape(lp.targets.KNIGHT_SHAPE, lp.targets.ON_SHAPE, lp.targets.QueenShape(5), "THE SUN"), {rarity = lp.rarities.EPIC})
defineSlotConverter("pear", "Pear", "turn_slot", "Turn Slot", lp.targets.ON_SHAPE)
