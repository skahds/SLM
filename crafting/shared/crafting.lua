local craftingLib = {
    recipes = {}
}

-- recipes are a table with result and ingredient which is a table with
-- name of the item as the key and the value as the amount needed

function craftingLib.addRecipe(result, ingredients)
    if server then
        table.insert(craftingLib.recipes, {result=result, ingredient=ingredients})
    end
end

umg.expose("craftingLib", craftingLib)