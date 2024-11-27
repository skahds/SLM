local loc = localization.localize
local interp = localization.newInterpolator

local function nextLevel(ent)
    lp.setPoints(ent, 0)
    lp.main.setRound(ent, 1)
    lp.setLevel(ent, lp.getLevel(ent))
end

local NEXT_LEVEL = "Click to progress to the next level!"
local NEED_POINTS = interp("{c r=1 g=0.6 b=0.5}Need %{pointsLeft} more points!")

lp.defineSlot("inscryption:next_level_button_slot", {
    image = "level_button_up",

    name = loc("Next-Level Button"),
    activateDescription = function(ent)
        if umg.exists(ent) then
            local points = lp.getPoints(ent)
            local requiredPoints = lp.main.getRequiredPoints(ent)
            local pointsLeft = requiredPoints - points
            if pointsLeft < 0 then
                return NEXT_LEVEL
            else
                return NEED_POINTS({
                    pointsLeft = pointsLeft
                })
            end
        end
        return ""
    end,

    baseMaxActivations = 100,
    triggers = {"RESET"},
    buttonSlot = true,

    onDraw = function(ent)
        if not lp.canActivateEntity(ent) then
            ent.opacity = 0.3
        else
            ent.opacity = 1
        end
    end,

    canActivate = function(ent)
        local requiredPoints = lp.main.getRequiredPoints(ent)
        local points = lp.getPoints(ent)
        if points >= requiredPoints then
            return true
        end
        return false
    end,

    onActivate = function(ent)
        local ppos=lp.getPos(ent)
        if ppos then
            nextLevel(ent)
        end
    end,
})