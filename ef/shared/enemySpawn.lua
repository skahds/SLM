local function defineInteger(compName)
    components.defineComponent(compName)
    sync.autoSyncComponent(compName, {
        type = "number",
        lerp = false,
    })
end

defineInteger("infectedCount")

ef = ef
umg.on("lootplot:entityReset", function (ent)
    if lp.isSlotEntity(ent) then
        if ent.infectedCount then 
            if ent.infectedCount > 1 then
                ent.infectedCount = ent.infectedCount - 1
            elseif ent.infectedCount <= 1 then
                if server then
                    lp.forceSpawnItem(lp.getPos(ent), server.entities.slime, ef.team)
                end
                ent.infectedCount = nil
            end
        end
        if ent.infectedCount == nil and ef.isSlotImageBlacklisted(ent) ~= true and math.random() < ef.enemySpawnChance then
            ent.infectedCount = 2
        end
    end
end)