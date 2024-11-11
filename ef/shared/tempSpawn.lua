local firstActive = false

umg.defineEvent("ef:playerJoin")
umg.on("lootplot:entityActivated", function (ent)
    if firstActive == false and ent.lootplotTeam then
        umg.call("ef:playerJoin", ent.lootplotTeam)
        firstActive = true
    end
end)

umg.on("ef:playerJoin", function (clientId)
    local run = lp.main.getRun()
    if run and server then
        local plot = run:getPlot()
        lp.forceSpawnItem(plot:getPPos(20,21), server.entities.slime, ef.team)
    end
end)