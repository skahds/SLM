function inscryption.giveSigilEffect(ent, sigil)
    assert(ent.beast, "Entity is not a card")
    if ent.sigils[sigil] == false then
        ent.sigils[sigil] = true
    end
    for v, sigil in pairs(ent.sigils) do
        print(sigil, v)
        if sigil == "Airborne" then
            if v then
                ent.target.type = "SLOT"
            -- else
            --     ent.target.type = "ITEM_OR_SLOT"
            end
        end
        if sigil == "Worthy Sacrifice" then
            if v then
                ent.blood = 3
            end
        end
    end
end