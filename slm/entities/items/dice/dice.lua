local loc = localization.localize
local function defineDice(entName, etype)
    lp.defineItem(entName, etype)
end

function chanceMaker(id_image, name, faces, extras)

    local entId = "slm:" .. id_image
    extras = extras or {}



    local etype = {
        image = id_image,
        name = loc(name),

        description = loc("{lp_targetColor}generates points by a random amount"),

        rarity = extras.rarity or lp.rarities.COMMON,
        targetType = "NO_SLOT",
        baseBuyPrice = 1,
        minimumLevelToSpawn = extras.minLevel,

        onActivate = function (selfEnt)
            local point = math.random(extras.startCount or 1, faces)
            if extras.type == nil then
            lp.addPoints(selfEnt, point * (extras.mult or 1))
            elseif extras.type == "money" then
            lp.addMoney(selfEnt, point)
            end
        end

    }

    defineDice(entId, etype)
end

chanceMaker("dice", "Normal Dice", 6)
chanceMaker("dice_red", "Red Dice", 7, {mult=2, startCount=2, minLevel=2, rarity=lp.rarities.UNCOMMON})
chanceMaker("dice_pure", "Pure Dice", 9, {mult=10, startCount=3, minLevel=3, rarity=lp.rarities.RARE})
chanceMaker("dice_gold", "Golden Dice", 6, {type="money"})