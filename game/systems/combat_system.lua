
---@type System
local PlayerCombatSystem = {
  name = 'PlayerCombatSystem',
  states = { GAME_STATE.Running },
  events = { GAME_EVENT.Combat,}
}


---@param w Ecs
function PlayerCombatSystem:start(w)
  w.counters[self.name] = 0
end

---@param w Ecs
---@param dt number
function PlayerCombatSystem:process(w, dt, e)
  w.counters[self.name] = w.counters[self.name] + 1
end

function PlayerCombatSystem:destroy()
end

return PlayerCombatSystem
