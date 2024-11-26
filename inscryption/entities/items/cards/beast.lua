local cards = {}


local function defineBeast(id, details)
    details.beast = true

    details.name = details.name or "NO NAME"
    details.image = details.image or "place_holder_card"
    details.rarity = lp.rarities.UNIQUE
    details.description = details.description or "NO DESCRIPTION"
    details.attack = details.attack or 0
    details.insHP = details.health or 1
    details.blood = details.blood or 1
    details.sacrificeRequired = details.sacrificeRequired or 0
    details.sigils = details.sigils or {}
    details.canItemFloat = true


    details.shape = details.shape or lp.targets.ABOVE_SHAPE
    details.target = {
        type = "ITEM_OR_SLOT",
        description = "Deals " .. details.attack .. " damage.",
        activate = function (selfEnt, ppos, targetEnt)
        if selfEnt.attack and targetEnt then
            if targetEnt.insHP then
                targetEnt.insHP = targetEnt.insHP - selfEnt.attack
            elseif lp.isSlotEntity(targetEnt) then
                if selfEnt.lootplotTeam == inscryption.team then
                    lp.addPoints(targetEnt, -selfEnt.attack)
                else    
                    lp.addPoints(targetEnt, selfEnt.attack)
                end
            end
        end
    end}


    cards[id] = details
    table.insert(inscryption.beasts, id)
end

defineBeast("squirrel", {
    image="squirrel",
    name ="Squirrel"
})

defineBeast("stoat", {
    name = "Stoat",
    description = "We gotta get outa this plot!",
    attack = 1,
    health = 3,
    sacrificeRequired = 1
})

for id, card in pairs(cards) do
    lp.defineItem("inscryption:" .. id, card)
end

