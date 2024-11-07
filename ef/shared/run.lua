-- umg.on("lootplot:entityReset", function (ent)
--     local ppos = lp.getPos(ent)
--     local plot = ppos:getPlot()

-- end)
local function shuffleTable(t)
    local size = #t
    if size <= 2 then return end

    if size > 2 then 
        for i = size, 2, -1 do
            local j = love.math.random(1, i)
            t[i], t[j] = t[j], t[i] -- Swap elements
        end
    end
end

umg.on("lootplot:entityReset", function (ent)
    if ef.isEnemy(ent) and ent.ai ~= "NOTHING" then
        local entList = {}
        local ppos = lp.getPos(ent)
        local plot = ppos:getPlot()
        
        plot:foreachItem(function(targetEnt)
            if lp.isItemEntity(targetEnt) then
                -- check the AI type
                if (ent.ai == "SHAPE_ATTACK_ITEM" and ef.isEnemy(targetEnt) ~= true) or
                (ent.ai == "SHAPE_SUPPORT_ENEMY" and ef.isEnemy(targetEnt) ) then
                    table.insert(entList, targetEnt)
                end
            end
        end)
        -- get every ent in the list
        if entList then
            shuffleTable(entList)
            for _, item in ipairs(entList) do
                local doneFind = nil
                
                local itemPos = lp.getPos(item)
                if itemPos ~= nil then
                    local relativeTable = ent.shape.relativeCoords
                    -- shuffle it up, tho if its 2 it can't shuffle
                    shuffleTable(relativeTable)
                    for _, cordPair in ipairs(relativeTable) do
                        -- get newPos
                        local newPos = itemPos:move(cordPair[1], -cordPair[2])
                        if lp.posToSlot(newPos) then
                            local selfCopy = lp.clone(ent)

                            local setsesful = lp.trySetItem(newPos, selfCopy)
                            if setsesful then
                                -- destroy self
                                ent.lives = 0
                                lp.destroy(ent)
                                doneFind = true
                                break
                            end
                            
                        end
                        -- check if done
                        if doneFind then
                            break
                        end
                    end
                end
                -- check if done
                if doneFind then
                    break
                end
            end
        end
    end
end)
