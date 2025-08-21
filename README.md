# Admin Car Command

Get any vehicle and save it to your garage instantly with `/admincar` - no need to get in the vehicle!

## Quick Start
1. Download & extract to `resources/[standalone]/admincar`
2. Add `ensure admincar` to server.cfg
3. Configure permissions in `config.lua`
4. Restart server

## Usage
- `/admincar` - Save the vehicle you're looking at to your garage
- `/admincar [playerId]` - Give the vehicle to another player

## Features
- Save any vehicle without entering it
- Instant vehicle keys
- Transfer vehicles to other players
- Works with all vehicle types

## Requirements
- Qbox Core
- ox_lib

## Configuration
```lua
config = {
    saveVehicle = 'admin'  -- Permission level required
}
```

## License
MIT
