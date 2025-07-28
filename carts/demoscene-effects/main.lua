effects = {
    fire,
    rotozoomer
}
current_effect_idx = 0

function _init()
    printh("_init called")
    for _, effect in pairs(effects) do
        if effect.init then
            effect.init()
        end
    end
end

function _update()
    printh("_update called")

    if btnp(4) then
        current_effect_idx = (current_effect_idx + 1) % #effects
        printh("Switched to effect: " .. effects[current_effect_idx + 1].name)
    end

    local current_effect = effects[current_effect_idx + 1]
    if current_effect.update then
        current_effect.update()
    end
end

function _draw()
    printh("_draw called")
    local current_effect = effects[current_effect_idx + 1]
    if current_effect.draw then
        current_effect.draw()
    end
end