inscryption.targets = {}
local function rotate_point(x, y, degrees)
    local radians = math.rad(degrees)

    -- Apply the rotation formulas
    local x_new = math.floor(x * math.cos(radians) - y * math.sin(radians)+0.5)
    local y_new = math.floor(x * math.sin(radians) + y * math.cos(radians)+0.5)

    return {x_new, y_new}
end

function inscryption.targets.rotate(target, degree)


    local newCordPair = {relativeCoords={}}
    newCordPair.totalTurnedDegree = target.totalTurnedDegree or 0
    newCordPair.realName = target.realName or target.name
    newCordPair.realShape = newCordPair.realShape or target.relativeCoords

    newCordPair.totalTurnedDegree = (newCordPair.totalTurnedDegree + degree) % 360
    if newCordPair.totalTurnedDegree ~= 0 then
        newCordPair.name=newCordPair.realName .. " turned " .. newCordPair.totalTurnedDegree .. "cw"
    else
        newCordPair.name=newCordPair.realName
    end

    for i, cordPair in ipairs(newCordPair.realShape) do
        local x = cordPair[1]
        local y = cordPair[2]
        local xyPair = rotate_point(x, y, degree)

        table.insert(newCordPair.relativeCoords, xyPair)
    end
    return newCordPair
end