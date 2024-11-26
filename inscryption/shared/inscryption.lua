local inscryption = {
    team = "Leshy",
    beasts = {},
    state="map",
    
    deck = {"stoat"}
}




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