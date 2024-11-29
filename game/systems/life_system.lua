---@type System
local PlayerLifeSystem = {
  name = 'PlayerLifeSystem',
  states = { GAME_STATE.Running },
  events = { GAME_EVENT.Tick, },
  start = nil,
  process = nil,
  destroy = nil,
}


---@param w Ecs
function PlayerLifeSystem:start(w)
  w.counters[self.name] = 0
end

---@param w Ecs
---@param dt number
function PlayerLifeSystem:process(w, dt, e)
  w.counters[self.name] = w.counters[self.name] + 1
end

function PlayerLifeSystem:destroy()
end

return PlayerLifeSystem
