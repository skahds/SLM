slm = {
    debugMode = true
}


umg.on("@playerJoin", function(clientID)
    lp.forceSpawnSlot(lp.main.getContext():getPlot():getPPos(5,9), server.entities.shop_slot,clientID)
    lp.forceSpawnSlot(lp.main.getContext():getPlot():getPPos(6,9), server.entities.shop_slot,clientID)
    lp.forceSpawnSlot(lp.main.getContext():getPlot():getPPos(7,9), server.entities.shop_slot,clientID)

    if slm.debugMode == true then
    lp.forceSpawnSlot(lp.main.getContext():getPlot():getPPos(12,12), server.entities.turn_slot,clientID)
    lp.forceSpawnItem(lp.main.getContext():getPlot():getPPos(9,8), server.entities.torch,clientID)
    lp.forceSpawnItem(lp.main.getContext():getPlot():getPPos(6,7), server.entities.quartz_glove,clientID)
    lp.forceSpawnItem(lp.main.getContext():getPlot():getPPos(7,7), server.entities.ruby_axe,clientID)
    lp.forceSpawnItem(lp.main.getContext():getPlot():getPPos(10,8), server.entities.glass_bottle,clientID)
    lp.forceSpawnItem(lp.main.getContext():getPlot():getPPos(11,8), server.entities.ruby_sword,clientID)
    end
    
end)