local midPosX = 20
local midPosY = 20

local function createBoard(plot, clientId)
    local slotOrder = {server.entities.enemy_move_down, server.entities.enemy_attack, server.entities.player_attack, server.entities.sacrifice_button}
    for i=1, math.floor(#inscryption.deck/4)+1 do
        table.insert(slotOrder, server.entities.blank_wood)
    end

    for y=1, #slotOrder do
        for x=1, 4 do
            lp.forceSpawnSlot(plot:getPPos(midPosX-1+x,midPosY-1+y), slotOrder[y], clientId)
        end
    end

    lp.forceSpawnSlot(plot:getPPos(midPosX+5,midPosY), server.entities.draw_squirrel, clientId)
    lp.forceSpawnSlot(plot:getPPos(midPosX+6,midPosY), server.entities.draw_card, clientId)
    lp.forceSpawnSlot(plot:getPPos(midPosX+5,midPosY-1), server.entities.blank_wood, clientId)
    lp.forceSpawnSlot(plot:getPPos(midPosX+6,midPosY-1), server.entities.blank_wood, clientId)
end

local function createMap(plot, clientId)
    for y=1, 8 do
        for x=1, 5 do
            lp.forceSpawnSlot(plot:getPPos(midPosX-10+x,midPosY-3+y), server.entities.empty_map, clientId)
            if (x==1 or x==5) or (y==1 or y==8) then
                lp.forceSpawnItem(plot:getPPos(midPosX-10+x,midPosY-3+y), server.entities.map_tree, "map")
            else
                lp.forceSpawnItem(plot:getPPos(midPosX-10+x,midPosY-3+y), server.entities.map_fog, "map")
            end
        end
    end
end

umg.on("firstactivate:playerJoin", function (clientId)
    local run = lp.main.getRun()
    if run and server then
        -- destroy any slot that is near the spawn
        local plot = run:getPlot()
        for i=1, 100 do
            local slot = lp.posToSlot(plot:getPPos(midPosX-5+i%10,midPosY-1+math.floor(i/10)))
            if slot then
                if lp.slotToItem(slot) then
                    lp.destroy(lp.slotToItem(slot))
                end
                lp.destroy(slot)
            end
        end

        -- destroy money-limit slot
        if lp.posToSlot(plot:getPPos(midPosX,0), server.entities.slot, clientId) then
            lp.destroy(lp.posToSlot(plot:getPPos(midPosX,0), server.entities.slot, clientId))
        end

        createBoard(plot, clientId)
        createMap(plot, clientId)
        lp.forceSpawnItem(plot:getPPos(midPosX-7, midPosY+4), server.entities.player_totem, clientId)

        inscryption.change_state("draw_card")
    end
end)
--15