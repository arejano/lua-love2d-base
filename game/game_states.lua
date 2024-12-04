---@alias GameState "Menu"|"Running"|"Paused"|"Configuration"

local game_states = MakeEnum({
  "Menu",
  "Running",
  "Paused",
  "Configuration"
})

local player_states = MakeEnum({
  "Walk",
  "Stay",
  "Jump"
})

return game_states, player_states
