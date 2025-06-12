local W,H = 3000,1500
local minsize = 40
local DELTA = (minsize * lp.constants.WORLD_SLOT_DISTANCE) / 2

local forestBg, forest2Bg, shapesBg, catBg, redSpaceBg, paradiseBg

if client then

local cosmicBackground = require("client.cosmicBackground")
local cityBackground = require("client.cityBackground")
local framworkBackground = require("client.frameworkBackground")

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

function forestBg()
    return cityBackground({
        worldX = -W/2 + DELTA, worldY = -H/2 + DELTA,
        worldWidth = W, worldHeight = H,
        numberOfBlock = 300,
        blockColor = {1, 6, 1, 2, 7, 2},

        backgroundColor = objects.Color("#" .. "FF020C01"),
    })
end

function forest2Bg()
    return cityBackground({
        worldX = -W/2 + DELTA, worldY = -H/2 + DELTA,
        worldWidth = W, worldHeight = H,
        numberOfBlock = 700,
        blockColor = {1, 6, 1, 2, 7, 2},

        backgroundColor = objects.Color("#" .. "FF020C01"),
    })
end

-- BELOW THIS ARE BACKGROUNDS THAT USES THE BACKGROUND FRAMEWORK
local function chooseRandom(rng, t)
    local num = rng:random() * (#t-1)
    return t[math.floor(num+0.5)+1]
end


function shapesBg()
    local getShapeColor = function (rng)
        local num = rng:random()
        if num > 2/3 then
            return {1, 0.7, 0.7}
        elseif num > 1/3 then
            return {0.7, 0.7, 1}
        else
            return {1, 1, 1}
        end
    end
    

    local numberOfShape = 100
    return framworkBackground({
        worldX = -W/2 + DELTA, worldY = -H/2 + DELTA,
        worldWidth = W, worldHeight = H,
        objectMovement = {5, -5},
        objectRotation = 0.05,


        load = function (self, generateObject)
            local rng = love.math.newRandomGenerator(love.math.getRandomSeed())

            local images = {"box_o", "box_x", "box", "cross", "box_select", "triangle_1x2", "triangle2_1x2"}
            for i=1, numberOfShape*5 do
                generateObject(self, rng, {type=chooseRandom(rng, images),
                color=getShapeColor(rng)})
            end
        end,

        backgroundColor = objects.Color("#" .. "FF212121"),
    })
end

function catBg()
    local numberOfShape = 300
    return framworkBackground({
        worldX = -W/2 + DELTA, worldY = -H/2 + DELTA,
        worldWidth = W, worldHeight = H,
        objectMovement = {5, -5},
        objectRotation = 0.05,


        load = function (self, generateObject)
            local rng = love.math.newRandomGenerator(love.math.getRandomSeed())

            local images = {"copycat", "dangerously_funny_cat", "chubby_cat",
            "copykitten", "midas_cat", "pink_cat", "crappy_cat", "evil_cat"}
            for i=1, numberOfShape*2 do
                generateObject(self, rng, {type=chooseRandom(rng, images), size=rng:random()+1,
                color={1, 1, 1}})
            end
        end,

        backgroundColor = objects.Color("#" .. "FF8ECDD8"),
    })
end

function redSpaceBg()
    local numberOfShape = 400
    return framworkBackground({
        worldX = -W/2 + DELTA, worldY = -H/2 + DELTA,
        worldWidth = W, worldHeight = H,
        objectMovement = {5, -5},
        objectRotation = 0.05,


        load = function (self, generateObject)
            local rng = love.math.newRandomGenerator(love.math.getRandomSeed())

            local images = {"hand1", "hand2", "hand3", "hand4", "hand5"}
            for i=1, numberOfShape do
                generateObject(self, rng, {type=chooseRandom(rng, images), size=(rng:random()+1)/5,
                color={1, 0, 0}})
            end
        end,

        backgroundColor = objects.Color("#" .. "FF360B0B"),
    })
end

function paradiseBg()
    local numberOfShape = 200
    return framworkBackground({
        worldX = -W/2 + DELTA, worldY = -H/2 + DELTA,
        worldWidth = W, worldHeight = H,
        objectMovement = {5, -5},
        objectRotation = 0.05,


        load = function (self, generateObject)
            local rng = love.math.newRandomGenerator(love.math.getRandomSeed())

            local images = {"hand1", "hand2", "hand3", "hand4", "hand5"}
            for i=1, numberOfShape do
                generateObject(self, rng, {type=chooseRandom(rng, images), size=(rng:random()+1)/5,
                color={1, 1, 1}})
            end

            local images2 = {"cloud1", "cloud2", "cloud3"}
            for i=1, numberOfShape do
                generateObject(self, rng, {type=chooseRandom(rng, images2), size=(rng:random()+1)/2,
                color={1, 1, 1}, rotationUpdate = 0, rot=0})
            end
        end,

        backgroundColor = objects.Color("#" .. "FFD7EBF0"),
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

lp.backgrounds.registerBackground("slmb:forestBackground", {
    name = "Forest",
    constructor = forestBg,
    isUnlocked = returnTrue,
    icon = "forest_icon",
    fogColor = objects.Color("#" .. "FF041201")
})

lp.backgrounds.registerBackground("slmb:forest2Background", {
    name = "Forest^2",
    constructor = forest2Bg,
    isUnlocked = returnTrue,
    icon = "forest_icon2",
    fogColor = objects.Color("#" .. "FF041201")
})

lp.backgrounds.registerBackground("slmb:shapesBackground", {
    name = "Shapes -skahd",
    constructor = shapesBg,
    isUnlocked = returnTrue,
    icon = "shapes_icon",
    fogColor = objects.Color("#" .. "FF1E1E1E")
})

lp.backgrounds.registerBackground("slmb:catBackground", {
    name = "Cat -skahd",
    constructor = catBg,
    isUnlocked = returnTrue,
    icon = "copycat",
    fogColor = objects.Color("#" .. "FF407EB4")
})

lp.backgrounds.registerBackground("slmb:redSpaceBackground", {
    name = "Red Space -skahd",
    constructor = redSpaceBg,
    isUnlocked = returnTrue,
    icon = "red_x",
    fogColor = objects.Color("#" .. "FF2A0909")
})

lp.backgrounds.registerBackground("slmb:paradiseBackground", {
    name = "Paradise -skahd",
    constructor = paradiseBg,
    isUnlocked = returnTrue,
    icon = "red_x",
    fogColor = objects.Color("#" .. "FF2D2D2D")
})