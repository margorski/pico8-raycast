# PICO-8 Raycasting Engine

A Wolfenstein 3D-style raycasting engine implementation for PICO-8 with texture mapping support.

## Project Structure

```
carts/raycasting/
├── main.lua          # Main game loop and rendering pipeline
├── raycasting.lua     # Core raycasting algorithm (DDA) with texture coordinates
├── player.lua         # Player movement, rotation, and collision detection
├── map2.lua           # 32x32 labyrinth map with multiple themed rooms
├── math.lua          # Mathematical utilities and angle conversion
├── const.lua         # Constants (screen, colors, math)
├── settings.lua      # Game configuration and FOV settings
├── util.lua          # General utility functions
└── pico-raycast.p8   # Compiled PICO-8 cartridge
```

## Core Features

### Raycasting Engine (`raycasting.lua`)

- **DDA Algorithm**: Digital Differential Analyzer for efficient ray-grid traversal
- **Wall Detection**: Identifies wall hits and calculates precise distances
- **Fisheye Correction**: Prevents distortion using perpendicular wall distance with cosine projection
- **Texture Coordinate Calculation**: Stable texture mapping using exact ray-wall intersection points

### Dual Rendering System (`main.lua`)

- **Textured Walls**: Walls with values 1-4 render with sprite-based textures
- **Colored Walls**: Other wall values render as solid colored rectangles
- **Background Rendering**: Sky (blue) and floor (dark blue) with horizon line

### Player System (`player.lua`)

- Movement and rotation with collision detection
- Spawns at map position marked with `-1`

### Rendering Pipeline (`main.lua`)

- Sky/floor background (blue/brown)
- Wall rendering with vertical line strips
- Mathematically correct projection using configurable distance

## Map Format

32x32 grid in `map.GRID`:

- `0` = Empty space (walkable)
- `1-4` = Textured walls (render with sprites)
- `>5` = Colored walls
- `-1` = Player spawn point

## Configuration

Settings in `settings.lua`:

```lua
SETTINGS = {
    HEIGHT_SCALE = 128,   -- Wall height scaling factor
    PLAYER = {
        SPEED = 0.1,      -- Player movement speed
        TURN_SPEED = 0.05 -- Player rotation speed
    },
    FOV = 0.9272952       -- Field of view in radians (≈53.13°)
}
```

The FOV value of 0.9272952 radians (≈53.13°) is mathematically calculated for optimal projection:

- Based on `2 * atan(screen_width / (2 * projection_distance))`
- For 128x128 screen: provides natural perspective without distortion

## Mathematical Implementation

**Radians vs PICO-8 Turns**: The engine uses radians for all angle calculations instead of PICO-8's native turn units (0.0-1.0). Conversion functions in `math.lua`:

- `sin_rad()` / `cos_rad()` - Radian-based trigonometry
- `normalize_angle()` - Proper angle wrapping
- `fractional()` - Clean floating-point fraction extraction
- **DDA to Perpendicular Distance**: `perp_dist = ray_dist * cos(ray_angle - player_angle)`

**Texture Coordinate Calculation**:

- **Vertical Walls**: `texture_coord = fractional(wall_hit_y)`
- **Horizontal Walls**: `texture_coord = fractional(wall_hit_x)`
- **Precision**: Uses exact intersection geometry, not accumulated step distances

## Controls

- **Left/Right Arrow**: Turn
- **Up/Down Arrow**: Move forward/backward

## Customization

- Modify `MAP1.GRID` in `map.lua` to create new levels
- Adjust `SETTINGS.FOV` for different viewing angles (current: 53.13° optimal)
- Change `SETTINGS.HEIGHT_SCALE` to scale wall heights
- Modify `SETTINGS.PLAYER.SPEED` and `TURN_SPEED` for movement responsiveness
- Add new wall colors by updating map values

## TODO

- [ ] Door and switches
- [ ] Collectible items
- [ ] Enemies
- [ ] Draw weapon and HUD
- [ ] HP, bullets and points logic
- [ ] Movement adjustments (running, better collisions)
- [ ] Sound
- [ ] Dynamic lights
- [ ] Multiple maps
- [ ] Beginning and ending
- [ ] Main menu

---

_A tribute to the classic Wolfenstein 3D engine, adapted for PICO-8._
