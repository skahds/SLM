local helper = {}

function helper.rotateRandomly(ent)
    local rot = lp.SEED:randomMisc(0,3)
    if rot ~= 0 then
        lp.rotateItem(ent, rot)
    end
end

return helper