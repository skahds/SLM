umg.on("lootplot:populateDescription", 60, function(ent, arr)
    
    if ent.sacrificeRequired and ent.sacrificeRequired > 0 then
        arr:add("{c r=1 b=0.1 g=0.1}Bloodthirsty-" .. ent.sacrificeRequired .. ": Requires " .. ent.sacrificeRequired .. " blood worth of sacrifices.")
    end
    if ent.blood and ent.blood > 0 then
        arr:add("{c r=0.8 b=0.2 g=0.2}Bloody-" .. ent.blood .. ": Worth " .. ent.blood .. " blood worth for sacrificing.")
    elseif ent.blood and ent.blood <= 0 then
        arr:add("{c r=0.8 b=0.2 g=0.2}Bloody-" .. ent.blood .. ": Can't be " .. ent.blood .. " sacrificed.")
    end

end)
