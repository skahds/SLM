-- first molecule is pure name, resultant is id name
local loc = localization.localize

local function defineFactoryConverter(id, first_molecule, resultant)
    lp.defineItem("slm:" .. id, {
        plastic = true,
        image = "factory_template",
        name = loc(id .. " Factory"),
        rarity = lp.rarities.UNCOMMON,
        onActivate = function (item)
            selfPos = lp.getPos(item)
            local targitem = lp.posToItem(selfPos:down(1))
            print(targitem)
            if targitem and targitem.name == first_molecule then
                lp.trySpawnItem(selfPos:up(1), server.entities[resultant], item.lootplotTeam)
            end
        end
    })
end

local function defineFactoryProducer(id, spawnItem)
    lp.defineItem("slm:" .. id, {
        plastic = true,
        image = "factory_template",
        name = loc(spawnItem .. " Producer"),
        rarity = lp.rarities.UNCOMMON,
        onActivate = function (item)
            selfPos = lp.getPos(item)
            lp.trySpawnItem(selfPos:up(1), server.entities[spawnItem], item.lootplotTeam)
        end
    })
end

local function defineMolecule(id, name)
    lp.defineItem("slm:" .. id, {
        plastic = true,
        image = "molecule_template",
        name = loc(name),
        rarity = lp.rarities.UNCOMMON,
    })
end

defineFactoryProducer("water_pump", "water")
defineFactoryProducer("oil_rig", "oil")

defineFactoryConverter("boiler", "Water", "steam")
defineFactoryConverter("boiler", "Water", "steam")

defineMolecule("water", "Water")
defineMolecule("oil", "Oil")
defineMolecule("steam", "Steam")