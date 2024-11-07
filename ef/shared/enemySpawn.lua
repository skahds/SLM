local function defineInteger(compName)
    components.defineComponent(compName)
    sync.autoSyncComponent(compName, {
        type = "number",
        lerp = false,
    })
end

defineInteger("enemyInfected")

ef = ef
umg.on("lootplot:entityReset", function (ent)
    if lp.isSlotEntity(ent) then
        if ent.enemyInfected then 
            if ent.enemyInfected > 1 then
                ent.enemyInfected = ent.enemyInfected - 1
            elseif ent.enemyInfected <= 1 then
                if server then
                    lp.forceSpawnItem(lp.getPos(ent), server.entities.slime, ef.team)
                end
                ent.enemyInfected = nil
            end
        end
        if ent.enemyInfected == nil and math.random() < ef.enemySpawnChance then
            ent.enemyInfected = 2
        end
    end
end)