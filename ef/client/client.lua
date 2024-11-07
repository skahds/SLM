umg.on("lootplot:populateDescription", 50, function(ent, arr)
    if ent.enemyInfected then
        if ent.enemyInfected > 1 then
            arr:add("{c r=1 b=0.1 g=0.1}Spawns an enemy after " .. ent.enemyInfected .. " round!")
        else
            arr:add("{c r=1 b=0.1 g=0.1}Spawns an enemy next round!")
        end

    end
    if ent.age then
        arr:add("{c r=0.1 b=0.1 g=0.8}Current Age: " .. ent.age)
    end

end)

umg.on("rendering:drawEntity", 1, function(ent, x,y, rot, sx,sy, kx,ky)
    if ent.enemyInfected then
        local q, dy
        if lp.isSlotEntity(ent) then
            dy = 0
            if ent.enemyInfected > 1 then
                q = client.assets.images.slot_infected_visual
            else
                q = client.assets.images.slot_infected_big_visual
            end
        end

        if q then
            rendering.drawImage(q, x, y+dy, rot, sx,sy, kx,ky)
        end
    end
end)