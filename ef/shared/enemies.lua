local ef = {}
ef.team = "@enemy"

local function newRarity(name, rarity_weight, color)
    local cStr = localization.localize("{wavy}{c r=%f g=%f b=%f}%{name}{/c}{/wavy}", {
        name = name
    }):format(color.r, color.g, color.b)
    return {
        color = color,
        index = 1,
        name = name,
        rarityWeight = rarity_weight,
        displayString = cStr
    }
end
lp.rarities.ENEMY = newRarity("ENEMY", 0.00, objects.Color.RED)

local DEFAULT_PROPS = {
    "pointsGenerated", 
    "moneyGenerated", 
    "maxActivations"
}

local function giveCommonComponents(etype)
    for _, prop in ipairs(DEFAULT_PROPS) do
        local base = properties.getBase(prop)
        assert(base,"?")
        -- ensure base exists:
        etype[base] = etype[base] or properties.getDefault(prop)
    end
end

local strTabTc = typecheck.assert("string", "table")

lp.defineTrigger("ENEMY_PULSE")
---Availability: Client and Server
---@param name string
---@param itemType table<string, any>
function ef.defineEnemy(name, itemType)
    strTabTc(name, itemType)
    itemType.item = true
    itemType.enemy = true
    itemType.layer = "item"
    itemType.baseMaxActivations = 5
    itemType.basePrice = itemType.basePrice or -1000000
    itemType.sellPrice = -1000000
    itemType.triggers = itemType.triggers or {"PULSE", "ENEMY_PULSE"}
    itemType.hitboxDistance = itemType.hitboxDistance or 8
    itemType.hoverable = true
    itemType.lives = itemType.lives or 3
    giveCommonComponents(itemType)
    umg.defineEntityType(name, itemType)
end


umg.expose("ef", ef)
