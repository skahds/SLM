umg.on("lootplot:populateDescription", 50, function(ent, arr)
    local botanicGrowthTable = ent.botanicGrowth
    if botanicGrowthTable then
        table.sort(botanicGrowthTable, function (a, b)
            return a.requiredAge < b.requiredAge
        end)
        local botanicTable = botanicGrowthTable[1]
        local growthGap = botanicTable.requiredAge - ent.age
        if growthGap > 1 then
            arr:add("{c r=0.1 b=0.1 g=1}Transform after grown " .. growthGap .. " times!")
        else
            arr:add("{c r=0.1 b=0.1 g=1}Transform when grown!")
        end
        -- arr:add("{c r=0.1 b=0.1 g=0.8}Current Age: " .. ent.age)
    end

end)
