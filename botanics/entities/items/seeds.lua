local loc = localization.newLocalizer()

local botanicStageBasicSeed = {
    {
        requiredAge = 3,
        transformTo = "crop_stage_2"
        -- transformTo = "dragonfruit"
    }
}

lp.defineItem("botanics:basic_seed", {
    botanicGrowth = botanicStageBasicSeed,
    -- botanicKeepGrowth = false,

    name = "Basic Seed",
    image = "basic_seed",
    rarity = lp.rarities.COMMON,
    description = "Grows into a " .. botanicStageBasicSeed[1].transformTo 
})

lp.defineItem("botanics:crop_stage_2", {
    botanicGrowth = 
    {{
        requiredAge = 1,
        transformTo = "stone_rose"
    }},
    name = "Growing plant",
    image = "crop_stage_2"
    
})

lp.defineItem("botanics:stone_rose", {
    name = "Stone Rose",
    image = "stone_rose"
    
})

lp.defineItem("botanics:water_can", {
    name = "Watering Can",
    image = "water_can",
    rarity = lp.rarities.RARE,

    shape = lp.targets.RookShape(1),
    target = {
    type = "ITEM_OR_SLOT",
    description = loc("{lp_targetColor}Increases the age of by 1 for target items"),
    activate = function (selfEnt, ppos, targetEnt)
        if targetEnt.age then
            targetEnt.age = targetEnt.age + 1
            botanicLib.tryGrow(targetEnt)
        end
    end
    }

})