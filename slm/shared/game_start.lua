slm = {
    debugMode = false
}
local lootplot = lp

function slm.debugPrint(str, str2)
    local str2 = str2 or " "
    print("======== SLM DEBUG ========" .. str2)
    print(str)
    print("======== END DEBUG ========")
end

umg.on("@playerJoin", function(clientID)
    lp.forceSpawnSlot(lp.main.getContext():getPlot():getPPos(5,9), server.entities.shop_slot,clientID)
    lp.forceSpawnSlot(lp.main.getContext():getPlot():getPPos(6,9), server.entities.shop_slot,clientID)
    lp.forceSpawnSlot(lp.main.getContext():getPlot():getPPos(7,9), server.entities.shop_slot,clientID)

    if slm.debugMode == true then
    -- lp.forceSpawnSlot(lp.main.getContext():getPlot():getPPos(12,12), server.entities.turn_slot,clientID)
        lp.forceSpawnItem(lp.main.getContext():getPlot():getPPos(9,7), server.entities.torch,clientID)

    end
    
end)



