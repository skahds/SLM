local loc = localization.newLocalizer()

lp.defineItem("botanics:basic_seed", {
    botanicGrowth = {
        {
            requiredAge = 1,
            -- transformTo = "ruby_axe"
            -- transformTo = server.entities[ruby_axe]
        }
    },

    name = "Basic Seed",
    image = "basic_seed",
    rarity = lp.rarities.COMMON,
    description = "Grows"
})