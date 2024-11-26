local cards = {}


local function defineBeast(id, details)
    details.name = details.name or "NO NAME"
    details.image = details.image or "squirrel"
    details.rarity = lp.rarities.UNIQUE
    details.description = details.description or "NO DESCRIPTION"
    details.attack = details.attack or 0
    details.health = details.health or 1
    details.blood = details.blood or 1
    details.sacrificeRequired = details.sacrificeRequired or 0
    details.sigils = details.sigils or {}
    details.canItemFloat = true

    cards[id] = details
    table.insert(inscryption.beasts, id)
end

defineBeast("squirrel", {
    image="squirrel",
    name ="Squirrel"
})

for id, card in pairs(cards) do
    lp.defineItem("inscryption:" .. id, card)
end