local loc = localization.localize
local lootplot = lp

lp.defineSlot("slm:turn_slot", {
    image = "turn_slot",
    name = loc("Turn Slot"),
    description = loc("Turns the target shape of items on top by 90 degree counter-clockwise"),
    onActivate = function(ent)
        local ppos = lp.getPos(ent)
        if not (ppos) then return end

        local item = lp.posToItem(ppos)
        if item then
        

        if item.targetShape ~= nil then

            lp.targets.setTargetShape(item, slm.targets.rotate(item.targetShape, -90))
        end

        end


    end
})
