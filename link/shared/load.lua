local midPosX = 30
local midPosY = 20

umg.on("firstactivate:playerJoin", function (clientId)
    if server then
        local run = lp.singleplayer.getRun()
        local plot = run:getPlot()


        lp.forceSpawnItem(plot:getPPos(midPosX,midPosY), server.entities.iron_sword, clientId)
        lp.forceSpawnItem(plot:getPPos(midPosX-1,midPosY), server.entities.iron_sword, clientId)
        lp.forceSpawnItem(plot:getPPos(midPosX+1,midPosY), server.entities.pulse_linker, clientId)
    end
end)