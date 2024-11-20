umg.on("lootplot:populateDescription", 60, function(ent, arr)
    local requiredCrafting = {}

    for _, r in pairs(craftingLib.recipes) do
        print("A")
        local recipe = r.ingredient
        if recipe[ent.name] then
            table.insert(requiredCrafting, r)
        end
    end
    if #requiredCrafting > 0 then
        arr:add("{c r=0.96 b=0 g=0.5}Required in these craftings:")
        for i, recipes in pairs(requiredCrafting) do
            local ingredientString = ""
            for ingredient, amount in pairs(recipes.ingredient) do
                ingredientString = ingredientString .. ingredient .. " (x" .. amount .. "), "
            end
            arr:add("{c r=0.96 b=0 g=0.5}" .. ingredientString .. "\nCrafts into : " .. recipes.clientResult)
        end
    end
end)
