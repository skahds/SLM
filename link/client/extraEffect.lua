umg.on("rendering:drawEntity", -1.1, function (ent, x,y, rot, sx,sy)
    if ent.linkGroup then
        for i, item in pairs(ent.linkGroup.item) do
            if item.x and x then
                love.graphics.setColor(0.2, 0.2, 0.5)
                love.graphics.setLineWidth(5)
                love.graphics.line(item.x, item.y, x, y)

                love.graphics.setColor(0.3, 0.3, 0.8)
                love.graphics.setLineWidth(3)
                love.graphics.line(item.x, item.y, x, y)


                love.graphics.setColor(1, 1, 1)
            end
        end
    end
end)