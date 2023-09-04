-- Taken from GNLib (https://github.com/Nogitsu/GNLib) with permissions
-- MIT License

function SNTE_V2.DrawCircle(x, y, radius, angle_start, angle_end, color)
    local poly = {}

    table.insert(poly, {
        x = x,
        y = y
    })

    for i = math.min(angle_start or 0, angle_end or 360), math.max(angle_start or 0, angle_end or 360) do
        local a = math.rad(i)

        if (angle_start or 0) < 0 then
            table.insert(poly, {
                x = x + math.cos(a) * radius,
                y = y + math.sin(a) * radius
            })
        else
            table.insert(poly, {
                x = x - math.cos(a) * radius,
                y = y - math.sin(a) * radius
            })
        end
    end

    table.insert(poly, {
        x = x,
        y = y
    })

    draw.NoTexture()
    surface.SetDrawColor(color or color_white)
    surface.DrawPoly(poly)

    return poly
end

function SNTE_V2.DrawOutlinedCircle(x, y, radius, thick, angle_start, angle_end, color)
    surface.SetDrawColor(color or color_white)
    local min_ang = math.min(angle_start or 0, angle_end or 360)

    for t = 0, thick - 1, .5 do
        local times = 0
        local last_x, last_y = x + math.cos(math.rad(min_ang)) + radius, y + math.sin(math.rad(min_ang)) + radius

        for i = min_ang, math.max(angle_start or 0, angle_end or 360) do
            local a = math.rad(i)
            local cur_x, cur_y = 0, 0

            if (angle_start or 0) < 0 then
                cur_x = x + math.cos(a) * (radius + t)
                cur_y = y + math.sin(a) * (radius + t)
            else
                cur_x = x - math.cos(a) * (radius + t)
                cur_y = y - math.sin(a) * (radius + t)
            end

            surface.DrawLine((times > 0 and last_x or cur_x), (times > 0 and last_y or cur_y), cur_x, cur_y)
            last_x = cur_x
            last_y = cur_y
            times = times + 1
        end
    end
end
