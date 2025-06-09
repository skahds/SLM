---@class slmb.cityBackground
local cityBackground = objects.Class("slmb:cityBackground"):implement(lp.backgrounds.IBackground)


local function spawnBlock(self, rng, args)
    local size = args.size or rng:random(8, 15)/10
    local x = self.worldX + rng:random() * self.worldWidth
    local y = self.worldY + rng:random() * self.worldHeight
    local rot = rng:random(-314, 314)/100
    local topLayer = args.topLayer or args.z

    for i=1, args.z do
        local color = {args.color[1]*(i/args.z), args.color[2]*(i/args.z), args.color[3]*(i/args.z)}
        local block = {
            x=x,
            y=y,
            rot=rot,
            size=size,
            layerIndex = topLayer - args.z + i,
            topLayer = topLayer,
            image = args.image,
            color = color,
        }
        self.blocks:add(block)
    end
end

function cityBackground:init(args)
    self.blocks = objects.Array()

    self.backgroundColor = args.backgroundColor
    self.worldX = args.worldX
    self.worldY = args.worldY
    self.worldWidth = args.worldWidth
    self.worldHeight = args.worldHeight

    self.blockColor = args.blockColor

    local rng = love.math.newRandomGenerator(love.math.getRandomSeed())
    -- for i=1, args.numberOfBlock do
    --     local color = {
    --     rng:random(self.blockColor[1], self.blockColor[4])/10,
    --     rng:random(self.blockColor[2], self.blockColor[5])/10,
    --     rng:random(self.blockColor[3], self.blockColor[6])/10}

    --     local randnum = rng:random()
    --     local image
    --     if randnum > 0.6 then
    --         image = "block1_32"
    --     elseif randnum > 0.3 then
    --         image = "block4_32"
    --     else
    --         image = "block3_32"
    --     end
    --     spawnBlock(self, rng, {z=10, image=image, size = rng:random(13, 18)/10, color=color})
    -- end
    
    for i=1, args.numberOfBlock do
        local color = {
        rng:random(self.blockColor[1], self.blockColor[4])/10,
        rng:random(self.blockColor[2], self.blockColor[5])/10,
        rng:random(self.blockColor[3], self.blockColor[6])/10}
        
        spawnBlock(self, rng, {z=10, image="spike_8", size = rng:random(13, 18)/10, color=color})
    end

    table.sort(self.blocks, function (a, b)
        return a.layerIndex < b.layerIndex
    end)
end



local function distToHorizontalEdge(self, block)
    local center = self.worldX + self.worldWidth/2
    local distFromCenter = math.abs(center - block.x)
    local distToEdge = self.worldWidth/2 - distFromCenter
    return distToEdge
end

local function distToVerticalEdge(self, block)
    local center = self.worldY + self.worldHeight/2
    local distFromCenter = math.abs(center - block.y)
    local distToEdge = self.worldHeight/2 - distFromCenter
    return distToEdge
end


local function updateBlock(self, block, dt)
    if distToHorizontalEdge(self, block) < -10 then
        block.x = self.worldX-5
    end
    if distToVerticalEdge(self, block) < -10 then
        block.y = self.worldY-5
    end
    block.x = block.x + 3 * dt
    block.y = block.y + 3 * dt
end

function cityBackground:update(dt)
    for _, block in ipairs(self.blocks)do
        updateBlock(self, block, dt)
    end
end

local lg = love.graphics

local camCenterX = 780
local camCenterY = 520
local function drawBlock(self, block)
    lg.setColor(block.color)
    local cam = camera.get()
    local cx, cy = cam:getPos()
    -- cx = cx - camCenterX
    -- cy = cy - camCenterY
    -- local xDisplacement = (cx-block.x)/30 * ((block.layerIndex/5)+1)
    -- local yDisplacement = (cy-block.y)/30 * ((block.layerIndex/5)+1)
    local xDisplacement = (cx-block.x)/50 * ((block.topLayer-block.layerIndex)/3 + 1)
    local yDisplacement = (cy-block.y)/50 * ((block.topLayer-block.layerIndex)/3 + 1)
    local size = block.size*(block.topLayer-block.layerIndex+5)/3
    rendering.drawImage(block.image, block.x+xDisplacement, block.y+yDisplacement, block.rot, size, size)
end

function cityBackground:draw(opacity)
    love.graphics.setColor(self.backgroundColor * opacity)
    love.graphics.rectangle("fill", self.worldX, self.worldY, self.worldWidth, self.worldHeight)
    for _, block in ipairs(self.blocks) do
        drawBlock(self, block)
    end
end

return cityBackground