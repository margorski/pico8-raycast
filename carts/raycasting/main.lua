function _init()
	palt(0, false)
	player_init()
end

function _update()
	player_update()
end

function _draw()
	cls(0)
	rectfill(SCREEN.LEFT, SCREEN.TOP, SCREEN.RIGHT, SCREEN.MIDDLE - 1, COLORS.BLUE)
	rectfill(SCREEN.LEFT, SCREEN.MIDDLE, SCREEN.RIGHT, SCREEN.BOTTOM, COLORS.DARK_BLUE)

	for x = 0, SCREEN.RIGHT do
		local ray_angle = player.rot - SETTINGS.FOV / 2 + x * SETTINGS.FOV / SCREEN.RIGHT
		ray_angle = normalize_angle(ray_angle)
		local perp_wall_dist, texture_coord, map_coords = cast_ray(player.x, player.y, ray_angle, player.rot)

		wall = map:get_tile(map_coords[1], map_coords[2])
		if wall > 0 then
			local wall_height = SETTINGS.HEIGHT_SCALE / perp_wall_dist
			local wall_top = SCREEN.MIDDLE - wall_height / 2
			local wall_bottom = SCREEN.MIDDLE + wall_height / 2

			if wall > 0 and wall < 5 then
				_draw_texture(wall, x, texture_coord, wall_top, wall_bottom)
			else
				_draw_color(wall, x, wall_top, wall_bottom)
			end
		end
	end

	player_draw()
end

function _draw_texture(wall, x, side_dist, wall_top, wall_bottom)
	TEXTURE_SIZE = 32
	texture_x = flr(side_dist * TEXTURE_SIZE)
	sspr((wall - 1) * TEXTURE_SIZE + texture_x, 0, 1, TEXTURE_SIZE, x, wall_top, 1, wall_bottom - wall_top)
end

function _draw_color(wall, x, wall_top, wall_bottom)
	rectfill(x, wall_top, x + 1, wall_bottom, wall)
end