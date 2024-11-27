local function shuffleTable(t)
    local size = #t
    if size <= 2 then return end

    if size > 2 then 
        for i = size, 2, -1 do
            local j = love.math.random(1, i)
            t[i], t[j] = t[j], t[i] -- Swap elements
        end
    end
end

lp.defineSlot("inscryption:player_attack_button", {
    name= "Player Attack",
    image="player_attack_button",
    description = "Plays the card in the card player slot",

    baseMaxActivations = 100,
    triggers = {},
    buttonSlot = true,
    onActivate = function(ent)
        local ppos = lp.getPos(ent)
        local itemEnt = lp.slotToItem(inscryption.play_card_slot)
        if ppos and itemEnt then
            if itemEnt.sacrificeRequired <= 0 or itemEnt.lootplotTeam == "sacrifice_complete" then
                local newSlot = lp.forceSpawnSlot(ppos, server.entities.player_attack, ent.lootplotTeam)
                itemEnt.lootplotTeam = inscryption.player_team
                lp.swapItems(lp.getPos(inscryption.play_card_slot), ppos)
            end
        end
    end,
})

lp.defineSlot("inscryption:player_attack", {
    name= "Player Attack",
    image="player_attack",

    canAddItemToSlot = function(slotEnt, itemEnt)
        return itemEnt.beast == true
    end
})

lp.defineSlot("inscryption:enemy_attack", {
    name= "Enemy Attack",
    image="enemy_attack",

    canAddItemToSlot = function(slotEnt, itemEnt)
        return itemEnt.lootplotTeam == inscryption.team
    end
})
lp.defineSlot("inscryption:enemy_move_down", {
    name= "Enemy Queue",
    image="enemy_move_down",

    canAddItemToSlot = function(slotEnt, itemEnt)
        return itemEnt.lootplotTeam == inscryption.team
    end,

    onActivate = function(ent)
        if lp.slotToItem(ent) then
            local item = lp.slotToItem(ent)
            if item then
                
            end
        end
    end
})

lp.defineSlot("inscryption:play_card_slot", {
    name= "Card Player",
    image="blank_wood",
    baseCanSlotPropagate = false,

    canAddItemToSlot = function(slotEnt, itemEnt)
        return itemEnt.beast == true
    end
})

lp.defineSlot("inscryption:sacrifice_button", {

    name = "Sacrifice Button",
    description = "Click to trigger",

    image = "sacrifice_button_up",
    activateAnimation = {
        activate = "sacrifice_button_down",
        idle = "sacrifice_button_up",
        duration = 0.25
    },
    baseMaxActivations = 100,
    triggers = {},
    buttonSlot = true,
    onActivate = function(ent)
        local ppos = lp.getPos(ent)
        local resultItem = lp.slotToItem(inscryption.play_card_slot)
        if ppos and resultItem and resultItem.sacrificeRequired > 0 then
            if lp.posToItem(ppos:up(1)) then
                local itemEnt = lp.posToItem(ppos:up(1))
                if itemEnt.isBeingSacrificed == nil and itemEnt.blood > 0 then
                    itemEnt.isBeingSacrificed = true
                    table.insert(inscryption.sacrificing_choices, itemEnt)
                end
            end

            if inscryption.sacrificing_choices then
                local bloodRequired = resultItem.sacrificeRequired
                local successfulSac = false
                local sacT = {}
                for i, items in pairs(inscryption.sacrificing_choices) do
                    -- we know there must be blood, no need to check again
                    table.insert(sacT, items)
                    bloodRequired = bloodRequired - items.blood
                    if bloodRequired <= 0 then
                        successfulSac = true
                        break
                    end
                end
                if successfulSac then
                    for i, items in pairs(sacT) do
                        lp.forceSpawnSlot(lp.getPos(items), server.entities.player_attack_button, ent.lootplotTeam)
                        lp.destroy(items)

                    end
                    resultItem.lootplotTeam = "sacrifice_complete"
                end
            end
        end
    end,
})

lp.defineSlot("inscryption:draw_squirrel", {

    name = "Draw squirrel",
    description = "Click to draw a squirrel",

    image = "draw_squirrel_up",
    activateAnimation = {
        activate = "draw_squirrel_down",
        idle = "draw_squirrel_up",
        duration = 0.25
    },
    baseMaxActivations = 100,
    triggers = {},
    buttonSlot = true,
    onActivate = function(ent)
        local ppos = lp.getPos(ent)
        if ppos then
            if inscryption.state == "draw_card" then
                lp.trySpawnItem(ppos:up(1), server.entities.squirrel, ent.lootplotTeam)
                inscryption.change_state("play")
            end
        end
    end,
})

lp.defineSlot("inscryption:draw_card", {

    name = "Draw Card",
    description = "Click to draw a card",

    image = "draw_card_up",
    activateAnimation = {
        activate = "draw_card_down",
        idle = "draw_card_up",
        duration = 0.25
    },
    baseMaxActivations = 100,
    triggers = {},
    buttonSlot = true,
    onActivate = function(ent)
        local ppos = lp.getPos(ent)
        if ppos then
            if inscryption.state == "draw_card" and #inscryption.playing_deck > 0 then
                local deck = inscryption.playing_deck
                shuffleTable(deck)

                if lp.trySpawnItem(ppos:up(1), server.entities[deck[#deck]], ent.lootplotTeam) then
                    table.remove(deck, #deck)
                end
                inscryption.change_state("play")
            end
        end
    end,
})


lp.defineSlot("inscryption:blank_wood", {
    name= "Nothing",
    image="blank_wood",

    canAddItemToSlot = function(slotEnt, itemEnt)
        return itemEnt.beast == true
    end
})

lp.defineSlot("inscryption:empty_map", {
    name= "Map",
    image="empty_map",
    canAddItemToSlot = function(slotEnt, itemEnt)
        if itemEnt.beast then
            return false
        end
        return true
    end
})
