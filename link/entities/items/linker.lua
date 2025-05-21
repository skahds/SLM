local helper = require("helper")

local loc = localization.localize
local interp = localization.newInterpolator

local function defineLinker(name, image, trigger)
    lp.defineItem("link:" .. image, {
        name = name,
        image = image,
        activateDescription = loc("Links target items through {lootplot:TRIGGER_COLOR}%{TRIGGER}{/lootplot:TRIGGER_COLOR}",
        {TRIGGER = trigger}),

        rarity = lp.rarities.RARE,

        init = helper.rotateRandomly,
        foodItem = true,

        shape = lp.targets.VerticalShape(1),
        selfIndexLinker = #linkerMod.linkGroup,

        target = {
            type = "ITEM",
            activate = function (selfEnt, ppos, targetEnt)
                local linkTable
                if linkerMod.linkGroup[selfEnt.selfIndexLinker+1] == nil then
                    table.insert(linkerMod.linkGroup, {})
                    linkerMod.linkGroup[#linkerMod.linkGroup] = {trigger = "PULSE", item = {}, storage = {}}
                    print("made new table " .. selfEnt.selfIndexLinker, #linkerMod.linkGroup, linkerMod.linkGroup[#linkerMod.linkGroup].trigger)
                end
                linkTable = linkerMod.linkGroup[#linkerMod.linkGroup]
                table.insert(linkTable.item, targetEnt)
                targetEnt.linkGroup = linkTable
            end
        }
    })
end

defineLinker("Pulse Linker", "pulse_linker", "PULSE")