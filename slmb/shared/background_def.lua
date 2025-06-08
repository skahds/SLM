local W,H = 3000,1500
local minsize = 40
local DELTA = (minsize * lp.constants.WORLD_SLOT_DISTANCE) / 2

if client then

local testBackground = require("client.testbackground")

function testBack()
    return testBackground({
        worldX = -W/2 + DELTA, worldY = -H/2 + DELTA,
        worldWidth = W, worldHeight = H,
        numberOfStar = 100,

        backgroundColor = objects.Color("#" .. "FF101142"),
        cloudColor = objects.Color("#" .. "FF000000"),
    })
end

end

local function returnTrue()
    return true
end

lp.backgrounds.registerBackground("slmb:testBackground", {
    name = "Test",
    constructor = testBack,
    isUnlocked = returnTrue,
    icon = "void_background",
    fogColor = objects.Color("#" .. "FF000000")
})