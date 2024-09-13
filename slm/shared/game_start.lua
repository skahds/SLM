slm = {}

umg.on("@playerJoin", function(clientID)
    lp.forceSpawnSlot(lp.main.getContext():getPlot():getPPos(5,9), server.entities.shop_slot,clientID)
    lp.forceSpawnSlot(lp.main.getContext():getPlot():getPPos(6,9), server.entities.shop_slot,clientID)
    lp.forceSpawnSlot(lp.main.getContext():getPlot():getPPos(7,9), server.entities.shop_slot,clientID)
    -- lp.forceSpawnSlot(lp.main.getContext():getPlot():getPPos(6,12), server.entities.turn_slot,clientID)
    -- lp.forceSpawnItem(lp.main.getContext():getPlot():getPPos(10,8), server.entities.red_shield,clientID)
    -- lp.forceSpawnItem(lp.main.getContext():getPlot():getPPos(11,8), server.entities.quartz_glove,clientID)
end)