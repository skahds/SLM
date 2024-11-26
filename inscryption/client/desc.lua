umg.on("lootplot:populateDescription", 60, function(ent, arr)
    
    if ent.sacrificeRequired then
        arr:add("{c r=1 b=0.1 g=0.1}Bloodthirsty-" .. ent.sacrificeRequired .. ": Requires " .. ent.sacrificeRequired .. " blood worth of sacrifices.")
    end
    if ent.blood then
        arr:add("{c r=0.8 b=0.2 g=0.2}Bloody-" .. ent.blood .. ": Worth " .. ent.blood .. " blood worth for sacrificing.")
    end

end)
