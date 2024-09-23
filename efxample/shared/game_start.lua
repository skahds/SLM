
umg.on("@playerJoin", function(clientID)
    -- lp.forceSpawnItem(lp.main.getContext():getPlot():getPPos(9,6), server.entities.activator, ef.team)
    lp.forceSpawnItem(lp.main.getContext():getPlot():getPPos(9,7), server.entities.slime, ef.team)
    lp.forceSpawnItem(lp.main.getContext():getPlot():getPPos(10,7), server.entities.activator, clientID)
end)
--ef.team


