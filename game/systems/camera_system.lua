local CameraSystem = {
  data = {
    camera_entity = nil,
    player = nil,
  },
  name = 'CameraSystem',
  states = { GAME_STATE.Running },
  events = { GAME_EVENT.Render }

}


---@param w Ecs
function CameraSystem:start(w)
  w.counters[self.name] = 0
end

---@param w Ecs
---@param dt number
---@param e NewEvent
function CameraSystem:process(w, dt, e)
  if self.data.player == nil then
    local entity = w:query({ CTS.Player })[1]

    if entity == nil then
      return
    else
      self.data.player = entity
    end
  end

  if self.data.camera_entity == nil then
    local entity = w:query({ CTS.Camera })[1]

    if entity == nil then
      return
    else
      self.data.camera_entity = entity
    end
  end


  --process

  local camera_position = w:get_component(self.data.camera_entity, CTS.Position).data
  local player_position = w:get_component(self.data.camera_entity, CTS.Position).data

  w.counters[self.name] = w.counters[self.name] + 1
end

function CameraSystem:destroy()
end

return CameraSystem
