local craftingLib = {
    recipes = {}
}

-- recipes are a table with result and ingredient which is a table with
-- name of the item as the key and the value as the amount needed


function craftingLib.addRecipe(result, ingredients, resultName)
    resultName = resultName or result
    table.insert(craftingLib.recipes, {result=result, ingredient=ingredients, clientResult = resultName})
end
-- unfortunately i have no idea how to transfer server to client so result name will have to be manually written

umg.expose("craftingLib", craftingLib)