#include ./math.lua
#include ./const.lua
#include ./map.lua
#include ./util.lua
#include ./settings.lua

SETTINGS.FOV = 0.9272952

SETTINGS.FOV = 0.9272952

SETTINGS.FOV = 0.9272952

SETTINGS.FOV = 0.9272952

SETTINGS.FOV = 0.9272952

SETTINGS.FOV = 0.9272952
#include ./player.lua
#include ./raycasting.lua

function _init()
	player_init()
end

function _update()
	player_update()
end

function _draw()
	cls(0)
	rectfill(SCREEN.LEFT, SCREEN.TOP, SCREEN.RIGHT, SCREEN.MIDDLE - 1, COLORS.BLUE)
	rectfill(SCREEN.LEFT, SCREEN.MIDDLE, SCREEN.RIGHT, SCREEN.BOTTOM, COLORS.BROWN)

	for i = 0, SCREEN.RIGHT do
		local ray_angle = player.rot - SETTINGS.FOV / 2 + i * SETTINGS.FOV / SCREEN.RIGHT
		ray_angle = normalize_angle(ray_angle)
		local perp_wall_dist, side, map_coords = cast_ray(player.x, player.y, ray_angle, player.rot, MAP1.GRID)

		wall_color = MAP1.GRID[map_coords[1]][map_coords[2]]

		if wall_color > 0 then
			local wall_height = SETTINGS.HEIGHT_SCALE / perp_wall_dist
			local wall_top = SCREEN.MIDDLE - wall_height / 2
			local wall_bottom = SCREEN.MIDDLE + wall_height / 2
			rectfill(i, wall_top, i + 1, wall_bottom, wall_color)
		end
	end

	player_draw()
end