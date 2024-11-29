---@alias GameState "Menu"|"Running"|"Paused"|"Configuration"

local game_states = MakeEnum({
  "Menu",
  "Running",
  "Paused",
  "Configuration"
})

return game_states
