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

-- umg.on("firstactivate:playerJoin", function (clientId)
--     local run = lp.main.getRun()
--     if run and server then
--         local plot = run:getPlot()
--         local plasticTable = {
--             server.entities.water_pump,
--             server.entities.oil_rig,
--             server.entities.boiler,
--         }
--         for x=1, 5 do
--             for y=1,12 do
--                 lp.forceSpawnSlot(plot:getPPos(17+x,19+y), server.entities.slot, clientId)
--             end
--         end
--         for i=0, 8 do
--             if plasticTable[i] then
--                 lp.forceSpawnItem(plot:getPPos(18+i%3,19+math.floor(i/3)), plasticTable[i], clientId)
--             end
--         end

--     end
-- end)

