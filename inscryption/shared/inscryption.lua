local inscryption = {
    team = "Leshy",
    playerTeam = "player_111",
    beasts = {},
    state="map",
    
    deck = {"stoat", "raven"},
    sacrificing_choices = {}
}


local function defineInteger(compName)
    components.defineComponent(compName)
    sync.autoSyncComponent(compName, {
        type = "number",
        lerp = false,
    })
end

defineInteger("sacrificeRequired")
defineInteger("blood")



umg.defineEvent("inscryption:state_changed")
--states: map, draw_card, play
function inscryption.change_state(newState)
    local oldState = inscryption.state
    umg.call("inscryption:state_changed")

    if oldState == "map" then
        inscryption.playing_deck = inscryption.deck
    end

    inscryption.state = newState
end




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
            else
                ent.target.type = "ITEM_OR_SLOT"
            end
        end
    end
end




-- umg.on("inscryption:state_changed", function ()
    
-- end)


umg.expose("inscryption", inscryption)

