ef = ef
umg.on("lootplot:entityReset", function (ent)
    if lp.isSlotEntity(ent) then
        if ent.enemyInfected == nil and math.random() < ef.enemySpawnChance then
            ent.enemyInfected = 2
        end
        if ent.enemyInfected then 
            if ent.enemyInfected > 0 then
                ent.enemyInfected = ent.enemyInfected - 1
            elseif ent.enemyInfected <= 0 then
                if server then
                    lp.forceSpawnItem(lp.getPos(ent), server.entities.slime, ef.team)
                end
            end
        end
    end
end)