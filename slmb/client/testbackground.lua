---@class slmb.testBackground
local testBackground = objects.Class("slmb:testBackground"):implement(lp.backgrounds.IBackground)

local function generateStars(self, rng, args)
    local size = args.size or rng:random(3, 8)/10

    local star = {
        x = self.worldX + rng:random() * self.worldWidth,
        y = self.worldY + rng:random() * self.worldHeight,
        size = size,
        layerIndex = size,
        image = args.type,
        color = args.color
    }
    self.glowStars:add(star)
end

function testBackground:init(args)
    self.glowStars = objects.Array()

    self.backgroundColor = args.backgroundColor
    self.worldX = args.worldX
    self.worldY = args.worldY
    self.worldWidth = args.worldWidth
    self.worldHeight = args.worldHeight

    local rng = love.math.newRandomGenerator(love.math.getRandomSeed())

    for i=1, args.numberOfStar*50 do
        generateStars(self, rng, {type="glow_8",
        color={rng:random(4, 10)/10, rng:random(7, 10)/10, rng:random(7, 10)/10}})
    end

    for i=1, args.numberOfStar/2 do
        generateStars(self, rng, {type="glow_128", size = rng:random()/10+0.2,
        color={rng:random(4, 10)/10, rng:random(7, 10)/10, rng:random(7, 10)/10}})
    end
    
    for i=1, args.numberOfStar*8 do
        generateStars(self, rng, {type="sparkle_32",
        color={rng:random(4, 10)/10, rng:random(7, 10)/10, rng:random(7, 10)/10}})
    end

    table.sort(self.glowStars, function (a, b)
        return a.layerIndex < b.layerIndex
    end)
end


local function distToHorizontalEdge(self, star)
    local center = self.worldX + self.worldWidth/2
    local distFromCenter = math.abs(center - star.x)
    local distToEdge = self.worldWidth/2 - distFromCenter
    return distToEdge
end

local function updateStar(self, star, dt)
    local d = distToHorizontalEdge(self, star)
    if d < -10 then
        star.x = self.worldX - 5
    end
    star.x = star.x + star.layerIndex * 10 * dt
end


function testBackground:update(dt)
    for _, star in ipairs(self.glowStars)do
        updateStar(self, star, dt)
    end
end



local lg = love.graphics
local function drawGlowStars(self, star)
    lg.setColor(star.color)
    -- local cam = camera.get()
    -- local cx, cy = cam:getPos()
    rendering.drawImage(star.image, star.x, star.y, 0, star.size, star.size)
end


---@param opacity number
function testBackground:draw(opacity)
    love.graphics.setColor(self.backgroundColor * opacity)
    love.graphics.rectangle("fill", self.worldX, self.worldY, self.worldWidth, self.worldHeight)
    for _, star in ipairs(self.glowStars) do
        drawGlowStars(self, star)
    end
end

return testBackground
