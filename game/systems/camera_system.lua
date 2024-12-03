---@alias CameraData { camera : Camera|nil, player : number|any}


---@class CameraSystem
---@field data CameraData
local CameraSystem = {
  data = {
    camera = nil,
    player = nil,
  },
  name = 'CameraSystem',
  states = { GAME_STATE.Running },
  events = { GAME_EVENT.Render }

}


---@param w Ecs
function CameraSystem:start(w)
  ---@type Camera
  self.data.camera = Camera:new(0, 0, 1, 0)
  w:add_resource("Camera", self.data.camera)
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

  local player_position = w:get_component(self.data.player, CTS.Position).data

  ---@type Camera
  self.data.camera:setPosition(player_position.x, player_position.y);

  w.counters[self.name] = w.counters[self.name] + 1
end

function CameraSystem:destroy()
end

return CameraSystem
