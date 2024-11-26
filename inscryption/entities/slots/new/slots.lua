lp.defineSlot("inscryption:player_attack", {
    name= "Player Attack",
    image="player_attack"
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
        if ppos then

        end
    end,
})

lp.defineSlot("inscryption:draw_squirrel", {

    name = "Draw Card",
    description = "Click to draw a card",

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
            lp.trySpawnItem(ppos:up(1), server.entities.squirrel, ent.lootplotTeam)
        end
    end,
})

-- lp.defineSlot("inscryption:draw_card", {

--     name = "Draw Card",
--     description = "Click to draw a card",

--     image = "sacrifice_button_up",
--     activateAnimation = {
--         activate = "sacrifice_button_down",
--         idle = "sacrifice_button_up",
--         duration = 0.25
--     },
--     baseMaxActivations = 100,
--     triggers = {},
--     buttonSlot = true,
--     onActivate = function(ent)
--         local ppos = lp.getPos(ent)
--         if ppos then

--         end
--     end,
-- })


lp.defineSlot("inscryption:blank_wood", {
    name= "Nothing",
    image="blank_wood"
})

lp.defineSlot("inscryption:empty_map", {
    name= "Map",
    image="empty_map"
})
