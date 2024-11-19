umg.on("firstactivate:playerJoin", function (clientId)
    local run = lp.main.getRun()
    if run and server then
        local plot = run:getPlot()
        for i=0, 8 do
            lp.forceSpawnSlot(plot:getPPos(23+i%3,19+math.floor(i/3)), server.entities.crafting_slot, clientId)
        end
        lp.forceSpawnSlot(plot:getPPos(24, 20), server.entities.crafting_heart_slot, clientId)
    end
end)