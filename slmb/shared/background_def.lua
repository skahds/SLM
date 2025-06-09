local W,H = 3000,1500
local minsize = 40
local DELTA = (minsize * lp.constants.WORLD_SLOT_DISTANCE) / 2

if client then

local cosmicBackground = require("client.cosmicBackground")
local cityBackground = require("client.cityBackground")

function cosmicBg()
    return cosmicBackground({
        worldX = -W/2 + DELTA, worldY = -H/2 + DELTA,
        worldWidth = W, worldHeight = H,
        numberOfStar = 100,

        backgroundColor = objects.Color("#" .. "FF0A091F"),
        starColorMin = {4, 7, 7},
    })
end

function heavenlyBg()
    return cosmicBackground({
        worldX = -W/2 + DELTA, worldY = -H/2 + DELTA,
        worldWidth = W, worldHeight = H,
        numberOfStar = 100,

        backgroundColor = objects.Color("#" .. "FF2B140A"),
        starColorMin = {7, 4, 4},
    })
end

function spikesBg()
    return cityBackground({
        worldX = -W/2 + DELTA, worldY = -H/2 + DELTA,
        worldWidth = W, worldHeight = H,
        numberOfBlock = 2000,
        blockColor = {8, 1, 1, 10, 2, 2},

        backgroundColor = objects.Color("#" .. "FF180303"),
    })
end

function spikes2Bg()
    return cityBackground({
        worldX = -W/2 + DELTA, worldY = -H/2 + DELTA,
        worldWidth = W, worldHeight = H,
        numberOfBlock = 5000,
        blockColor = {8, 1, 1, 10, 2, 2},

        backgroundColor = objects.Color("#" .. "FF180303"),
    })
end

end

local function returnTrue()
    return true
end

lp.backgrounds.registerBackground("slmb:cosmicBackground", {
    name = "Cosmic",
    constructor = cosmicBg,
    isUnlocked = returnTrue,
    icon = "cosmic_icon",
    fogColor = objects.Color("#" .. "FF060413")
})

lp.backgrounds.registerBackground("slmb:heavenlyBackground", {
    name = "Heavenly Dimension",
    constructor = heavenlyBg,
    isUnlocked = returnTrue,
    icon = "heavenly_icon",
    fogColor = objects.Color("#" .. "FF180606")
})

lp.backgrounds.registerBackground("slmb:spikesBackground", {
    name = "Spikes (DISCONTINUED)",
    constructor = spikesBg,
    isUnlocked = returnTrue,
    icon = "red_x",
    fogColor = objects.Color("#" .. "FF120101")
})

lp.backgrounds.registerBackground("slmb:spikes2Background", {
    name = "Spikesssssss (DISCONTINUED) (LAGGY)",
    constructor = spikes2Bg,
    isUnlocked = returnTrue,
    icon = "red_x",
    fogColor = objects.Color("#" .. "FF120101")
})