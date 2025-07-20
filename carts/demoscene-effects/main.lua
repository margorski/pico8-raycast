angle = 0

function _init()
end

function _update()
    angle += 0.03
    angle = normalize_angle(angle)
end

function _draw()
    cls(0)

    angle_sin = sin_rad(angle)
    angle_cos = cos_rad(angle)

    for y = 0, 127 do
        for x = 0, 127 do
            local nx = flr((x * angle_cos - y * angle_sin) * (angle_sin + 2) + angle_sin * 127) & 127
            local ny = flr((x * angle_sin + y * angle_cos) * (angle_sin + 2) + angle_sin * 127) % 127

            sspr(nx, ny, 1, 1, x, y)
        end
    end
end