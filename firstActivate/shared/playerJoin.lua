local firstActive = false

umg.defineEvent("firstactivate:playerJoin")
umg.on("lootplot:entityActivated", function (ent)
    if firstActive == false and ent.lootplotTeam then
        umg.call("firstactivate:playerJoin", ent.lootplotTeam)
        firstActive = true
    end
end)