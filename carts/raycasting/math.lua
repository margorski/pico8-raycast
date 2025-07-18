PI = 3.14
MAX_NUM = 32767

function tg(angle)
    return sin(angle) / cos(angle)
end

function normalize_angle(angle)
    while angle < 0 do
        angle += 2 * PI
    end
    while angle >= 2 * PI do
        angle -= 2 * PI
    end
    return angle
end

function sign(value)
    return value < 0 and -1 or (value > 0 and 1 or 0)
end

function rad_to_deg(rad)
    return rad * 180 / PI
end

function deg_to_rad(deg)
    return deg * PI / 180
end

function turns_to_rad(turns)
    -- convert clockwise turns (0.0..1.0) to radians (0..2*pi, counterclockwise)
    turns = (1 - turns) % 1
    return turns * 2 * PI
end

function rads_to_turns(rad)
    -- convert radians (0..2*pi, counterclockwise) to clockwise turns (0.0..1.0)
    return (1 - (rad / (2 * PI))) % 1
end

function sin_rad(rad)
    return -sin(rads_to_turns(rad))
end

function cos_rad(rad)
    return cos(rads_to_turns(rad))
end