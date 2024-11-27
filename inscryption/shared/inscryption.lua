local inscryption = {
    team = "Leshy",
    playerTeam = "player_111",
    beasts = {},
    state="map",
    
    deck = {"stoat", "raven", "black_goat"},
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
defineInteger("insHP")
defineInteger("attack")



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








-- umg.on("inscryption:state_changed", function ()
    
-- end)


umg.expose("inscryption", inscryption)

