local setqueue = {
    list = {}
}

---adds the item
---@param item any
---@param amount any
---@param round any
function setqueue.addItem(item, amount, round)
    round=round or 1
    amount = amount or 1
    for i=1, amount do
        table.insert(setqueue.list, {item, round})
    end
end

umg.expose("setqueue", setqueue)


--item name, the amount of time it appears in a row, the round it appears in
--
setqueue.addItem("potion_blue", 2, 1)

