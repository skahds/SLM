-- im gonna polute global >:)
linkerMod = {
    linkGroup = {}
}

umg.defineEvent("link:linkEnded")

umg.on("lootplot:entityActivated", function (ent)
    if server then
        
    if ent.linkGroup then
        print(ent.linkGroup)
        local linkGroupEnt = ent.linkGroup
        local selfPos = lp.getPos(ent)

        for index, item in pairs(linkGroupEnt.item) do
            if lp.getPos(item) ~= selfPos then

                lp.queueWithEntity(item, function (e)
                    lp.tryTriggerEntity(linkGroupEnt.trigger, e)
                    umg.call("link:linkEnded", e)
                end)
                lp.wait(lp.getPos(item), 0.33)

            end

            -- moves it to storage
            linkGroupEnt.storage[#linkGroupEnt.storage+1] = item
            linkGroupEnt.item[index] = nil
        end
        

    end

    end
end)

umg.on("link:linkEnded", function (ent)
    if server then
        
    local linkGroupEnt = ent.linkGroup
    for index, item in pairs(linkGroupEnt.storage) do
        linkGroupEnt.item[#linkGroupEnt.item+1] = item
        linkGroupEnt.storage[index] = nil
    end

    end
end)