---@alias GameEvent "Keyboard"|"Mouse"|"Tick"|"Combat"|"RunMoveSystem"

local game_event = MakeEnum({
  "Keyboard",
  "Mouse",
  "Tick",
  "Combat",
  "RunMoveSystem",
  "Render",
})

return game_event
