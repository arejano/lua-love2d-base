-- Systems
require 'game.game_globals'

local pms = require 'game.systems.player_move'
local pls = require 'game.systems.life_system'
local pcs = require 'game.systems.combat_system'

local controller_system = require 'game.systems.controller_system'

---@class Game
---@field world Ecs
game = { world = Ecs:new(), }
game.__index = game;
function game:new()
  local self = setmetatable({}, game)

  --Set running and pause state
  self.world:set_state(GAME_STATE.Running, GAME_STATE.Paused)

  self.world:add_system(pms)
  self.world:add_system(pls)
  self.world:add_system(pcs)
  self.world:add_system(controller_system)

  self.world:add_entity({
    { type = CTS.Player,      data = true },
    { type = CTS.Position,    data = { x = 0, y = 0, z = 0 } },
    { type = CTS.Speed,       data = 5 },
    { type = CTS.Direction,   data = "Right" },
    { type = CTS.PlayerState, data = "Walking" },
  })

  return self
end

---@param key string
---@param code string
---@param pressed boolean
function game:process_key(key, code, pressed)
  -- if keys[key] ~= nil then
  --   keys[key](self.world)
  -- end

  ---@type NewEvent
  local new_event = {
    type = GAME_EVENT.Keyboard,
    state = GAME_STATE.Running,
    data = {
      key = key,
      code = code,
      pressed = pressed
    }
  }
  self.world:add_event(new_event)
end

---@param dt number
function game:update(dt)
  -- Para nao ter processamento desnecessario
  if self.world.actual_state == GAME_STATE.Paused then
    return
  end
  local new_event = {
    type = GAME_EVENT.Tick,
    state = GAME_STATE.Running,
    event = nil
  }
  self.world:add_event(new_event)
  self.world:update(dt)
end

return game
