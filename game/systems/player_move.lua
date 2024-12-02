---@type System
local PlayerMoveSystem = {
  data = {
    player = nil
  },
  name = 'PlayerMoveSystem',
  states = { GAME_STATE.Running },
  events = { GAME_EVENT.Tick }
}

local ce_to_direction = {
  [CONTROL_EVENT.TurnUp] = "Up",
  [CONTROL_EVENT.TurnDown] = "Down",
  [CONTROL_EVENT.TurnLeft] = "Left",
  [CONTROL_EVENT.TurnRight] = "Right",
}

---@param w Ecs
function PlayerMoveSystem:start(w)
  w.counters[self.name] = 0
end

---@param w Ecs
---@param dt number
---@param e NewEvent
function PlayerMoveSystem:process(w, dt, e)
  if self.data.player == nil then
    local entity = w:query({ CTS.Player })[1]

    if entity == nil then
      print("Entidade nao encontrada: " .. self.name)
    else
      self.data.player = entity
    end
  end

  local player_state = w:get_component(self.data.player, CTS.PlayerState)

  if player_state.data == "Walking" then
    w.counters[self.name] = w.counters[self.name] + 1
  else
    return
  end

  ---@type PositionData
  local position = w:get_component(self.data.player, CTS.Position).data
  local speed = w:get_component(self.data.player, CTS.Speed).data
  local direction = w:get_component(self.data.player, CTS.Direction)

  -- --update direction
  -- direction.data = ce_to_direction[e.event]

  local ce = CONTROL_EVENT

  -- --update position

  if player_state ~= nil and player_state.data == "Walking" and direction ~= nil then
    if direction.data == "Left" then
      position.x = position.x - (speed * dt)
    end

    if direction.data == "Up" then
      position.y = position.y - (speed * dt)
    end

    if direction.data == "Down" then
      position.y = position.y + (speed * dt)
    end
    if direction.data == "Right" then
      position.x = position.x + (speed * dt)
    end
  end
end

function PlayerMoveSystem:destroy()
end

return PlayerMoveSystem
