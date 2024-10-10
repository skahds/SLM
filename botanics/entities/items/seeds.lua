local loc = localization.newLocalizer()

local botanicStageBasicSeed = {
    {
        requiredAge = 1,
        transformTo = "ruby_axe"
        -- transformTo = "dragonfruit"
    },
    {
        requiredAge = 3,
        transformTo = "quartz_glove"
    }
}

lp.defineItem("botanics:basic_seed", {
    botanicGrowth = botanicStageBasicSeed,
    botanicKeepGrowth = true,

    name = "Basic Seed",
    image = "basic_seed",
    rarity = lp.rarities.COMMON,
    description = "Grows into a " .. botanicStageBasicSeed[1].transformTo 
})
