function cast_ray(px, py, ray_angle, player_rotation)
	ray_dx = cos_rad(ray_angle)
	ray_dy = sin_rad(ray_angle)

	map_x = flr(px)
	map_y = flr(py)

	delta_dist_x = ray_dx != 0 and abs(1 / ray_dx) or MAX_NUM
	delta_dist_y = ray_dy != 0 and abs(1 / ray_dy) or MAX_NUM

	if ray_dx < 0 then
		step_x = -1
		side_dist_x = (px - map_x) * delta_dist_x
	else
		step_x = 1
		side_dist_x = (map_x + 1 - px) * delta_dist_x
	end

	if ray_dy < 0 then
		step_y = -1
		side_dist_y = (py - map_y) * delta_dist_y
	else
		step_y = 1
		side_dist_y = (map_y + 1 - py) * delta_dist_y
	end

	hit = false
	while not hit do
		if side_dist_x < side_dist_y then
			side_dist_x += delta_dist_x
			map_x += step_x
			side = 0 -- X side
		else
			side_dist_y += delta_dist_y
			map_y += step_y
			side = 1 -- Y side
		end

		temp_dist_x = px

		if map_x < 1 or map_x > map.SIZE or map_y < 1 or map_y > map.SIZE then
			hit = true
		elseif map:get_tile(map_x, map_y) > 0 then
			hit = true
		end
	end

	if side == 0 then
		-- X-side hit (vertical wall)
		direction_sign = (1 - step_x) / 2
		ray_dist = (map_x - px + direction_sign) / ray_dx
		-- Texture coordinate: Y position where ray hits the wall
		wall_hit_y = py + ray_dist * ray_dy
		texture_coord = wall_hit_y - flr(wall_hit_y) -- Fractional part
	else
		-- Y-side hit (horizontal wall)
		direction_sign = (1 - step_y) / 2
		ray_dist = (map_y - py + direction_sign) / ray_dy
		-- Texture coordinate: X position where ray hits the wall
		wall_hit_x = px + ray_dist * ray_dx
		texture_coord = fractional(wall_hit_x) -- Fractional part
	end

	diff_angle = normalize_angle(ray_angle - player_rotation)
	perp_wall_dist = ray_dist * cos_rad(diff_angle)
	perp_wall_dist = abs(perp_wall_dist)

	return perp_wall_dist, texture_coord, { map_x, map_y }
end