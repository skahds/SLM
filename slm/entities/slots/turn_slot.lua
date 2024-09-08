local loc = localization.localize

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

            local newCordPair = {name=item.targetShape.name .. " turned 90ccw" ,relativeCoords={}}

            for i, cordPair in ipairs(item.targetShape.relativeCoords) do
                local x = cordPair[1]
                local y = cordPair[2]
                table.insert(newCordPair.relativeCoords, {y, -x})
            end

            lp.targets.setTargetShape(item, newCordPair)
        end

        end
    end
})