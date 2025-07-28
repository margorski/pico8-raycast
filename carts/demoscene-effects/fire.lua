fire_palette = {
    COLORS.BLACK,
    COLORS.BLACK,
    COLORS.RED,
    COLORS.ORANGE,
    COLORS.YELLOW,
    COLORS.YELLOW,
    COLORS.WHITE,
    COLORS.WHITE,
    COLORS.WHITE,
    COLORS.WHITE,
    COLORS.WHITE,
    COLORS.WHITE
}

FIRE_DIVIDER = 4.2
FIRE_SCALING = 4
SCREEN_HEIGHT = 128 / FIRE_SCALING

fire_buffer = {}

function _init()
    for y = 1, SCREEN_HEIGHT + 1 do
        fire_buffer[y] = {}
        for x = 1, 128 do
            fire_buffer[y][x] = 1
        end
    end
end

function _update()
    for x = 1, 128 do
        value = rnd(#fire_palette) + 1
        fire_buffer[SCREEN_HEIGHT + 1][x] = value
    end

    for y = 1, SCREEN_HEIGHT do
        for x = 1, 128 do
            local below = fire_buffer[y + 1][x] or 1
            local two_below = y < SCREEN_HEIGHT - 1 and fire_buffer[y + 2][x] or below
            local left_below = fire_buffer[y + 1][x - 1] or 1
            local right_below = fire_buffer[y + 1][x + 1] or 1
            local new_value = (below + two_below + left_below + right_below) / FIRE_DIVIDER
            fire_buffer[y][x] = new_value
        end
    end
end

function _draw()
    cls(0)
    for y = 1, SCREEN_HEIGHT do
        for x = 1, 128 do
            local color = fire_palette[flr(fire_buffer[y][x])]
            pset(x - 1, 128 - SCREEN_HEIGHT + y - 1, color)
        end
    end
end

fire = {
    name = "fire",
    init = _init,
    update = _update,
    draw = _draw
}