umg.on("firstactivate:playerJoin", function (clientId)
    local run = lp.main.getRun()
    if run and server then
        local plot = run:getPlot()
        for i=1, 100 do
            local slot = lp.posToSlot(plot:getPPos(15+i%10,19+math.floor(i/10)))
            if slot then
                if lp.slotToItem(slot) then
                    lp.destroy(lp.slotToItem(slot))
                end
                lp.destroy(slot)
            end
        end

        local slotOrder = {server.entities.enemy_move_down, server.entities.enemy_attack, server.entities.player_attack, server.entities.sacrifice_button, server.entities.blank_wood, server.entities.draw_squirrel}
        for y=1, #slotOrder do
            for x=1, 4 do
                lp.forceSpawnSlot(plot:getPPos(19+x,19+math.floor(y)), slotOrder[y], clientId)
            end
        end
    end
end)
--15