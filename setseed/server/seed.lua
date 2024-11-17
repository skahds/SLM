local setseed = {
    list = {}
}

---adds the item
---@param item any
---@param amount any
---@param round any
function setseed.addItem(item, amount, round)
    round=round or 1
    amount = amount or 1
    for i=1, amount do
        table.insert(setseed.list, {item, round})
        table.insert(setseed.list, {item, round})
    end
end

umg.expose("setseed", setseed)


--item name, the amount of time it appears in a row, the round it appears in
setseed.addItem("dragonfruit")
setseed.addItem("stone_fruit")
setseed.addItem("ruby_sword", 2, 2)
setseed.addItem("ruby_sword", 2, 4)