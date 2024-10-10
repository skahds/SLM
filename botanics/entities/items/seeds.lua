local loc = localization.newLocalizer()

local botanicStageBasicSeed = {
    {
        requiredAge = 1,
        transformTo = "ruby_axe"
        -- transformTo = "dragonfruit"
    }
}

lp.defineItem("botanics:basic_seed", {
    botanicGrowth = botanicStageBasicSeed,

    name = "Basic Seed",
    image = "basic_seed",
    rarity = lp.rarities.COMMON,
    description = "Grows into a " .. botanicStageBasicSeed[1].transformTo 
})
