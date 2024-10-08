umg.on("@playerJoin", function(clientID)
    lp.forceSpawnItem(lp.main.getContext():getPlot():getPPos(9,6), server.entities.book_of_farming, clientID)
    lp.forceSpawnItem(lp.main.getContext():getPlot():getPPos(10,6), server.entities.basic_seed, clientID)
end)