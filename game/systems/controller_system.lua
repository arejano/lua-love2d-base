--@type System
local ControllerSystem = {
  data = {
    player = nil
  },
  name = 'ControllerSystem',
  name_error = 'ControllerSystem',
  states = { GAME_STATE.Running },
  events = { GAME_EVENT.Keyboard, GAME_EVENT.Mouse, }
}


local ce_to_direction = {
  [CONTROL_EVENT.TurnUp] = "Up",
  [CONTROL_EVENT.TurnDown] = "Down",
  [CONTROL_EVENT.TurnLeft] = "Left",
  [CONTROL_EVENT.TurnRight] = "Right",
}

local move_keys = {
  "a", "w", "s", "d"
}

---@param w Ecs
function ControllerSystem:start(w)
  w.counters[self.name] = 0
  w.counters[self.name_error] = 0
end

---@param w Ecs
---@param dt number
---@param game_event ControllerEvent
function ControllerSystem:process(w, dt, game_event)
  -- Faz o controller so dar update no contador quando a tecla eh pressionada
  -- se nao ele contaria duas vezes keyDown/keyUp
  if game_event.data.pressed then
    w.counters[self.name] = w.counters[self.name] + 1
  end

  if self.data.player == nil then
    local entity = w:query({ CTS.Player })[1]

    if entity == nil then
      print("Entidade nao encontrada: " .. self.name)
    else
      self.data.player = entity
    end
  end

  -- -@type PositionData
  -- local position = w:get_component(self.data.player, CTS.Position).data
  -- local speed = w:get_component(self.data.player, CTS.Speed).data


  local direction = w:get_component(self.data.player, CTS.Direction)
  local player_state = w:get_component(self.data.player, CTS.PlayerState)

  --update direction
  -- direction.data = ce_to_direction[e.event]


  if Love.keyboard.isDown("a") and Love.keyboard.isDown("w") then
    direction.data = "TopLeft"
  elseif Love.keyboard.isDown("w") and Love.keyboard.isDown("d") then
    direction.data = "TopRight"
  elseif Love.keyboard.isDown("d") and Love.keyboard.isDown("s") then
    direction.data = "BottomRight"
  elseif Love.keyboard.isDown("a") and Love.keyboard.isDown("s") then
    direction.data = "BottomLeft"
  elseif Love.keyboard.isDown("a") then
    direction.data = "Left"
  elseif Love.keyboard.isDown("w") then
    direction.data = "Up"
  elseif Love.keyboard.isDown("d") then
    direction.data = "Right"
  elseif Love.keyboard.isDown("s") then
    direction.data = "Down"
  end


  --update direction
  if direction ~= nil then
    w:set_component(self.data.player, CTS.Direction, direction.data)
  end

  --update player_state
  if player_state ~= nil then
    player_state.data = self:update_state(player_state, game_event)
    w:set_component(self.data.player, CTS.PlayerState, player_state.data)
  end
end

---@param event ControllerEvent
---@return any
function ControllerSystem:update_state(state, event)
  if event.data.pressed == true then
    state.data = "Walking"
  else
    state.data = "Stay"
  end
  return state.data
end

return ControllerSystem
