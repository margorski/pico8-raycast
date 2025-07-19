player = {
	x = -1,
	y = -1,
	rot = 0
}

function player_init()
	for x = 1, map.SIZE do
		for y = 1, map.SIZE do
			if map:get_tile(x, y) == -1 then
				player.x = x + 0.5
				player.y = y + 0.5
			end
		end
	end

	if player.x == -1 or player.y == -1 then
		printh("Player start position not found in map!")
		return
	else
		printh("Player start position: " .. player.x .. ", " .. player.y)
	end
end

function player_update()
	player_rotated = false

	if btn(0) then
		player_rotated = true
		player.rot -= SETTINGS.PLAYER.TURN_SPEED
	end
	if btn(1) then
		player_rotated = true
		player.rot += SETTINGS.PLAYER.TURN_SPEED
	end
	player.rot = normalize_angle(player.rot)

	move_value = -bool_to_int(btn(3)) + bool_to_int(btn(2))
	player_moved = _move_player(move_value)

	if player_rotated or player_moved then
		printh("Player --  x: " .. player.x .. ", y: " .. player.y .. ", rot: " .. player.rot)
	end
end

function player_draw()
end

function _move_player(direction)
	if direction == 0 then return false end

	local move_dx = cos_rad(player.rot) * SETTINGS.PLAYER.SPEED * direction
	local move_dy = sin_rad(player.rot) * SETTINGS.PLAYER.SPEED * direction

	player.x += move_dx
	if collide() then
		printh("Collision on x detected at: " .. player.x)
		player.x -= move_dx
	end

	player.y += move_dy
	if collide() then
		printh("Collision on y detected at: " .. player.y)
		player.y -= move_dy
	end

	return true
end

function collide()
	map_x = flr(player.x)
	map_y = flr(player.y)
	return map:get_tile(map_x, map_y) > 0
end