# PICO-8 Raycasting Engine

A Wolfenstein 3D-style raycasting engine implementation for PICO-8.

## Project Structure

```
carts/raycasting/
├── main.lua          # Main game loop and rendering
├── raycasting.lua     # Core raycasting algorithm (DDA)
├── player.lua         # Player movement and collision
├── map.lua           # Level map data and structure
├── math.lua          # Mathematical utilities and angle conversion
├── const.lua         # Constants (screen, colors, math)
├── settings.lua      # Game configuration
├── util.lua          # General utility functions
└── pico-raycast.p8   # Compiled PICO-8 cartridge
```

## Core Components

### Raycasting Engine (`raycasting.lua`)

- **DDA Algorithm**: Digital Differential Analyzer for efficient ray-grid traversal
- **Wall Detection**: Identifies wall hits and calculates distances
- **Perspective Correction**: Prevents fisheye distortion using perpendicular wall distance

### Player System (`player.lua`)

- Movement and rotation with collision detection
- Spawns at map position marked with `-1`

### Rendering Pipeline (`main.lua`)

- Sky/floor background (blue/brown)
- Wall rendering with vertical line strips
- Mathematically correct projection using configurable distance

## Map Format

10x10 grid in `MAP1.GRID`:

- `0` = Empty space (walkable)
- `1` = Wall (colored blocks)
- `-1` = Player spawn point

## Configuration

Settings are defined in `settings.lua`:

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
- `normalize_angle()` - Angle wrapping
- `turns_to_rad()` / `rads_to_turns()` - Unit conversion

## Controls

- **Left/Right Arrow**: Turn
- **Up/Down Arrow**: Move forward/backward

## Customization

- Modify `MAP1.GRID` in `map.lua` to create new levels
- Adjust `SETTINGS.FOV` for different viewing angles (current: 53.13° optimal)
- Change `SETTINGS.HEIGHT_SCALE` to scale wall heights
- Modify `SETTINGS.PLAYER.SPEED` and `TURN_SPEED` for movement responsiveness
- Add new wall colors by updating map values

---

_A tribute to the classic Wolfenstein 3D engine, adapted for PICO-8._
