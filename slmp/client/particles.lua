local lootplot = lp

local function makeBallPS(count, extraComponents)
    extraComponents = extraComponents or {}
    local ball = love.graphics.newParticleSystem(client.atlas:getTexture(), count)
    ball:setQuads(
        assert(client.assets.images.ball_1),
        assert(client.assets.images.ball_2),
        assert(client.assets.images.ball_3),
        assert(client.assets.images.ball_4)
    )
    ball:setParticleLifetime(0.2, 0.5)
    ball:setLinearAcceleration(0, -10, 0, -30)
    ball:setEmissionArea("ellipse", extraComponents.rad or 10, extraComponents.rad or 10, 0, true)
    return ball
end

local function makeCoolParticle(ent, extraComponents)
    if ent.particleList == nil then
        ent.particleList = {}
    end

    local COUNT = extraComponents.count or 1
    local newEnt = client.entities.empty()
    if ent.x and ent.y then
        newEnt.x, newEnt.y = ent.x, ent.y
    end
    newEnt.dimension = ent.dimension
    local ps = makeBallPS(COUNT, {rad=extraComponents.rad})
    ps:setColors(unpack(extraComponents.color))
    ps:setEmissionRate(COUNT*100)
    ps:setBufferSize(1000)
    ps:setParticleLifetime(1)
    newEnt.particles = ps
    newEnt.drawDepth = extraComponents.drawDepth
    local extraComponents = {type = extraComponents.type or "normal"}
    table.insert(ent.particleList, {newEnt, extras = extraComponents})

end

umg.on("lootplot:entitySpawned", function(ent)
    if lp.isItemEntity(ent) then
        if lp.getPos(ent) then
            if ent.doomCount then
            makeCoolParticle(ent, {rad=8, drawDepth = -100, color = {0.7, 0.2, 0.3, 0.4}})
            makeCoolParticle(ent, {rad=4, drawDepth = -99, color = {0.5, 0.2, 0.8, 0.4}})
            end
            makeCoolParticle(ent, {rad=6, drawDepth = -98, color = {236/255, 146/255, 29/255, 0.5}, type= "modifier"})
            makeCoolParticle(ent, {rad=4, drawDepth = -97, color = {249/255, 200/255, 111/255, 0.5}, type= "modifier"})
            if  ent.rarity == lp.rarities.LEGENDARY then
                makeCoolParticle(ent, {rad=10, drawDepth= -110, color = {217/255, 87/255, 99/255, 0.8}, count = 3, type="legendary"})
                makeCoolParticle(ent, {rad=8, drawDepth= -109, color = {236/255, 147/255, 155/255, 0.8}, count = 2, type="legendary"})
            elseif ent.rarity == lp.rarities.MYTHIC then
                makeCoolParticle(ent, {rad=8, drawDepth= -109, color = {249/255, 247/255, 178/255, 0.8}, count = 2, type="mythic"})
                makeCoolParticle(ent, {rad=12, drawDepth= -110, color = {194/255, 163/255, 10/255, 0.6}, count = 5, type="mythic"})
            end
        end
    end
end)
-- lootplot:entitySpawned
umg.on("rendering:drawEntity", function (ent)
    if lp.isItemEntity(ent) and ent.particleList then
        for i, particle in ipairs(ent.particleList) do
            particle[1].particles:setPosition(ent.x, ent.y)
            particle[1].x, particle[1].y = ent.x, ent.y
            if particle.extras then
                if lp.getPos(ent) and lp.posToSlot(lp.getPos(ent)) and lp.posToSlot(lp.getPos(ent)).shopLock == true
                and (particle.extras.type == "legendary" or particle.extras.type == "mythic") then
                    particle[1].particles:start()
                elseif (particle.extras.type == "legendary" or particle.extras.type == "mythic") then
                    particle[1].particles:pause()
                end
                if particle.extras.type == "modifier" then
                    if ent.lootplotProperties then
                        if ent.lootplotProperties.multipliers or ent.lootplotProperties.modifier then
                            particle[1].particles:start()
                        else
                            particle[1].particles:pause()
                        end
                    else
                        particle[1].particles:pause()
                    end
                end
            end
        end
    end
end)