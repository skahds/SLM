slm = {
    debugMode = false
}

function slm.debugPrint(str, str2)
    local str2 = str2 or " "
    print("======== SLM DEBUG ========" .. str2)
    print(str)
    print("===========================")
end

umg.on("@playerJoin", function(clientID)
    lp.forceSpawnSlot(lp.main.getContext():getPlot():getPPos(5,9), server.entities.shop_slot,clientID)
    lp.forceSpawnSlot(lp.main.getContext():getPlot():getPPos(6,9), server.entities.shop_slot,clientID)
    lp.forceSpawnSlot(lp.main.getContext():getPlot():getPPos(7,9), server.entities.shop_slot,clientID)

    if slm.debugMode == true then
    -- lp.forceSpawnSlot(lp.main.getContext():getPlot():getPPos(12,12), server.entities.turn_slot,clientID)
    lp.forceSpawnItem(lp.main.getContext():getPlot():getPPos(9,8), server.entities.dark_mirror,clientID)
    lp.forceSpawnItem(lp.main.getContext():getPlot():getPPos(7,7), server.entities.ruby_axe,clientID)
    lp.forceSpawnItem(lp.main.getContext():getPlot():getPPos(10,8), server.entities.glass_bottle,clientID)
    lp.forceSpawnItem(lp.main.getContext():getPlot():getPPos(11,8), server.entities.ruby_sword,clientID)
    end
    
end)



